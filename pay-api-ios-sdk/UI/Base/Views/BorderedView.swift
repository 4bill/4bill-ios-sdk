//
//  BorderedView.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import UIKit

@IBDesignable
class BorderedView: RoundedView {
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
}
