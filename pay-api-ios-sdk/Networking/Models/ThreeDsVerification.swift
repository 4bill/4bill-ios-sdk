//
//  ThreeDsVerification.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import Foundation
import Marshal

struct ThreeDsVerification {
    
    var payerAuth: String
    var acsURL: URL
    var pareq: String
    var md: Int
}

//MARK: - Unmarshaling
extension ThreeDsVerification: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.payerAuth = try object.any(for: APIParameterName.payerAuth.rawValue) as! String
        let urlLink = try object.any(for: APIParameterName.acsUrl.rawValue) as! String
        self.acsURL = URL(string: urlLink)!
        self.pareq = try object.any(for: APIParameterName.pareq.rawValue) as! String
        self.md = try object.any(for: APIParameterName.md.rawValue.lowercased()) as! Int
    }
    
}
