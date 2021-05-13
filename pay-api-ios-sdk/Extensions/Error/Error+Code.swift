//
//  Error+Code.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 18.04.2021.
//

import Foundation

extension Error {
        
    var errorCode: Int {
        return (self as NSError).code
    }
    
}
