//
//  ErrorProtocol.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 10.04.2021.
//

import Foundation

protocol ErrorProtocol: class {
    
    func didFail(with error: Error)
    
}
