//
//  ServiceField.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct ServiceField {
    
    let name: String
    let slug: String
    let type: String
    let isRequired: Bool
    var hint: String?
    var mask: String?
    var placeholder: String?
    var regex: String?
    var validationType: String?
    
}

//MARK: - Unmarshaling
extension ServiceField: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.name = try object.any(for: APIParameterName.name.rawValue) as! String
        self.slug = try object.any(for: APIParameterName.slug.rawValue) as! String
        self.type = try object.any(for: APIParameterName.type.rawValue) as! String
        self.isRequired = try object.any(for: APIParameterName.required.rawValue) as! Bool
        self.hint = object.optionalAny(for: APIParameterName.hint.rawValue) as? String
        self.mask = object.optionalAny(for: APIParameterName.mask.rawValue) as? String
        self.placeholder = object.optionalAny(for: APIParameterName.placeholder.rawValue) as? String
        self.regex = object.optionalAny(for: APIParameterName.regex.rawValue) as? String
        self.validationType = object.optionalAny(for: APIParameterName.validationType.rawValue) as? String
    }
    
}
