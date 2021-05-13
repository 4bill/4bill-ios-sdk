//
//  FindTransactionRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct FindTransactionRequestData {
    
    let auth: AuthRequestData
    
    var id: Int?
    var externalTransactionID: String?
    
}

//MARK: - JSONMarshaling
extension FindTransactionRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.auth.rawValue : self.auth.jsonObject(),
            APIParameterName.id.rawValue : self.id?.description,
            APIParameterName.externalTransactionID.rawValue : self.externalTransactionID
        ]
    }
    
}
