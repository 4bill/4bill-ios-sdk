//
//  RechabilityManager.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Alamofire
import Foundation

protocol RechabilityState {
    var connectionRestore: (() -> Void)? { get set }
    var connectionLost: (() -> Void)? { get set }
    func isConnected() -> Bool
}

class RechabilityManager: RechabilityState {
    var connectionRestore: (() -> Void)?
    var connectionLost: (() -> Void)?
    
    private var rechabilityManager = Alamofire.NetworkReachabilityManager(host: APIConstants.reachabilityManagerHost)
    
    init() {
        rechabilityManager?.startListening(onUpdatePerforming: { [weak self] (status) in
            switch status {
                
            case .notReachable, .unknown:
                self?.connectionLost?()
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                self?.connectionRestore?()
            }
        })
    }
    
    deinit {
        rechabilityManager?.stopListening()
    }
    
    // MARK: - RechabilityState
    
    func isConnected() -> Bool {
        return rechabilityManager?.isReachable ?? false
    }
}

