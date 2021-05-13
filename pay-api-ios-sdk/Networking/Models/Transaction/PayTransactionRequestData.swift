//
//  PayTransactionRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 25.04.2021.
//

import Foundation
import Marshal

struct PayTransactionRequestData {
    
    let auth: AuthRequestData
    
    let locale: String
    let externalTransactionID: String
    var externalOrderID: String?
    var externalCustomerID: String?
    
    let customerIPAdress: String
    
    var amount: Int?
    var amountCurrency: String?
    
    let serviceID: Int
    let accountID: Int
    let walletID: Int
    
    var description: String?
    var fields: JSONObject?
    var point: PayPoint?
    
    var extra: JSONObject?
}

//MARK: - JSONMarshaling
extension PayTransactionRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.auth.rawValue                  : self.auth.jsonObject(),
            APIParameterName.locale.rawValue                : self.locale,
            APIParameterName.externalTransactionID.rawValue : self.externalTransactionID,
            APIParameterName.externalOrderID.rawValue       : self.externalOrderID,
            APIParameterName.externalCustomerID.rawValue    : self.externalCustomerID,
            APIParameterName.customerIPAdress.rawValue      : self.customerIPAdress,
            APIParameterName.amount.rawValue                : self.amount,
            APIParameterName.amountCurrency.rawValue        : self.amountCurrency,
            APIParameterName.serviceID.rawValue             : self.serviceID,
            APIParameterName.accountID.rawValue             : self.accountID,
            APIParameterName.walletID.rawValue              : self.walletID,
            APIParameterName.description.rawValue           : self.description ?? "",
            APIParameterName.fields.rawValue                : self.fields,
            APIParameterName.point.rawValue                 : self.point?.jsonObject() ?? [:],
            APIParameterName.extra.rawValue                 : self.extra ?? [:]
        ]
    }
    
}
