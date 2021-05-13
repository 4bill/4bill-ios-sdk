//
//  APIClient+Service.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Alamofire

extension APIClient {
    
    func getServiceList(data: ServiceListRequestData, completion: @escaping(ServiceListResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = ServiceListEndpoint(attributes: data.jsonObject())
        return self.manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
    func getService(data: ServiceRequestData, completion: @escaping(ServiceResponse?, Error?) -> Void) -> DataRequest {
        let endpoint = ServiceEndpoint(with: data.serviceID, attributes: data.jsonObject())
        return self.manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }
    
}
