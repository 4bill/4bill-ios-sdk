//
//  ViewModelHandler.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Foundation

class ViewModelHandler<T>: NSObject {
    var data: T?
    var error: APIError?
    
    init(data: T?, error: APIError?) {
        self.data = data
        self.error = error
    }
}
