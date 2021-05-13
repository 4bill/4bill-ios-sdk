//
//  CancelTransactionRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 26.04.2021.
//

import Foundation
import Marshal

struct CancelTransactionRequestData {
    
    let auth: AuthRequestData
    let id: Int
    
}

//MARK: - JSONMarshaling
extension CancelTransactionRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.auth.rawValue : self.auth.jsonObject(),
            APIParameterName.id.rawValue : self.id
        ]
    }
    
}
