//
//  APIClient.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Foundation
import Alamofire
import Marshal



class APIClient {
    
    //MARK: - Defaults
    
    private enum Defaults {
        static let token = "4Billio.APIClient.Defaults.token"
        static let refreshToken = "4Billio.APIClient.Defaults.refreshToken"
    }
    
    // MARK: - Instance
    
    static let shared = APIClient()
    
    // MARK: - Properties
    
    let baseURL: URL = URL(string: APIConstants.apiURL)!
    
    lazy var manager: Session = {
        let session = Session(configuration: sessionConfiguration, interceptor: self, serverTrustManager: ServerTrustManager(evaluators: serverTrustPolicies))
        return session
    }()
    
    // MARK: - Setters
    
    var token: String? {
        set {
            guard let newValue = newValue, !newValue.isEmpty else {
                UserDefaults.standard.set(nil, forKey: Defaults.token)
                return
            }
            UserDefaults.standard.set(newValue, forKey: Defaults.token)
        }
        get {
            return UserDefaults.standard.string(forKey: Defaults.token)
        }
    }
    
    var refreshToken: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: Defaults.refreshToken)
        }
        get {
            UserDefaults.standard.string(forKey: Defaults.refreshToken)
        }
    }
    
    
    // MARK: - Getters
    
    var isLogged: Bool {
        return self.token != nil && self.refreshToken != nil
    }
    
    // MARK: - Initialization
    
    init() { }
    
    // MARK: - Lifecycle
    
    func registerSession(handler: AuthSessionData) {
        print("[APIClient]: Register auth session with = \(handler)")
        self.token        = handler.accessToken
        self.refreshToken = handler.refreshToken
    }
    
    
    func unregisterSession() {
        print("[APIClient]: Auth session data has been destroyed.")
        self.token        = nil
        self.refreshToken = nil
    }

}

//MARK: - RequestInterceptor
extension APIClient: RequestInterceptor {
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.setValue(APIConstants.defaultUserAgent, forHTTPHeaderField: APIHeaders.userAgent.rawValue)
        if let token = APIClient.shared.token {
            request.setValue(APISecurityScheme.bearer.rawValue + " \(token)", forHTTPHeaderField: APIHeaders.authorization.rawValue)
        }
        completion(.success(request))
    }
    
}
