//
//  HostToHostService.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 07.05.2021.
//

import Foundation
import Marshal
import Promise

public protocol HostToHostServiceDelegate: class {
    
    ///host-2-host finished without user verification
    func paymentSDKDidFinihHostToHost(with response: PayTransactionResponseData)
    
    ///host-2-host finished after user verification
    func paymentSDKDidFinishHostToHost(with response: UpdateTransactionResponseData)
    
}



class HostToHostService: BaseService, TransactionUsecase {
    
    //MARK: - Defaults
    
    //MARK: - Properties
    
    let transactionNetworkComponent: TransactionNetworkHandlerComponent
    
    weak var delegate: HostToHostServiceDelegate?
        
    var shouldShowLookUpEnterForm: Bool = false
    
    var shouldShowOTPEnterForm: Bool = false
    
    var redirectCallback: ((_ redirectUrl: URL, _ transactioID: Int) -> ())?
    
    var htmlRedirectCallback: ((_ html: String, _ transactionID: Int, _ md: Int) -> ())?
        
    var enterCodeCallback: ((_ transactionID: Int, _ codeType: VerificationCode, _ completion: @escaping(String?) -> Void) -> ())?
    
    var customCodeEnterCallback: ((_ transactionID: Int, _ codeType: VerificationCode) -> ())?
    
    var finishOperationCallback: ((_ completion: @escaping() -> Void) -> ())?
    
    //MARK: - Initialization
    
    init(with component: TransactionNetworkHandlerComponent) {
        self.transactionNetworkComponent = component
    }
    
    //MARK: - Lifecycle
    
    func hostToHost(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, fields: HostToHostFields, point: PayPoint?, locale: String) {
        guard let ip = IPAdressHelper.shared.getWiFiAddress(),
              let accountID = Core.shared.authManager.getAccountID(),
              let walletID = Core.shared.authManager.getWalletID()
              else {
            return
        }
        self.payTransaction(locale: locale, externalTransactionID: externalTransactionID, externalOrderID: externalOrderID, externalCustomerID: externalCustomerID, customerIPAdress: ip, amount: amount, amountCurrency: amountCurrency, serviceID: serviceID, accountID: accountID, walletID: walletID, description: description, fields: fields.jsonObject(), point: point, extra: nil) { [weak self] (response) in
            guard let status = TransactionStatus(rawValue: response.status) else {
                print("[PaymentSDK] hostToHost received unknown status: \(response.status)")
                return
            }
            if status.isFinal {
                self?.finishOperationCallback?({ [weak self] in
                    self?.delegate?.paymentSDKDidFinihHostToHost(with: response)
                })
                return
            }
            self?.proceedHostToHost(with: response, result: response.result)
        }
    }
    
    func updateTransaction(transactionID: Int, code: String, codeType: VerificationCode) {
        var authData = AuthorizationData(lookUpCode: code)
        if codeType == .otp {
            authData = AuthorizationData(otpCode: code)
        }
        self.updateTransaction(transactionID: transactionID, authData: authData) { (response) in
            self.finishOperationCallback?({ [weak self] in
                self?.delegate?.paymentSDKDidFinishHostToHost(with: response)
            })
        }
    }
    
    func updateTransaction(paRes: String, for transactionID: Int, md: Int) {
        self.updateTransaction(transactionID: transactionID, authData: AuthorizationData(paymentAuthResponse: paRes, md: md)) { (response) in
            self.finishOperationCallback?({ [weak self] in
                self?.delegate?.paymentSDKDidFinishHostToHost(with: response)
            })
        }
    }
    
    //MARK: - Private
    
    private func proceedHostToHost(with response: PayTransactionResponseData, result: JSONObject?) {
        guard let userAuth = PayerSDKHelper.shared.getTransactionAuthenticationType(from: result) else {
            return
        }
        switch userAuth {
        case .none:
            self.finishOperationCallback?({ [weak self] in
                self?.delegate?.paymentSDKDidFinihHostToHost(with: response)
            })
            return
        case .threeDs:
            self.proceed3Ds(with: response.result, transactionID: response.id).then { (html)  in
                let verification = PayerSDKHelper.shared.get3DsVerification(with: result)
                if let html = html, let md = verification?.md {
                    self.htmlRedirectCallback?(html, response.id, md)
                }
            }
        case .lookUp:
            if self.shouldShowLookUpEnterForm {
                self.enterCodeCallback?(response.id, .lookUpCode, { [weak self] (code) in
                    self?.updateTransaction(transactionID: response.id, code: code ?? "", codeType: .lookUpCode)
                })
                return
            }
            self.customCodeEnterCallback?(response.id, .lookUpCode)
        case .otp:
            if self.shouldShowOTPEnterForm {
                self.enterCodeCallback?(response.id, .otp, { [weak self] (code) in
                    self?.updateTransaction(transactionID: response.id, code: code ?? "", codeType: .otp)
                })
                return
            }
            self.customCodeEnterCallback?(response.id, .otp)
        case .redirect:
            self.proceedWithRedirect(object: response.result, transactionID: response.id)
        case .unknow:
            self.proceedWithUnknown(transactionID: response.id, timeout: 60) { (authorization) in
                self.proceedHostToHost(with: response, result: authorization)
            }
        }
    }
    
    private func proceedWithUnknown(transactionID: Int, timeout: Int, completion: @escaping(JSONObject?) -> Void) {
        if timeout <= 0 {
            return
        }
        self.transactionQueue.asyncAfter(deadline: .now() + 5) {
            self.findTransaction(transactionID: transactionID, externalTransactionID: nil) { (response) in
                if response.authorization != nil {
                    completion(response.authorization)
                    return
                }
                if let status = TransactionStatus(rawValue: response.status), status.isFinal {
                    completion(nil)
                    return
                }
            }
            self.proceedWithUnknown(transactionID: transactionID, timeout: timeout - 5, completion: completion)
        }
    }
    
    private func proceedWithRedirect(object: JSONObject?, transactionID: Int) {
        guard let object = object else {
            return
        }
        guard let redirect = object.optionalAny(for: APIParameterName.redirectUrl.rawValue) as? String,
              let redirectUrl = URL(string: redirect) else {
            return
        }
        self.redirectCallback?(redirectUrl, transactionID)
    }
    
}
