//
//  Constants.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 10.04.2021.
//

import UIKit

//MARK: - Other

enum Sides {
    case left
    case right
}

enum Place {
    case front
    case back
}

enum Separator {
    static let zero = "0"
    static let spacer = " "
    static let clear = ""
    static let point = "."
    static let dash = "-"
    static let comma = ","
    static let slash = " / "
    static let star = "*"
}

enum Month: Int, CaseIterable {
    case january
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case oktober
    case november
    case december
    
    var monthNumber: String {
        switch self {
        case .january:
            return "01"
        case .february:
            return "02"
        case .march:
            return "03"
        case .april:
            return "04"
        case .may:
            return "05"
        case .june:
            return "06"
        case .july:
            return "07"
        case .august:
            return "08"
        case .september:
            return "09"
        case .oktober:
            return "10"
        case .november:
            return "11"
        case .december:
            return "12"
        }
    }
    
}

// MARK: - Animation

enum AnimationDuration {
    static let `default`: TimeInterval = 0.3
    static let signUpLogoViewElement: TimeInterval = 1.0
    static let signUpAuthElements: TimeInterval = 1.5
}

//MARK: - Images

enum SDKImage {
//    static let camera: UIImage? = UIImage(named: "sdk_icon_camera")
//    static let dropDown: UIImage? = UIImage(named: "sdk_icon_drop_down")
//    static let info: UIImage? = UIImage(named: "sdk_icon_info")
    static let camera: UIImage? = UIImage(named: "sdk_icon_camera", in: BundleHelper.bundle, with: nil)
    static let dropDown: UIImage? = UIImage(named: "sdk_icon_drop_down", in: BundleHelper.bundle, with: nil)
    static let info: UIImage? = UIImage(named: "sdk_icon_info", in: BundleHelper.bundle, with: nil)
}

//MARK: - Buttons

enum SDKButton {
    case camera
    case dropDown
    case info
    
    var title: String {
        switch self {
        case .camera:
            return SDKButtonDescriptions.camera
        case .dropDown:
            return SDKButtonDescriptions.dropdown
        case .info:
            return SDKButtonDescriptions.info
        }
    }
    
    static func from(string: String) -> SDKButton? {
        switch string {
        case SDKButtonDescriptions.camera       : return .camera
        case SDKButtonDescriptions.dropdown     : return .dropDown
        case SDKButtonDescriptions.info         : return .info
        default:
            return nil
        }
    }
    
}

enum SDKButtonDescriptions {
    static let camera = "camera"
    static let dropdown = "dropDown"
    static let info = "info"
}

//MARK: - Masks

enum Mask: String {
    case card = "xxxx xxxx xxxx xxxx"
}

//MARK: - Transaction

enum TransactionAuthorization: String {
    case none = "NONE"
    case threeDs = "3DS"
    case lookUp = "LOOKUP"
    case otp = "OTP"
    case redirect = "REDIRECT"
    case unknow = "UNKNOWN"
}

enum TransactionStatus: Int {
    
    case new = 0
    case success = 1
    case failed = 2
    case cancelled = 3
    case reversed = 4
    case expired = 5
    case authorized = 6
    case pending = 10
    
    var isFinal: Bool {
        switch self {
        case .success, .failed, .cancelled, .reversed, .expired:
            return true
        case .new, .authorized, .pending:
            return false
        }
    }
    
}

//MARK: - Locale

public enum Locale: String {
    case ua = "ua"
    case en = "en"
    case ru = "ru"
}

//MARK: - PaymentService

public enum VerificationCode {
    case lookUpCode
    case otp
    
    public var title: String {
        switch self {
        case .lookUpCode:
            return "Look up code"
        case .otp:
            return "OTP code"
        }
    }
}

//MARK: - Queues

enum Queue: String {
    case transaction = "Queue.transaction"
}
