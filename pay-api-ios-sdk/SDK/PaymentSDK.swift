//
//  PaymentSDK.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 30.04.2021.
//

import UIKit
import Marshal
import Promise

public protocol PaymentSDKDelegate: class {
    
    ///show custom enter code form to proceed host-2-host
    func paymentSDKNeedCodeToProceedHostToHost(transactionID: Int, codeType: VerificationCode)
    
    ///sdk did fail for some reason
    func paymentSDKDidFail(with error: Error, request: RequestType)
    
    ///sdk did finish host-2-host or card tokenization
    func paymentSDKDidFindTransaction(with response: FindTransactionResponseData)
    
    ///sdk did create transaction for card tokenization, p2p transfer, payment page services
    func paymentSDKDidCreateTransaction(with response: CreateTransactionResponseData)
    
    func paymentSDKDidCancelTransaction(with response: CancelTransactionResponseData)
}

extension PaymentSDKDelegate {
    
    func paymentSDKNeedCodeToProceedHostToHost(transactionID: Int, codeType: VerificationCode) {}
    
}

public class PaymentSDK: NSObject, NetworkStateProtocol, TransactionUsecase {
    
    //MARK: - Shared
    
    public static var shared = PaymentSDK()
    
    //MARK: - TransactionUsecase
    
    lazy var transactionNetworkComponent: TransactionNetworkHandlerComponent = {
        let component = TransactionNetworkHandlerComponent()
        component.delegate = self
        return component
    }()
    
    //MARK: - NetworkStateProtocol
    
    var state: State = .none {
        willSet {
            update(newState: newValue)
        }
    }
    
    func update(newState: State) {
        switch (state, newState) {
        case ( _, .loading):
            break
        case (_, .success):
            break
        case (_, .finish(_)):
            break
        case (_, .failure(let error, let request)):
            self.dismissPaymentNavigationIfNeeded {
                self.delegate?.paymentSDKDidFail(with: error, request: request)
            }
            break
        default:
            break
        }
    }
    
    //MARK: - Properties
    
    public var locale: Locale = .ua
    
    /// used for 3Ds verification
    public var termUrl: URL? {
        didSet {
            self.hostToHostService.termURL = self.termUrl
        }
    }
    
    /// url used to redirect user after transaction authentication completes
    public var returnUrl: URL?
    
    /// url used for callbacks user after transaction authentication completes
    public var callBackUrl: URL?
    
    /// url used for redirecting user on successful operation
    public var successUrl: URL?
    
    /// url used for redirecting user if operation failed
    public var failureUrl: URL?
    
    /// url used for canceled operations
    public var cancelUrl: URL?
    
    
    public var shouldShowLookUpEnterForm: Bool = false {
        didSet {
            self.hostToHostService.shouldShowLookUpEnterForm = self.shouldShowLookUpEnterForm
        }
    }
    
    public var shouldShowOTPEnterForm: Bool = false {
        didSet {
            self.hostToHostService.shouldShowOTPEnterForm = self.shouldShowOTPEnterForm
        }
    }
    
    /// define if sdk handle payUrl on its own for card tokenization
    public var shouldShowWebPageForTokenizationService: Bool = true
    
    /// define if sdk handle payUrl on its own for card to card
    public var shouldShowWebPageForCardToCardService: Bool = true
    
    /// define if sdk handle payUrl on its own for payment page
    public var shouldShowWebPageForPaymentPageService: Bool = true
    
    public weak var navigation: UINavigationController?
    
    private lazy var webViewController: WebViewController = {
        let controller = WebViewController.storyboardInstance()!
        controller.delegate = self
        return controller
    }()
    
    private lazy var paymentControllerNavigation: UINavigationController = {
        let payNavigation = BillioPayViewController.navigationController()!
        payNavigation.showBackButton()
        return payNavigation
    }()
    
    private var isPaymentNavigationPresented: Bool = false
    
    public weak var delegate: PaymentSDKDelegate?
    
    ///delegate for host-2-host service
    public weak var hostToHostDelegate: HostToHostServiceDelegate? {
        didSet {
            self.hostToHostService.delegate = self.hostToHostDelegate
        }
    }
        
    //MARK: - Services
    
