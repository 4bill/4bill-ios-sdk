//
//  APIClient+Account.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Alamofire

extension APIClient {
    
    func getAccountInfo(data: AccountInfoRequestData, completion: @escaping(AccountInfoResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = AccountInfoEndpoint(attributes: data.jsonObject())
        return self.manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
}
