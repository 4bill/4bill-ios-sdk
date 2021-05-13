//
//  APIClient+SessionConfiguration.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Foundation
import Alamofire

extension APIClient {
    
    var sessionConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        return configuration
    }
    
}
