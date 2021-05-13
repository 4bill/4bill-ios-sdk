//
//  Constants+Notifications.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import Foundation


enum SDKNotification {
    static let hideKeyboardNotification: NSNotification.Name = NSNotification.Name(SDKNotificationDescriptions.hideKeyboardNotification)
}

enum SDKNotificationDescriptions {
    static let hideKeyboardNotification = "AppNotification.hideKeyboardNotification"
}
