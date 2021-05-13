//
//  APIErrorDescription.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Marshal

struct APIErrorDescription {
    
    let code: Int
    let title: String?
    let text: String?
    
}

//MARK: - Unmarshaling
extension APIErrorDescription: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        code = try object.any(for: APIParameterName.code.rawValue) as! Int
        title = object.optionalAny(for: APIParameterName.title.rawValue) as? String
        text = object.optionalAny(for: APIParameterName.message.rawValue) as? String
    }
    
}

extension APIErrorDescription {
    
    var isSuccessCode: Bool {
        return self.code == APIErrorCode.success.rawValue
    }
    
}
