//
//  HostToHostFields.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import Foundation
import Marshal

public struct HostToHostFields {
    
    public let cardNumber: String
    public let expireYear: String
    public let expireMonth: String
    public let cvv: String
    
    public init(cardNumber: String, expireYear: String, expireMonth: String, cvv: String) {
        self.cardNumber = cardNumber
        self.expireYear = expireYear
        self.expireMonth = expireMonth
        self.cvv = cvv
    }
    
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
