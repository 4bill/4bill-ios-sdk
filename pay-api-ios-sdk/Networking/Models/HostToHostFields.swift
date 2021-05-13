//
//  HostToHostFields.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import Foundation
import Marshal

public struct HostToHostFields {
    
    let cardNumber: String
    let expireYear: String
    let expireMonth: String
    let cvv: String
    
}

//MARK: - JSONMarshaling
extension HostToHostFields: JSONMarshaling {
    
    public func jsonObject() -> JSONObject {
        return [
            APIParameterName.cardNumber.rawValue    : self.cardNumber,
            APIParameterName.expireYear.rawValue    : self.expireYear,
            APIParameterName.expireMonth.rawValue   : self.expireMonth,
            APIParameterName.cvv.rawValue           : self.cvv
        ]
    }
    
}
