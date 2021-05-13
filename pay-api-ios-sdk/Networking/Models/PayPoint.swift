//
//  PayPoint.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 25.04.2021.
//

import Foundation
import Marshal

public struct PayPoint {
    
    let callbackURL : String?
    let successURL  : String?
    let failURL     : String?
    let cancelURL   : String?
    let returnURL   : String?
    
}

//MARK: - JSONMarshaling
extension PayPoint: JSONMarshaling {
    
    public func jsonObject() -> JSONObject {
        return [
            APIParameterName.callbackURL.rawValue   : self.callbackURL,
            APIParameterName.successURL.rawValue    : self.successURL,
            APIParameterName.failURL.rawValue       : self.failURL,
            APIParameterName.cancelURL.rawValue     : self.cancelURL,
            APIParameterName.returnURL.rawValue     : self.returnURL
        ]
    }
    
}

//MARK: - Unmarshaling
extension PayPoint: Unmarshaling {
    
    public init(object: MarshaledObject) throws {
        self.callbackURL    = object.optionalAny(for: APIParameterName.callbackURL.rawValue) as? String
        self.successURL     = object.optionalAny(for: APIParameterName.successURL.rawValue) as? String
        self.failURL        = object.optionalAny(for: APIParameterName.failURL.rawValue) as? String
        self.cancelURL      = object.optionalAny(for: APIParameterName.cancelURL.rawValue) as? String
        self.returnURL      = object.optionalAny(for: APIParameterName.returnURL.rawValue) as? String
    }
    
}
