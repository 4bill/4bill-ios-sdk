//
//  AccountInfoRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct AccountInfoRequestData {
    
    let auth: AuthRequestData
    
}

//MARK: - JSONMarshaling
extension AccountInfoRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.auth.rawValue : self.auth.jsonObject()
        ]
    }
    
}
