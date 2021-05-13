//
//  UIFont+SFPro.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import UIKit

enum SFProFontStyle {
    
    case thin
    case semiboldItalic
    case regularItalic
    case light
    case regular
    case bold
    case medium
    case heavy
    case semibold
    case mediumItalic
    case heavyItalic
    case ultraLight
    case ultraLightItalic
    case lightItalic
    case blackItalic
    case black
    case thinItalic
    case boldItalic
    
    static var fontFamily: String {
        return "SF-Pro-Display"
    }
    
    private var styleName: String {
        switch self {
        case .thin:
            return "Thin"
        case .semiboldItalic:
            return "SemiboldItalic"
        case .regularItalic:
            return "RegularItalic"
        case .light:
            return "Light"
        case .regular:
            return "Regular"
        case .bold:
            return "Bold"
        case .medium:
            return "Medium"
        case .heavy:
            return "Heavy"
        case .semibold:
            return "Semibold"
        case .mediumItalic:
            return "MediumItalic"
        case .heavyItalic:
            return "HeavyItalic"
        case .ultraLight:
            return "Ultralight"
        case .ultraLightItalic:
            return "UltralightItalic"
        case .lightItalic:
            return "LightItalic"
        case .blackItalic:
            return "BlackItalic"
        case .black:
            return "Black"
        case .thinItalic:
            return "ThinItalic"
        case .boldItalic:
            return "BoldItalic"
        }
    }
    
    var name: String {
        return SFProFontStyle.fontFamily + "-" + self.styleName
    }
    
}

extension UIFont {
    
    static func sfPro(size: CGFloat, style: SFProFontStyle) -> UIFont {
        return UIFont(name: style.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
