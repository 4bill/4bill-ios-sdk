//
//  CreateTransactionResponseData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 25.04.2021.
//

import Foundation
import Marshal

public struct CreateTransactionResponseData {
        
    public let amount: Int
    public var amountCurrency: String?
    public var externalCustomerID: String?
    public var externalTransactionID: String?
    public var externalOrderID: String?
    public let id: Int
    public let isTest: Bool
    public let accountID: Int
    public let pointID: Int
    public let serviceID: Int
    public let walletID: Int
    
    public var resultBool: Bool?
    public var result: JSONObject?
    
    public let status: Int
    public var statusDescription: String?
    
    public var failureReasonCode: Int?
    public var failureReasonMessage: String?
    
}

//MARK: - Unmarshaling
extension CreateTransactionResponseData: Unmarshaling {
    
    public init(object: MarshaledObject) throws {
        self.amount = try object.any(for: APIParameterName.amount.rawValue) as! Int
        self.amountCurrency = object.optionalAny(for: APIParameterName.amountCurrency.rawValue) as? String
        self.externalCustomerID = object.optionalAny(for: APIParameterName.externalCustomerID.rawValue) as? String
        self.externalTransactionID = object.optionalAny(for: APIParameterName.externalTransactionID.rawValue) as? String
        self.externalOrderID = object.optionalAny(for: APIParameterName.externalOrderID.rawValue) as? String
        self.id = try object.any(for: APIParameterName.id.rawValue) as! Int
        self.isTest = try object.any(for: APIParameterName.isTest.rawValue) as! Bool
        self.accountID = try object.any(for: APIParameterName.accountID.rawValue) as! Int
        self.pointID = try object.any(for: APIParameterName.pointID.rawValue) as! Int
        self.serviceID = try object.any(for: APIParameterName.serviceID.rawValue) as! Int
        self.walletID = try object.any(for: APIParameterName.walletID.rawValue) as! Int
        self.resultBool = object.optionalAny(for: APIParameterName.result.rawValue) as? Bool
        self.result = object.optionalAny(for: APIParameterName.result.rawValue) as? JSONObject
        
        self.status = try object.any(for: APIParameterName.status.rawValue) as! Int
        self.statusDescription = object.optionalAny(for: APIParameterName.statusDescription.rawValue) as? String
        self.failureReasonCode = object.optionalAny(for: APIParameterName.failureReasonCode.rawValue) as? Int
        self.failureReasonMessage = object.optionalAny(for: APIParameterName.failureReasonMessage.rawValue) as? String
    }
    
}

//MARK: - JSONMarshaling
extension CreateTransactionResponseData: JSONMarshaling {
    
    public func jsonObject() -> JSONObject {
        return [
            APIParameterName.amount.rawValue : self.amount,
            APIParameterName.amountCurrency.rawValue : self.amountCurrency,
            APIParameterName.externalCustomerID.rawValue : self.externalCustomerID,
            APIParameterName.externalTransactionID.rawValue : self.externalTransactionID,
            APIParameterName.externalOrderID.rawValue : self.externalOrderID,
            APIParameterName.id.rawValue : self.id,
            APIParameterName.isTest.rawValue : self.isTest,
            APIParameterName.accountID.rawValue : self.accountID,
            APIParameterName.pointID.rawValue : self.pointID,
            APIParameterName.serviceID.rawValue : self.serviceID,
            APIParameterName.walletID.rawValue : self.walletID,
            APIParameterName.result.rawValue : self.result ?? self.resultBool,
            APIParameterName.status.rawValue : self.status,
            APIParameterName.statusDescription.rawValue : self.statusDescription,
            APIParameterName.failureReasonCode.rawValue : self.failureReasonCode,
            APIParameterName.failureReasonMessage.rawValue : self.failureReasonMessage
        ]
    }
    
}
