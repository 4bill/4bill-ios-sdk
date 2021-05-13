//
//  CheckCardRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Marshal

struct CheckCardRequestData {
    
    let auth: AuthRequestData
    var cardNumber: String?
    var cardToken: String?
    
}

//MARK: - JSONMarshaling
extension CheckCardRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.auth.rawValue : self.auth.jsonObject(),
            APIParameterName.cardNumber.rawValue : self.cardNumber,
            APIParameterName.cardToken.rawValue : self.cardToken
        ]
    }
    
}
