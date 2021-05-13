//
//  AddCardToWhitelistRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Marshal

struct AddCardToWhitelistRequestData {
    
    let auth: AuthRequestData
    var cardNumber: String?
    var cardToken: String?
    
}

//MARK: - JSONMarshaling
extension AddCardToWhitelistRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.auth.rawValue : self.auth,
            APIParameterName.cardNumber.rawValue : self.cardNumber,
            APIParameterName.cardToken.rawValue : self.cardToken
        ]
    }
    
}
