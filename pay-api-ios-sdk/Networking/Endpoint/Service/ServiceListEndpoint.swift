//
//  ServiceListEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

class ServiceListEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = ServiceListResponse
    
    var path: String {
        return APIPath.serviceList
    }
    
}

struct ServiceListResponse: Unmarshaling {
    
    let result: ServiceListResponseData
    
    init(object: MarshaledObject) throws {
        result = try ServiceListResponseData(object: object)
    }
    
}