    private var hostToHostService: HostToHostService!
    
    private var tokenizationService: CardTokenizationService!
    
    private var cardToCardTransferService: CardTransferService!
    
    private var paymentPageService: PaymentPageService!
    
    //MARK: - Initialization
    
    public override init() {
        super.init()
        self.configureServices()
    }
    
    //MARK: - Configure
    
    private func configureServices() {
        self.configureHostToHostService()
        self.configureTokenizationService()
        self.configureCardToCardTransferService()
        self.configurePaymentPageService()
    }
    
    private func configureHostToHostService() {
        let service = HostToHostService(with: self.transactionNetworkComponent)
        service.redirectCallback = { [weak self] (redirectUrl, transactioID) in
            self?.proceedRedirect(url: redirectUrl, transactionID: transactioID)
        }
        service.htmlRedirectCallback = { [weak self] (html, transactionID, md) in
            self?.proceedHtmlRedirect(html: html, transactionID: transactionID, md: md)
        }
        service.enterCodeCallback = { [weak self] (transactionID, codeType, completion) in
            (self?.isPaymentNavigationPresented == true ? self?.paymentControllerNavigation : self?.navigation)?.presentEnterForm(title: codeType.title, completion: { (code) in
                completion(code)
            })
        }
        service.customCodeEnterCallback = { [weak self] (transactionID, codeType) in
            self?.delegate?.paymentSDKNeedCodeToProceedHostToHost(transactionID: transactionID, codeType: codeType)
        }
        service.finishOperationCallback = { [weak self] (completion) in
            self?.dismissPaymentNavigationIfNeeded {
                completion()
            }
        }
        self.hostToHostService = service
    }
    
    private func configureTokenizationService() {
        let service = CardTokenizationService(with: self.transactionNetworkComponent)
        service.payURLCallback = { [weak self] (payURL, transactionID, externalTransactionID) in
            if self?.shouldShowWebPageForTokenizationService == true {
                self?.proceedRedirect(url: payURL, transactionID: transactionID, externalTransactionID: externalTransactionID)
            }
        }
        service.createTransactionCallBack = { [weak self] (response) in
            self?.delegate?.paymentSDKDidCreateTransaction(with: response)
        }
        self.tokenizationService = service
    }
    
    private func configureCardToCardTransferService() {
        let service = CardTransferService(with: self.transactionNetworkComponent)
        service.payURLCallback = { [weak self] (payURL, transactionID, externalTransactionID) in
            if self?.shouldShowWebPageForCardToCardService == true {
                self?.proceedRedirect(url: payURL, transactionID: transactionID, externalTransactionID: externalTransactionID)
            }
        }
        service.createTransactionCallBack = { [weak self] (response) in
            self?.delegate?.paymentSDKDidCreateTransaction(with: response)
        }
        self.cardToCardTransferService = service
    }
    
    private func configurePaymentPageService() {
        let service = PaymentPageService(with: self.transactionNetworkComponent)
        service.payURLCallback = { [weak self] (payURL, transactionID, externalTransactionID) in
            if self?.shouldShowWebPageForPaymentPageService == true {
                self?.proceedRedirect(url: payURL, transactionID: transactionID, externalTransactionID: externalTransactionID)
            }
        }
        service.createTransactionCallBack = { [weak self] (response) in
            self?.delegate?.paymentSDKDidCreateTransaction(with: response)
        }
        self.paymentPageService = service
    }
    
    public func configure(accountID: Int, walletID: Int, pointID: Int, authToken: String, naviagation: UINavigationController) {
        self.navigation = naviagation
        self.configureAuthManager(accountID: accountID, walletID: walletID, pointID: pointID, authToken: authToken)
    }
        
    private func configureAuthManager(accountID: Int, walletID: Int, pointID: Int, authToken: String) {
        Core.shared.authManager.configure(accountID: accountID, walletID: walletID, pointID: pointID, authToken: authToken)
    }
    
    //MARK: - Public
    
    public func updateTransaction(transactionID: Int, code: String, codeType: VerificationCode) {
        self.hostToHostService.updateTransaction(transactionID: transactionID, code: code, codeType: codeType)
    }
    
