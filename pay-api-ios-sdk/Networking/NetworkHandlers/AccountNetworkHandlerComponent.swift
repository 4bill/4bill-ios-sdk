//
//  AccountNetworkHandlerComponent.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 30.04.2021.
//

import Foundation
import Marshal

class AccountNetworkHandlerComponent: BaseNetworkHandler {

    func getAccountInfo(completion: @escaping(AccountInfoResponseData) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = AccountInfoRequestData(auth: auth)
        let request = APIClient.shared.getAccountInfo(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .getAccountInfo)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .getAccountInfo)
                return
            }
            completion(result)
            self?.finishRequest(type: .getAccountInfo)
        }
        self.startRequest(with: request, type: .getAccountInfo)
    }
    
}
