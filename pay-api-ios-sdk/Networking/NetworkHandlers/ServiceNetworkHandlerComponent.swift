//
//  ServiceNetworkHandlerComponent.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 30.04.2021.
//

import Foundation
import Marshal

class ServiceNetworkHandlerComponent: BaseNetworkHandler {
    
    func getServiceList(completion: @escaping(ServiceListResponseData) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = ServiceListRequestData(auth: auth)
        let request = APIClient.shared.getServiceList(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .getServiceList)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .getServiceList)
                return
            }
            completion(result)
            self?.finishRequest(type: .getServiceList)
        }
        self.startRequest(with: request, type: .getServiceList)
    }
    
    func getService(serviceID: Int,completion: @escaping(ServiceResponseData) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = ServiceRequestData(serviceID: serviceID, auth: auth)
        let request = APIClient.shared.getService(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .getService)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .getService)
                return
            }
            completion(result)
            self?.finishRequest(type: .getService)
        }
        self.startRequest(with: request, type: .getService)
    }
    
}
