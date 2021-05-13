//
//  CardUsecase.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import Foundation

//MARK: - Declaration

protocol CardUsecase {
    
    var cardNetworkComponent: CardNetworkHandlerComponent { get }
    
    func addCardToWhitelist(cardNumber: String?, cardToken: String?, completion: @escaping(Bool) -> Void)
    
    func checkCard(cardNumber: String?, cardToken: String?, completion: @escaping(CheckCardResponseData) -> Void)
    
}

//MARK: - Implementation

extension CardUsecase {
    
    func addCardToWhitelist(cardNumber: String?, cardToken: String?, completion: @escaping(Bool) -> Void) {
        self.cardNetworkComponent.addCardToWhitelist(cardNumber: cardNumber, cardToken: cardToken, completion: completion)
    }
    
    func checkCard(cardNumber: String?, cardToken: String?, completion: @escaping(CheckCardResponseData) -> Void) {
        self.cardNetworkComponent.checkCard(cardNumber: cardNumber, cardToken: cardToken, completion: completion)
    }
    
}
