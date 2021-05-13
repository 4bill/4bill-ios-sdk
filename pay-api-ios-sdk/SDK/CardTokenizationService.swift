//
//  CardTokenizationService.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.05.2021.
//

import Foundation
import Marshal
import Promise

class CardTokenizationService: BaseService, TransactionUsecase {
    
    //MARK: - Defaults
    
    //MARK: - Properties
    
    let transactionNetworkComponent: TransactionNetworkHandlerComponent
        
    var payURLCallback: ((_ payURL: URL, _ transactionID: Int, _ externalTransactionID: String?) ->())?
    
    var createTransactionCallBack: ((_ response: CreateTransactionResponseData) -> ())?
    
    //MARK: - Initialization
    
    init(with component: TransactionNetworkHandlerComponent) {
        self.transactionNetworkComponent = component
    }
    
    //MARK: - Lifecycle
    
    func tokenizeCard(locale: String, externalTransactionID: String, externalCustomerID: String?, serviceID: Int, description: String?, point: PayPoint?) {
        guard let ip = IPAdressHelper.shared.getWiFiAddress(),
              let accountID = Core.shared.authManager.getAccountID(),
              let walletID = Core.shared.authManager.getWalletID()
              else {
            return
        }
        self.createTransaction(locale: locale, externalTransactionID: externalTransactionID, externalOrderID: nil, externalCustomerID: externalCustomerID, customerIPAdress: ip, amount: 0, amountCurrency: "", serviceID: serviceID, accountID: accountID, walletID: walletID, description: description, fields: nil, point: point, extra: nil) { [weak self] (response) in
            if let payURLPath = response.result?.optionalAny(for: APIParameterName.payUrl.rawValue) as? String {
                let payURL = URL(string: payURLPath)
                self?.proceedWith(payURL: payURL, transactionID: response.id, externalTransactionID: externalTransactionID, callback: self?.payURLCallback)
            }
            self?.createTransactionCallBack?(response)
        }
    }
        
}
