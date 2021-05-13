//
//  UpdateTransactionRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 26.04.2021.
//

import Foundation
import Marshal

struct UpdateTransactionRequestData {
    
    let auth: AuthRequestData
    
    let id: Int
    let authorizationData: AuthorizationData
    
}

//MARK: - JSONMarshaling
extension UpdateTransactionRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.auth.rawValue : self.auth.jsonObject(),
            APIParameterName.id.rawValue : self.id,
            APIParameterName.data.rawValue : self.authorizationData.jsonObject()
        ]
    }
    
}
