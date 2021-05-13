//
//  CreateTransactionEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 25.04.2021.
//

import Alamofire
import Marshal

class CreateTransactionEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = CreateTransactionResponse
    
    var path: String {
        return APIPath.transactionCreate
    }
    
}

struct CreateTransactionResponse: Unmarshaling {
    
    let result: CreateTransactionResponseData
    
    init(object: MarshaledObject) throws {
        result = try CreateTransactionResponseData(object: object)
    }
    
}
