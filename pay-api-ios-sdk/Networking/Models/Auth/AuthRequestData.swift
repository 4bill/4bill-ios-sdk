//
//  AuthRequestData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 25.04.2021.
//

import Foundation
import Marshal

struct AuthRequestData {
    
    var point: Int
    var key: Int64
    var hash: String
}

//MARK: - JSONMarshaling
extension AuthRequestData: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.point.rawValue     : self.point,
            APIParameterName.key.rawValue       : self.key,
            APIParameterName.hash.rawValue      : self.hash
        ]
    }
    
}

//MARK: - Unmarshaling
//extension AuthRequestData: Unmarshaling {
//    
//    init(object: MarshaledObject) throws {
//        self.point = try object.any(for: APIParameterName.point.rawValue) as! Int
//        self.key = try object.any(for: APIParameterName.key.rawValue) as! Double
//        self.hash = try object.any(for: APIParameterName.hash.rawValue) as! String
//    }
//    
//}
