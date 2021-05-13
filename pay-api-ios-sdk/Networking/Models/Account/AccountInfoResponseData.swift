//
//  AccountInfoResponseData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct AccountInfoResponseData {
    
    let id: Int
    let status: Int
    let created: String
    let name: String
    let isTest: Bool
    let wallets: [Wallet]
}

//MARK: - Unmarshaling
extension AccountInfoResponseData: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.id = try object.any(for: APIParameterName.id.rawValue) as! Int
        self.status = try object.any(for: APIParameterName.status.rawValue) as! Int
        self.created = try object.any(for: APIParameterName.created.rawValue) as! String
        self.name = try object.any(for: APIParameterName.name.rawValue) as! String
        self.isTest = try object.any(for: APIParameterName.isTest.rawValue) as! Bool
        self.wallets = SerializerUtils.getArrayOf(type: Wallet.self, from: object, by: APIParameterName.wallets.rawValue) ?? []
    }
    
}
