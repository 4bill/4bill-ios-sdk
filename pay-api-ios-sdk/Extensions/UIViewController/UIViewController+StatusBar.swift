//
//  UIViewController+StatusBar.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 10.04.2021.
//

import UIKit

extension UIViewController {
    
    var statusBarHeight: CGFloat {
        return self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
}
