//
//  BillioPayViewController.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import UIKit

public class BillioPayViewController: BillioBaseViewController {
    
    //MARK: - Defaults
    
    //MARK: - Properties
    
    @IBOutlet weak private var tvPay: UITableView!
                
    @IBOutlet weak private var vActivityIndicator: UIActivityIndicatorView!
    
    public var controllerTitle: String = "Оплата"
    
    public var externalTransactionID: String? {
        didSet {
            if let number = self.externalTransactionID {
                self.uiViewModel.set(transactionID: number)
            }
        }
    }
    
    /// amount in coins
    public var transactionAmount: Int? {
        didSet {
            if let amount = self.transactionAmount {
                self.uiViewModel.set(amount: amount)
            }
        }
    }
    
    public var externalOrderID: String?
    
    public var externalCustomerID: String?
        
    public var amountCurrency: String?
    
    public var serviceID: Int?
    
    public var transactionDescription: String?
    
    var fields: HostToHostFields? {
        return self.uiViewModel.getCardFields()
    }
    
    private var isNeedToSaveCard: Bool = false
    
    lazy var uiViewModel: BillioPayUIViewModel = {
        let model = BillioPayUIViewModel()
        return model
    }()
    
    //MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addShadowView()
        self.addKeyboardObservers()
        self.registerCells()
        self.prepareSDK()
        self.updateUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareNavigationBar()
        self.reloadTableView()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.prepareForDismiss()
        self.stopLoading()
    }
    
    private func updateUI() {
        self.vActivityIndicator.clipsToBounds = true
        self.vActivityIndicator.layer.cornerRadius = 8
    }
    
    private func prepareForDismiss() {
        self.uiViewModel.set(cvv: nil)
        if self.isNeedToSaveCard {
            return
        }
        self.uiViewModel.set(name: nil)
        self.uiViewModel.set(number: nil)
        self.uiViewModel.set(expirationMonth: nil)
        self.uiViewModel.set(expirationYear: nil)
    }
    
    private func prepareSDK() {
        PaymentSDK.shared.shouldShowOTPEnterForm = true
        PaymentSDK.shared.shouldShowLookUpEnterForm = true
    }
    
    private func prepareNavigationBar() {
        self.setNavigationBar(isHidden: false)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor    : UIColor.black,
            .font               : UIFont.roboto(size: 20, style: .medium)
        ]
        self.add(title: self.controllerTitle)
    }
    
    func addShadowView() {
        guard let frame = self.navigationController?.navigationBar.frame  else {
            return
        }
        let shadowView = UIView(frame: frame)
        shadowView.backgroundColor = .white
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 0.25
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowRadius =  20
        self.view.addSubview(shadowView)
    }
    
    func startLoading() {
        self.vActivityIndicator.startAnimating()
    }
    
    func stopLoading() {
        self.vActivityIndicator.stopAnimating()
    }
    
    func pay() {
        if self.vActivityIndicator.isAnimating {
            return
        }
        guard let externalTransactionID = self.externalTransactionID,
              let amount = self.transactionAmount,
              let currency = self.amountCurrency,
              let serviceID = self.serviceID,
              let fields = self.fields
              else {
            return
        }
        let point = PaymentSDK.shared.getPayPoint()
        self.startLoading()
        PaymentSDK.shared.hostToHost(externalTransactionID: externalTransactionID, externalOrderID: self.externalOrderID, externalCustomerID: self.externalCustomerID, amount: amount, amountCurrency: currency, serviceID: serviceID, description: self.transactionDescription, fields: fields, point: point)
    }
    
    func saveCard() {
        guard let _ = self.uiViewModel.getCardFields() else {
            return
        }
        self.isNeedToSaveCard = true
        self.presentSaved()
    }
    
    //MARK: - UITableView
    
    private func registerCells() {
        self.tvPay.register(cells: [
            BillioPayGeneralTitleTableViewCell.self,
            BillioPayGeneralSumTableViewCell.self,
            BillioPayCardNameTableViewCell.self,
            BillioPayCardNumberTableViewCell.self,
            BillioPayCardDatesTableViewCell.self,
            BillioPayCardCVVTableViewCell.self,
            BillioPayActionButtonTableViewCell.self,
            BillioPayCompaniesTableViewCell.self
        ])
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tvPay.reloadData()
            self.tvPay.layoutIfNeeded()
        }
    }
    
    //MARK: - Screens
    
    func pushScannerScreen() {
        let controller = BillioCardScannerViewController.storyboardInstance()!
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Modals
    
    private func presentSaved() {
        let controller = UIAlertController(title: "Saved", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            controller.dismiss(animated: true, completion: nil)
        }
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
    
    //MARK: - Handlers
    
}

//MARK: - StoryboardInstantiable
extension BillioPayViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        return Storyboard.pay
    }
    
}

//MARK: - BillioCardScannerViewControllerDelegate
extension BillioPayViewController: BillioCardScannerViewControllerDelegate {
    
    func didFindCardNumber(cardNumber: String) {
        self.uiViewModel.set(number: cardNumber)
        self.reloadTableView()
    }
    
}
