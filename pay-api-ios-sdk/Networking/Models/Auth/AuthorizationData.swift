//
//  AuthorizationData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 26.04.2021.
//

import Foundation
import Marshal

public struct AuthorizationData {
    
    var paymentAuthResponse: String?
    var md: Int?
    var lookupCode: String?
    var otpCode: String?
    
    public init(lookUpCode: String?) {
        self.lookupCode = lookUpCode
    }
    
    public init(otpCode: String?) {
        self.otpCode = otpCode
    }
    
    public init(paymentAuthResponse: String?, md: Int?) {
        self.paymentAuthResponse = paymentAuthResponse
        self.md = md
    }
}

//MARK: - Unmarshaling
extension AuthorizationData: JSONMarshaling {
    
    public func jsonObject() -> JSONObject {
        return [
            APIParameterName.paymentAuthResponse.rawValue : self.paymentAuthResponse ?? "",
            APIParameterName.md.rawValue : self.md?.description ?? "",
            APIParameterName.lookupCode.rawValue : self.lookupCode ?? "",
            APIParameterName.otpCode.rawValue : self.otpCode ?? ""
        ]
    }
    
}
