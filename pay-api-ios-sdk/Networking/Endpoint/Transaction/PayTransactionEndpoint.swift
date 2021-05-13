//
//  PayTransactionEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 25.04.2021.
//

import Alamofire
import Marshal

class PayTransactionEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = PayTransactionResponse
    
    var path: String {
        return APIPath.payTransaction
    }
    
}

struct PayTransactionResponse: Unmarshaling {
    
    let result: PayTransactionResponseData
    
    init(object: MarshaledObject) throws {
        result = try PayTransactionResponseData(object: object)
    }
    
}
