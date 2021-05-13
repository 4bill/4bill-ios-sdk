//
//  CheckCardResponseData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 29.04.2021.
//

import Foundation
import Marshal

struct CheckCardResponseData {
        
    var isInWhitelist: Bool
    var isInBlacklist: Bool
    
}

//MARK: - Unmarshaling
extension CheckCardResponseData: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.isInWhitelist = try object.any(for: APIParameterName.isInWhitelist.rawValue) as! Bool
        self.isInBlacklist = try object.any(for: APIParameterName.isInBlacklist.rawValue) as! Bool
    }
    
}
