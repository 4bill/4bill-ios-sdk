//
//  AccountInfoEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Alamofire
import Marshal

class AccountInfoEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = AccountInfoResponse
    
    var path: String {
        return APIPath.accountInfo
    }
    
}

struct AccountInfoResponse: Unmarshaling {
    
    let result: AccountInfoResponseData
    
    init(object: MarshaledObject) throws {
        result = try AccountInfoResponseData(object: object)
    }
    
}
