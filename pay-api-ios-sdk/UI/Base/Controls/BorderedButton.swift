//
//  BorderedButton.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 13.04.2021.
//

import UIKit

class BorderedButton: RoundedButton {
    
    //MARK: - Properties
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
}
