//
//  FindTransactionResponseData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

public struct FindTransactionResponseData {
        
    public let accountID: Int
    
    public var accountWalletAmount: Int?
    public let accountWalletCurrency: String
    
    public let amount: Int
    public var amountCurrency: String?
    
    public let created: String
    public var description: String?
    public var externalCustomerID: String?
    public var externalOrderID: String?
    public var externalTransectionID: String?
    
    public let id: Int
    public let isTest: Bool
    public let pointID: Int
    public let serviceID: Int
    public let walletID: Int
    public let status: Int
    public let statusDescription: String
    
    public var failureReasonCode: Int?
    public var failureReasonMessage: String?
    
    public let extra: JSONObject
    public let fields: JSONObject
    public var authorization: JSONObject?
}

//MARK: - Unmarshaling
extension FindTransactionResponseData: Unmarshaling {
    
    public init(object: MarshaledObject) throws {
        self.accountID = try object.any(for: APIParameterName.accountID.rawValue) as! Int
        self.accountWalletAmount = object.optionalAny(for: APIParameterName.accountWalletAmount.rawValue) as? Int
        self.accountWalletCurrency = try object.any(for: APIParameterName.accountWalletCurrency.rawValue) as! String
        self.amount = try object.any(for: APIParameterName.amount.rawValue) as! Int
        self.amountCurrency = object.optionalAny(for: APIParameterName.amountCurrency.rawValue) as? String
        self.created = try object.any(for: APIParameterName.created.rawValue) as! String
        self.description = object.optionalAny(for: APIParameterName.description.rawValue) as? String
        self.externalCustomerID = object.optionalAny(for: APIParameterName.externalCustomerID.rawValue) as? String
        self.externalOrderID = object.optionalAny(for: APIParameterName.externalOrderID.rawValue) as? String
        self.externalTransectionID = object.optionalAny(for: APIParameterName.externalTransactionID.rawValue) as? String
        self.id = try object.any(for: APIParameterName.id.rawValue) as! Int
        self.isTest = try object.any(for: APIParameterName.isTest.rawValue) as! Bool
        self.pointID = try object.any(for: APIParameterName.pointID.rawValue) as! Int
        self.serviceID = try object.any(for: APIParameterName.serviceID.rawValue) as! Int
        self.walletID = try object.any(for: APIParameterName.walletID.rawValue) as! Int
        self.status = try object.any(for: APIParameterName.status.rawValue) as! Int
        self.statusDescription = try object.any(for: APIParameterName.statusDescription.rawValue) as! String
        self.failureReasonCode = object.optionalAny(for: APIParameterName.failureReasonCode.rawValue) as? Int
        self.failureReasonMessage = object.optionalAny(for: APIParameterName.failureReasonMessage.rawValue) as? String
        self.extra = try object.any(for: APIParameterName.extra.rawValue) as! JSONObject
        self.fields = try object.any(for: APIParameterName.fields.rawValue) as! JSONObject
        self.authorization = object.optionalAny(for: APIParameterName.authorization.rawValue) as? JSONObject
    }
    
}

//MARK: - JSONMarshaling
extension FindTransactionResponseData: JSONMarshaling {
    
    public func jsonObject() -> JSONObject {
        return [
            APIParameterName.accountID.rawValue : self.accountID,
            APIParameterName.accountWalletAmount.rawValue : self.accountWalletAmount,
            APIParameterName.accountWalletCurrency.rawValue : self.accountWalletCurrency,
            APIParameterName.amount.rawValue : self.amount,
            APIParameterName.amountCurrency.rawValue : self.amountCurrency,
            APIParameterName.created.rawValue : self.created,
            APIParameterName.description.rawValue : self.description,
            APIParameterName.externalCustomerID.rawValue : self.externalCustomerID,
            APIParameterName.externalOrderID.rawValue : self.externalOrderID,
            APIParameterName.externalTransactionID.rawValue : self.externalTransectionID,
            APIParameterName.id.rawValue : self.id,
            APIParameterName.isTest.rawValue : self.isTest,
            APIParameterName.pointID.rawValue : self.pointID,
            APIParameterName.serviceID.rawValue : self.serviceID,
            APIParameterName.walletID.rawValue : self.walletID,
            APIParameterName.status.rawValue : self.status,
            APIParameterName.statusDescription.rawValue : self.statusDescription,
            APIParameterName.failureReasonCode.rawValue : self.failureReasonCode,
            APIParameterName.failureReasonMessage.rawValue : self.failureReasonMessage,
            APIParameterName.extra.rawValue : self.extra,
            APIParameterName.fields.rawValue : self.fields,
            APIParameterName.authorization.rawValue : self.authorization
        ]
    }
    
}