    public func presentPaymentController(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, controllerTitle: String?, style: UIModalPresentationStyle) {
        let controller = self.paymentControllerNavigation.rootViewController as! BillioPayViewController
        controller.externalTransactionID = externalTransactionID
        controller.externalOrderID = externalOrderID
        controller.externalCustomerID = externalCustomerID
        controller.transactionAmount = amount
        controller.amountCurrency = amountCurrency
        controller.serviceID = serviceID
        controller.transactionDescription = description
        if let title = controllerTitle {
            controller.controllerTitle = title
        }
        self.paymentControllerNavigation.modalPresentationStyle = style
        self.paymentControllerNavigation.presentationController?.delegate = self
        self.navigation?.present(self.paymentControllerNavigation, animated: true) { [weak self] in
            self?.isPaymentNavigationPresented = true
        }
    }

    func getPayPoint() -> PayPoint {
        return PayPoint(callbackURL: self.callBackUrl?.description, successURL: self.successUrl?.description, failURL: self.failureUrl?.description, cancelURL: self.cancelUrl?.description, returnURL: self.returnUrl?.description)
    }
    
    //MARK: - Host-2-Host service
    
    public func hostToHost(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, fields: HostToHostFields) {
        let point = PayPoint(callbackURL: self.callBackUrl?.description, successURL: self.successUrl?.description, failURL: self.failureUrl?.description, cancelURL: self.cancelUrl?.description, returnURL: self.returnUrl?.description)
        self.hostToHostService.hostToHost(externalTransactionID: externalTransactionID, externalOrderID: externalOrderID, externalCustomerID: externalCustomerID, amount: amount, amountCurrency: amountCurrency, serviceID: serviceID, description: description, fields: fields, point: point, locale: self.locale.rawValue)
    }
    
    //MARK: - Tokenization service
    
    public func tokenizeCard(externalTransactionID: String, externalCustomerID: String?, serviceID: Int, description: String?) {
        let point = PayPoint(callbackURL: self.callBackUrl?.description, successURL: self.successUrl?.description, failURL: self.failureUrl?.description, cancelURL: self.cancelUrl?.description, returnURL: self.returnUrl?.description)
        self.tokenizationService.tokenizeCard(locale: self.locale.rawValue, externalTransactionID: externalTransactionID, externalCustomerID: externalCustomerID, serviceID: serviceID, description: description, point: point)
    }
    
    //MARK: - Card to card transfer service
    
    public func p2pTransfer(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, recipientCardNumber: String, extra: JSONObject?) {
        let point = PayPoint(callbackURL: self.callBackUrl?.description, successURL: self.successUrl?.description, failURL: self.failureUrl?.description, cancelURL: self.cancelUrl?.description, returnURL: self.returnUrl?.description)
        self.cardToCardTransferService.p2pTransfer(locale: self.locale.rawValue, externalTransactionID: externalTransactionID, externalOrderID: externalOrderID, externalCustomerID: externalCustomerID, amount: amount, amountCurrency: amountCurrency, serviceID: serviceID, description: description, recipientCardNumber: recipientCardNumber, point: point, extra: extra)
    }
    
    //MARK: - Payment page service
    
    public func createPaymentPage(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, extra: JSONObject?, shouldTokenizeCard: Bool) {
        let point = PayPoint(callbackURL: self.callBackUrl?.description, successURL: self.successUrl?.description, failURL: self.failureUrl?.description, cancelURL: self.cancelUrl?.description, returnURL: self.returnUrl?.description)
        self.paymentPageService.createPayment(locale: self.locale.rawValue, externalTransactionID: externalTransactionID, externalOrderID: externalOrderID, externalCustomerID: externalCustomerID, amount: amount, amountCurrency: amountCurrency, serviceID: serviceID, description: description, point: point, extra: extra, shouldTokenizeCard: shouldTokenizeCard)
    }
    
    public func createPaymentPage(cardToken: String, externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, extra: JSONObject?) {
        let point = PayPoint(callbackURL: self.callBackUrl?.description, successURL: self.successUrl?.description, failURL: self.failureUrl?.description, cancelURL: self.cancelUrl?.description, returnURL: self.returnUrl?.description)
        self.paymentPageService.createPayment(cardToken: cardToken, locale: self.locale.rawValue, externalTransactionID: externalTransactionID, externalOrderID: externalOrderID, externalCustomerID: externalCustomerID, amount: amount, amountCurrency: amountCurrency, serviceID: serviceID, description: description, point: point, extra: extra)
    }
    
