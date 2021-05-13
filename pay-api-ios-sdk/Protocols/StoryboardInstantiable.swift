//
//  StoryboardInstantiable.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 10.04.2021.
//

import UIKit

protocol StoryboardInstantiable: class {
    
    static var storyboardName: String { get }
    
}

extension StoryboardInstantiable where Self: UIViewController {
    
    static func storyboardInstance() -> Self? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self
    }
    
    static func navigationController() -> UINavigationController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
    
}
