//
//  UpdateTransactionEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 26.04.2021.
//

import Foundation
import Marshal

class UpdateTransactionEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = UpdateTransactionResponse
    
    var path: String {
        return APIPath.transactionUpdate
    }
    
}

struct UpdateTransactionResponse: Unmarshaling {
    
    let result: UpdateTransactionResponseData
    
    init(object: MarshaledObject) throws {
        result = try UpdateTransactionResponseData(object: object)
    }
    
}

