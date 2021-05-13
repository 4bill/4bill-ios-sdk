//
//  RoundedButton.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import UIKit

class RoundedButton: BaseButton {

    @IBInspectable var cornerRadius: CGFloat = 8.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.cornerRadius
    }
    
}

