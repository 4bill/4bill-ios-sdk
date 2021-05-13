//
//  UpdateTransactionResponseData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 26.04.2021.
//

import Foundation
import Marshal

public struct UpdateTransactionResponseData {
        
    let id: Int
    let isTest: Bool
    
    var boolResult: Bool?
    var result: JSONObject?
    
    let status: Int
    let statusDescription: String
    
    var failureReasonCode: Int?
    var failureReasonMessage: String?
    
    
}

//MARK: - Unmarshaling
extension UpdateTransactionResponseData: Unmarshaling {
    
    public init(object: MarshaledObject) throws {
        self.id = try object.any(for: APIParameterName.id.rawValue) as! Int
        self.isTest = try object.any(for: APIParameterName.isTest.rawValue) as! Bool
        self.boolResult = object.optionalAny(for: APIParameterName.result.rawValue) as? Bool
        self.result = object.optionalAny(for: APIParameterName.result.rawValue) as? JSONObject
        self.status = try object.any(for: APIParameterName.status.rawValue) as! Int
        self.statusDescription = try object.any(for: APIParameterName.statusDescription.rawValue) as! String
        self.failureReasonCode = object.optionalAny(for: APIParameterName.failureReasonCode.rawValue) as? Int
        self.failureReasonMessage = object.optionalAny(for: APIParameterName.failureReasonMessage.rawValue) as? String
    }
    
}

//MARK: - JSONMarshaling
extension UpdateTransactionResponseData: JSONMarshaling {
    
    public func jsonObject() -> JSONObject {
        return [
            APIParameterName.id.rawValue : self.id,
            APIParameterName.isTest.rawValue : self.isTest,
            APIParameterName.result.rawValue : self.result ?? self.boolResult,
            APIParameterName.status.rawValue : self.status,
            APIParameterName.statusDescription.rawValue : self.statusDescription,
            APIParameterName.failureReasonCode.rawValue : self.failureReasonCode,
            APIParameterName.failureReasonMessage.rawValue : self.failureReasonMessage
        ]
    }
    
}
