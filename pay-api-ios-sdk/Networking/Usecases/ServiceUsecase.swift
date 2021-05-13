//
//  ServiceUsecase.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import Foundation

//MARK: - Declaration

protocol ServiceUsecase {
    
    var serviceNetworkComponent: ServiceNetworkHandlerComponent { get }
    
    func getServiceList(completion: @escaping(ServiceListResponseData) -> Void)
    
    func getService(serviceID: Int,completion: @escaping(ServiceResponseData) -> Void)
    
}

//MARK: - Implementation

extension ServiceUsecase {
    
    func getServiceList(completion: @escaping(ServiceListResponseData) -> Void) {
        self.serviceNetworkComponent.getServiceList(completion: completion)
    }
    
    func getService(serviceID: Int,completion: @escaping(ServiceResponseData) -> Void) {
        self.serviceNetworkComponent.getService(serviceID: serviceID, completion: completion)
    }
    
}
