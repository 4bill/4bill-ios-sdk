//
//  ServiceEndpoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Alamofire
import Marshal

class ServiceEndpoint: BaseEndpoint, APIEndpoint {
    
    typealias ResponseType = ServiceResponse
    
    var path: String {
        return APIPath.service + self.serviceID.description
    }
    
    let serviceID: Int
    
    init(with serviceID: Int, attributes: Parameters?) {
        self.serviceID = serviceID
        super.init(attributes: attributes)
    }
    
}

struct ServiceResponse: Unmarshaling {
    
    let result: ServiceResponseData
    
    init(object: MarshaledObject) throws {
        result = try ServiceResponseData(object: object)
    }
    
}
