//
//  APIClient+Card.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Alamofire

extension APIClient {
    
    func addCardToWhiteList(data: AddCardToWhitelistRequestData, completion: @escaping(AddCardToWhitelistResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = AddCardToWhitelistEndpoint(attributes: data.jsonObject())
        return manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
    func checkCard(data: CheckCardRequestData, completion: @escaping(CheckCardResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = CheckCardEndpoint(attributes: data.jsonObject())
        return manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
}
