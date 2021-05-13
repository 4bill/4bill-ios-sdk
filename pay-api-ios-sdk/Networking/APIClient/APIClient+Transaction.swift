//
//  APIClient+Transaction.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Alamofire

extension APIClient {
    
    func createTransaction(data: CreateTransactionRequestData, completion: @escaping(CreateTransactionResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = CreateTransactionEndpoint(attributes: data.jsonObject())
        return self.manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
    func payTransaction(data: PayTransactionRequestData, completion: @escaping(PayTransactionResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = PayTransactionEndpoint(attributes: data.jsonObject())
        return self.manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
    func updateTransaction(data: UpdateTransactionRequestData, completion: @escaping(UpdateTransactionResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = UpdateTransactionEndpoint(attributes: data.jsonObject())
        return self.manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
    func cancelTransaction(data: CancelTransactionRequestData, completion: @escaping(CancelTransactionResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = CancelTransactionEndpoint(attributes: data.jsonObject())
        return self.manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
    func findTransaction(data: FindTransactionRequestData, completion: @escaping(FindTransactionResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = FindTransactionEndpoint(attributes: data.jsonObject())
        return self.manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
}