    //MARK: - Additional
    
    public func createTransaction(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, fields: JSONObject?, extra: JSONObject?, completion: @escaping(CreateTransactionResponseData) -> ()) {
        guard let ip = IPAdressHelper.shared.getWiFiAddress(),
              let accountID = Core.shared.authManager.getAccountID(),
              let walletID = Core.shared.authManager.getWalletID()
              else {
            return
        }
        let point = self.getPayPoint()
        self.transactionNetworkComponent.createTransaction(locale: self.locale.rawValue, externalTransactionID: externalTransactionID, externalOrderID: externalOrderID, externalCustomerID: externalCustomerID, customerIPAdress: ip, amount: amount, amountCurrency: amountCurrency, serviceID: serviceID, accountID: accountID, walletID: walletID, description: description, fields: fields, point: point, extra: extra, completion: completion) 
    }
    
    public func cancelTransaction(transactionID: Int) {
        self.cancelTransaction(transactionID: transactionID) { (response) in
            self.delegate?.paymentSDKDidCancelTransaction(with: response)
        }
    }
    
    public func updateTransaction(transactionID: Int, auth: AuthorizationData, completion: @escaping(UpdateTransactionResponseData) -> ()) {
        self.transactionNetworkComponent.updateTransaction(transactionID: transactionID, authData: auth, completion: completion)
    }
    
    public func findTransaction(transactionID: Int, externalTransactionID: String?, completion: @escaping(FindTransactionResponseData) -> ()) {
        self.transactionNetworkComponent.findTransaction(transactionID: transactionID, externalTransactionID: externalTransactionID, completion: completion)
    }
    
    //MARK: - Private
    
    private func proceedRedirect(url: URL, transactionID: Int, externalTransactionID: String? = nil) {
        self.webViewController.url = url
        self.webViewController.transactionID = transactionID
        self.webViewController.externalTransactionID = externalTransactionID
        (self.isPaymentNavigationPresented ? self.paymentControllerNavigation : self.navigation)?.pushViewController(self.webViewController, animated: true)
    }
    
    private func proceedHtmlRedirect(html: String, transactionID: Int, md: Int) {
        self.webViewController.htmlString = html
        self.webViewController.md = md
        self.webViewController.transactionID = transactionID
        (self.isPaymentNavigationPresented ? self.paymentControllerNavigation : self.navigation)?.pushViewController(self.webViewController, animated: true)
    }
    
    private func dismissPaymentNavigationIfNeeded(completion: @escaping() -> Void) {
        if self.isPaymentNavigationPresented == true {
            self.isPaymentNavigationPresented = false
            DispatchQueue.main.async {
                self.paymentControllerNavigation.popToRootViewController(animated: false)
                self.paymentControllerNavigation.dismiss(animated: true) {
                    completion()
                }
            }
            return
        }
        completion()
    }
    
}

//MARK: - WebViewControllerDelegate
extension PaymentSDK: WebViewControllerDelegate {
    
    func didReceive(paRes: String?, for transactionID: Int?, md: Int?) {
        (self.isPaymentNavigationPresented ? self.paymentControllerNavigation : self.navigation)?.popViewController(animated: true)
        if let pares = paRes, let id = transactionID, let md = md {
            self.hostToHostService.updateTransaction(paRes: pares, for: id, md: md)
        }
    }
    
    func didCompleteRedirect(for transactionID: Int?, externalTransactionID: String?) {
        self.hostToHostService.findTransaction(transactionID: transactionID, externalTransactionID: externalTransactionID) { (response) in
            self.dismissPaymentNavigationIfNeeded {
                self.delegate?.paymentSDKDidFindTransaction(with: response)
            }
        }
    }
}

//MARK: - UIAdaptivePresentationControllerDelegate
extension PaymentSDK: UIAdaptivePresentationControllerDelegate {
    
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.isPaymentNavigationPresented = false
    }
}
