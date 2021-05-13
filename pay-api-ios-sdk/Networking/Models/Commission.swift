//
//  Commission.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct Commission {
    
    let percent: Float
    let fix: Float
    let min: Float
    let max: Float
    
}

//MARK: - Unmarshaling
extension Commission: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.percent = try object.any(for: APIParameterName.percent.rawValue) as! Float
        self.fix = try object.any(for: APIParameterName.fix.rawValue) as! Float
        self.min = try object.any(for: APIParameterName.min.rawValue) as! Float
        self.max = try object.any(for: APIParameterName.max.rawValue) as! Float
    }
    
}

//MARK: - JSONMarshaling
extension Commission: JSONMarshaling {
    
    func jsonObject() -> JSONObject {
        return [
            APIParameterName.percent.rawValue : self.percent,
            APIParameterName.fix.rawValue : self.fix,
            APIParameterName.min.rawValue : self.min,
            APIParameterName.max.rawValue : self.max
        ]
    }
    
}
