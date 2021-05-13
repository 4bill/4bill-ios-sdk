//
//  AuthSessionData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 17.04.2021.
//

import Marshal

struct AuthSessionData {
    let refreshToken: String
    let accessToken: String
}

// MARK: - Unmarshaling
extension AuthSessionData: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.refreshToken       = try object.any(for: APIParameterName.refreshToken.rawValue) as! String
        self.accessToken        = try object.any(for: APIParameterName.accessToken.rawValue) as! String
    }
    
}
