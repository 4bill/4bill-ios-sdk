//
//  ServiceListResponseData.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 28.04.2021.
//

import Foundation
import Marshal

struct ServiceListResponseData {
    
    let services: [Service]
    let group: [Group]
    
}

//MARK: - Unmarshaling
extension ServiceListResponseData: Unmarshaling {
    
    init(object: MarshaledObject) throws {
        self.services = SerializerUtils.getArrayOf(type: Service.self, from: object, by: APIParameterName.name.rawValue) ?? []
        self.group = SerializerUtils.getArrayOf(type: Group.self, from: object, by: APIParameterName.groups.rawValue) ?? []
    }
    
}
