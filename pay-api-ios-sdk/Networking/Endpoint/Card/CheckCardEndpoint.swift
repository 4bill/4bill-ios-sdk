//
//  CheckCardEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Marshal

class CheckCardEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = CheckCardResponse
    
    var path: String {
        return APIPath.cardsCheck
    }
    
}

struct CheckCardResponse: Unmarshaling {
    
    let result: CheckCardResponseData
    
    init(object: MarshaledObject) throws {
        result = try CheckCardResponseData(object: object)
    }
    
}
