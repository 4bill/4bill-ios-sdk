//
//  FindTransactionEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

class FindTransactionEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = FindTransactionResponse
    
    var path: String {
        return APIPath.transactionFind
    }
    
}

struct FindTransactionResponse: Unmarshaling {
    
    let result: FindTransactionResponseData
    
    init(object: MarshaledObject) throws {
        result = try FindTransactionResponseData(object: object)
    }
    
}

