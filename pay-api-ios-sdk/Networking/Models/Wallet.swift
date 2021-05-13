//
//  Wallet.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct Wallet {
    
    let id: Int
    let name: String
    let currency: String
    let balance: Float
    let balanceMin: Float
    let reserve: Float
    let status: Int
    let updated: String
    
}

//MARK: - Unmarshaling
extension Wallet: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.id = try object.any(for: APIParameterName.id.rawValue) as! Int
        self.name = try object.any(for: APIParameterName.name.rawValue) as! String
        self.currency = try object.any(for: APIParameterName.currency.rawValue) as! String
        self.balance = try object.any(for: APIParameterName.balance.rawValue) as! Float
        self.balanceMin = try object.any(for: APIParameterName.balanceMin.rawValue) as! Float
        self.reserve = try object.any(for: APIParameterName.reserve.rawValue) as! Float
        self.status = try object.any(for: APIParameterName.status.rawValue) as! Int
        self.updated = try object.any(for: APIParameterName.updatedAt.rawValue) as! String
    }
    
}
