//
//  Commissions.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct Commissions {
    
    let point: Commission
    let customer: Commission
    
}

//MARK: - JSONMarshaling
extension Commissions: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.point = SerializerUtils.getObjectOf(type: Commission.self, from: object, by: APIParameterName.point.rawValue)!
        self.customer = SerializerUtils.getObjectOf(type: Commission.self, from: object, by: APIParameterName.customer.rawValue)!
    }
    
}
