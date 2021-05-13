//
//  Core.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 10.04.2021.
//

import Foundation

class Core: NSObject {
    
    //MARK: - Shared
    
    static var shared = Core()
    
    //MARK: - Properties
    
    private var _authManager = AuthManager()
    
    //MARK: - Getters
    
    var authManager: AuthManager {
        return self._authManager
    }
    
}
