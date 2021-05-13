//
//  TransactionUsecase.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import Foundation
import Marshal

//MARK: - Declaration

protocol TransactionUsecase {
    
    var transactionNetworkComponent: TransactionNetworkHandlerComponent { get }
    
    func createTransaction(locale: String, externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, customerIPAdress: String, amount: Int?, amountCurrency: String?, serviceID: Int, accountID: Int, walletID: Int, description: String?, fields: JSONObject?, point: PayPoint?, extra: JSONObject?, completion: @escaping(CreateTransactionResponseData) -> Void)
    
    func payTransaction(locale: String, externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, customerIPAdress: String, amount: Int?, amountCurrency: String?, serviceID: Int, accountID: Int, walletID: Int, description: String?, fields: JSONObject?, point: PayPoint?, extra: JSONObject?, completion: @escaping(PayTransactionResponseData) -> Void)
    
    func updateTransaction(transactionID: Int, authData: AuthorizationData, completion: @escaping(UpdateTransactionResponseData) -> Void)
    
    func cancelTransaction(transactionID: Int, completion: @escaping(CancelTransactionResponseData) -> Void)
    
    func findTransaction(transactionID: Int?, externalTransactionID: String?, completion: @escaping(FindTransactionResponseData) -> Void)
    
}

//MARK: - Implementation

extension TransactionUsecase {
    
    func createTransaction(locale: String, externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, customerIPAdress: String, amount: Int?, amountCurrency: String?, serviceID: Int, accountID: Int, walletID: Int, description: String?, fields: JSONObject?, point: PayPoint?, extra: JSONObject?, completion: @escaping(CreateTransactionResponseData) -> Void) {
        
        self.transactionNetworkComponent.createTransaction(locale: locale, externalTransactionID: externalTransactionID, externalOrderID: externalOrderID, externalCustomerID: externalCustomerID, customerIPAdress: customerIPAdress, amount: amount, amountCurrency: amountCurrency, serviceID: serviceID, accountID: accountID, walletID: walletID, description: description, fields: fields, point: point, extra: extra, completion: completion)
    }
    
    func payTransaction(locale: String, externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, customerIPAdress: String, amount: Int?, amountCurrency: String?, serviceID: Int, accountID: Int, walletID: Int, description: String?, fields: JSONObject?, point: PayPoint?, extra: JSONObject?, completion: @escaping(PayTransactionResponseData) -> Void) {
        
        self.transactionNetworkComponent.payTransaction(locale: locale, externalTransactionID: externalTransactionID, externalOrderID: externalOrderID, externalCustomerID: externalCustomerID, customerIPAdress: customerIPAdress, amount: amount, amountCurrency: amountCurrency, serviceID: serviceID, accountID: accountID, walletID: walletID, description: description, fields: fields, point: point, extra: extra, completion: completion)
        
    }
    
    func updateTransaction(transactionID: Int, authData: AuthorizationData, completion: @escaping(UpdateTransactionResponseData) -> Void) {
        self.transactionNetworkComponent.updateTransaction(transactionID: transactionID, authData: authData, completion: completion)
    }
    
    func cancelTransaction(transactionID: Int, completion: @escaping(CancelTransactionResponseData) -> Void) {
        self.transactionNetworkComponent.cancelTransaction(transactionID: transactionID, completion: completion)
    }
    
    func findTransaction(transactionID: Int?, externalTransactionID: String?, completion: @escaping(FindTransactionResponseData) -> Void) {
        self.transactionNetworkComponent.findTransaction(transactionID: transactionID, externalTransactionID: externalTransactionID, completion: completion)
    }
    
}
