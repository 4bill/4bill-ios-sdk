//
//  CardNetworkHandlerComponent.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 30.04.2021.
//

import Foundation
import Marshal

class CardNetworkHandlerComponent: BaseNetworkHandler {

    func addCardToWhitelist(cardNumber: String?, cardToken: String?, completion: @escaping(Bool) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = AddCardToWhitelistRequestData(auth: auth, cardNumber: cardNumber, cardToken: cardToken)
        let request = APIClient.shared.addCardToWhiteList(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .addCardToWhitelist)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .addCardToWhitelist)
                return
            }
            completion(result.isSuccessCode)
            self?.finishRequest(type: .addCardToWhitelist)
        }
        self.startRequest(with: request, type: .addCardToWhitelist)
    }

    func checkCard(cardNumber: String?, cardToken: String?, completion: @escaping(CheckCardResponseData) -> Void) {
        guard let auth = Core.shared.authManager.getAuthentication() else {
            return
        }
        let requestData = CheckCardRequestData(auth: auth, cardNumber: cardNumber, cardToken: cardToken)
        let request = APIClient.shared.checkCard(data: requestData) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.state = .failure(APIErrorValidator(error), .checkCard)
                return
            }
            guard let result = response?.result else {
                self?.delegate?.state = .failure(.objectNotFound(errorDescription: nil), .checkCard)
                return
            }
            completion(result)
            self?.finishRequest(type: .checkCard)
        }
        self.startRequest(with: request, type: .checkCard)
    }
    
}
