//
//  CancelTransactionResponseData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 26.04.2021.
//

import Foundation
import Marshal

public struct CancelTransactionResponseData {
        
    public let id: Int
    public let isTest: Bool
    public let status: Int
    
}

//MARK: - Unmarshaling
extension CancelTransactionResponseData: Unmarshaling {
    
    public init(object: MarshaledObject) throws {
        self.id = try object.any(for: APIParameterName.id.rawValue) as! Int
        self.isTest = try object.any(for: APIParameterName.isTest.rawValue) as! Bool
        self.status = try object.any(for: APIParameterName.status.rawValue) as! Int
    }
    
}
