//
//  Group.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct Group {
    
    let id: Int
    let name: String
    var parentID: Int?
    
}

//MARK: - Unmarshaling
extension Group: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.id = try object.any(for: APIParameterName.id.rawValue) as! Int
        self.name = try object.any(for: APIParameterName.name.rawValue) as! String
        self.parentID = object.optionalAny(for: APIParameterName.parentID.rawValue) as? Int
    }
    
}
