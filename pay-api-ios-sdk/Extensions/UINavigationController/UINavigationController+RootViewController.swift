//
//  UINavigationController+RootViewController.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 10.04.2021.
//

import UIKit

extension UINavigationController {

    var rootViewController: UIViewController? {
        return viewControllers.first
    }
    
}
