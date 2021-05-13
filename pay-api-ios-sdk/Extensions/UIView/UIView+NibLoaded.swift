//
//  UIView+NibLoaded.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import UIKit
import QuickLayout

extension UIView {
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(type(of: self).className, owner: self, options: nil)?.first as? T else {
            return nil
        }
        addSubview(contentView)
        contentView.fillSuperview()
        return contentView
    }
    
}
