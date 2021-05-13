//
//  CancelTransactionEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 26.04.2021.
//

import Foundation
import Marshal

class CancelTransactionEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = CancelTransactionResponse
    
    var path: String {
        return APIPath.transactionCancel
    }
    
}

struct CancelTransactionResponse: Unmarshaling {
    
    let result: CancelTransactionResponseData
    
    init(object: MarshaledObject) throws {
        result = try CancelTransactionResponseData(object: object)
    }
    
}
