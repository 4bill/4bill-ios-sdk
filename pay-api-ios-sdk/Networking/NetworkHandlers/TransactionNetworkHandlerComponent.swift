//
//  TransactionNetworkHandlerComponent.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 30.04.2021.
//

import Foundation
import Marshal

class TransactionNetworkHandlerComponent: BaseNetworkHandler {
    
    func createTransaction(locale: String, externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, customerIPAdress: String, amount: Int?, amountCurrency: String?, serviceID: Int, accountID: Int, walletID: Int, description: String?, fields: JSONObject?, point: PayPoint?, extra: JSONObject?, completion: @escaping(CreateTransactionResponseData) -> Void) {
        
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = CreateTransactionRequestData(auth: auth,
                                                       locale: locale,
                                                       externalTransactionID: externalTransactionID,
                                                       externalOrderID: externalOrderID,
                                                       externalCustomerID: externalCustomerID,
                                                       customerIPAdress: customerIPAdress,
                                                       amount: amount,
                                                       amountCurrency: amountCurrency,
                                                       serviceID: serviceID,
                                                       accountID: accountID,
                                                       walletID: walletID,
                                                       description: description,
                                                       fields: fields,
                                                       point: point,
                                                       extra: extra)
        let request = APIClient.shared.createTransaction(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .createTransaction)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .createTransaction)
                return
            }
            completion(result)
            self?.finishRequest(type: .createTransaction)
        }
        self.startRequest(with: request, type: .createTransaction)
    }
    
    func payTransaction(locale: String, externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, customerIPAdress: String, amount: Int?, amountCurrency: String?, serviceID: Int, accountID: Int, walletID: Int, description: String?, fields: JSONObject?, point: PayPoint?, extra: JSONObject?, completion: @escaping(PayTransactionResponseData) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = PayTransactionRequestData(auth: auth,
                                                    locale: locale,
                                                    externalTransactionID: externalTransactionID,
                                                    externalOrderID: externalOrderID,
                                                    externalCustomerID: externalCustomerID,
                                                    customerIPAdress: customerIPAdress,
                                                    amount: amount,
                                                    amountCurrency: amountCurrency,
                                                    serviceID: serviceID,
                                                    accountID: accountID,
                                                    walletID: walletID,
                                                    description: description,
                                                    fields: fields,
                                                    point: point,
                                                    extra: extra)
        
        let request = APIClient.shared.payTransaction(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .payTransaction)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .payTransaction)
                return
            }
            completion(result)
            self?.finishRequest(type: .payTransaction)
        }
        self.startRequest(with: request, type: .payTransaction)
    }
    
    func updateTransaction(transactionID: Int, authData: AuthorizationData, completion: @escaping(UpdateTransactionResponseData) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = UpdateTransactionRequestData(auth: auth, id: transactionID, authorizationData: authData)
        let request = APIClient.shared.updateTransaction(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .updateTransaction)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .updateTransaction)
                return
            }
            completion(result)
            self?.finishRequest(type: .updateTransaction)
        }
        self.startRequest(with: request, type: .updateTransaction)
    }
    
    func cancelTransaction(transactionID: Int, completion: @escaping(CancelTransactionResponseData) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = CancelTransactionRequestData(auth: auth, id: transactionID)
        let request  = APIClient.shared.cancelTransaction(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .cancelTransaction)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .cancelTransaction)
                return
            }
            completion(result)
            self?.finishRequest(type: .cancelTransaction)
        }
        self.startRequest(with: request, type: .cancelTransaction)
    }
    
    func findTransaction(transactionID: Int?, externalTransactionID: String?, completion: @escaping(FindTransactionResponseData) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = FindTransactionRequestData(auth: auth, id: transactionID, externalTransactionID: externalTransactionID)
        let request = APIClient.shared.findTransaction(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .findTransaction)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .findTransaction)
                return
            }
            completion(result)
            self?.finishRequest(type: .findTransaction)
        }
        self.startRequest(with: request, type: .findTransaction)
    }
    
}
