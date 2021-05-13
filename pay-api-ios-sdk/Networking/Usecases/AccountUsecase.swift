//
//  AccountUsecase.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import Foundation

//MARK: - Declaration

protocol AccountUsecase {
    
    var accountNetworkComponent: AccountNetworkHandlerComponent { get }
    
    func getAccountInfo(completion: @escaping(AccountInfoResponseData) -> Void)
    
}

//MARK: - Implementation

extension AccountUsecase {
    
    func getAccountInfo(completion: @escaping(AccountInfoResponseData) -> Void) {
        self.accountNetworkComponent.getAccountInfo(completion: completion)
    }
    
}
