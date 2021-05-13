//
//  NSRange+Deleting.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 10.04.2021.
//

import Foundation

extension NSRange {
    
    var isDeleting: Bool {
        return self.length > 0
    }
    
}
