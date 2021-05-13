//
//  ServiceRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct ServiceRequestData {
    
    let serviceID: Int
    let auth: AuthRequestData
    
}

//MARK: - JSONMarshaling
extension ServiceRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.auth.rawValue : self.auth.jsonObject()
        ]
    }
    
}
