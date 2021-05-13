//
//  AddCardToWhitelistEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Marshal

class AddCardToWhitelistEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = AddCardToWhitelistResponse
    
    var path: String {
        return APIPath.addCardToWhitelist
    }
    
}

struct AddCardToWhitelistResponse: Unmarshaling {
    
    let result: APIErrorDescription
    
    init(object: MarshaledObject) throws {
        result = try APIErrorDescription(object: object)
    }
    
}
