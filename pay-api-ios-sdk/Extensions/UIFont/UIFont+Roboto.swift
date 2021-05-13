//
//  UIFont+Roboto.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 13.05.2021.
//

import UIKit

enum RobotoFontStyle {
    case medium
    
    static var fontFamily: String {
        return "Roboto"
    }
    
    private var styleName: String {
        switch self {
        case .medium:
            return "Medium"
        }
    }
    
    var name: String {
        return RobotoFontStyle.fontFamily + "-" + self.styleName
    }
}

extension UIFont {
    
    static func roboto(size: CGFloat, style: RobotoFontStyle) -> UIFont {
        return UIFont(name: style.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
