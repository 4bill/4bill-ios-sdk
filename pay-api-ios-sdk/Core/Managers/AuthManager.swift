//
//  AuthManager.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 30.04.2021.
//

import Foundation

class AuthManager: NSObject {
    
    //MARK: - Properties
    
    /// provided by payment company
    private var accountID: Int?
    
    /// provided by payment company
    private var walletID: Int?
    
    /// provided by payment company
    private var pointID: Int?
        
    /// provided by payment company
    private var authToken: String?
    
    /// client generated
    private var sessionKey: Int64?
    
    /// client generated
    private var clientHash: String?
    
    //MARK: - Lifecycle
    
    private func updateSessionKey() {
        self.sessionKey = Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func configure(accountID: Int, walletID: Int, pointID: Int, authToken: String) {
        self.updateSessionKey()
        self.accountID = accountID
        self.walletID = walletID
        self.pointID = pointID
        self.authToken = authToken
        self.clientHash = self.getHash()
    }
    
    func getAuthentication() -> AuthRequestData? {
        guard let point = self.pointID,
              let key = self.sessionKey,
              let hash = self.clientHash
              else {
            return nil
        }
        return AuthRequestData(point: point, key: key, hash: hash)
    }
    
    func getAccountID() -> Int? {
        return self.accountID
    }
    
    func getWalletID() -> Int? {
        return self.walletID
    }
    
    func getPointID() -> Int? {
        return self.pointID
    }
    
    func getAuthToken() -> String? {
        return self.authToken
    }
    
    //MARK: - Private
    
    private func getHash() -> String? {
        guard let point = self.pointID,
              let key = self.sessionKey,
              let token = self.authToken else {
            return nil
        }
        let dataString = point.description + token + key.description 
        let hash = CryptoHelper.shared.md5(string: dataString)
        return hash
    }
    
}
