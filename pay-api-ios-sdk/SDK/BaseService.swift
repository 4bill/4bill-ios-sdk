//
//  BaseService.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 07.05.2021.
//

import Foundation
import Marshal
import Promise

class BaseService: NSObject {
    
    //MARK: - Properties
    
    internal lazy var transactionQueue: DispatchQueue = {
        return DispatchQueue(label: Queue.transaction.rawValue, attributes: .concurrent)
    }()
    
    var termURL: URL?
    
    //MARK: - Lifecycle
    
    func proceed3Ds(with result: JSONObject?, transactionID: Int) -> Promise<String?> {
        return Promise { fulfill, reject in
            guard let verification = PayerSDKHelper.shared.get3DsVerification(with: result) else {
                return fulfill(nil)
            }
            self.threeDs(acsURL: verification.acsURL, pareq: verification.pareq, md: verification.md).then { (htmlString) in
                fulfill(htmlString)
            }.catch { (error) in
                reject(error)
            }
        }
    }
    
    func proceedWith(payURL: URL?, transactionID: Int, externalTransactionID: String?, callback: ((_ payURL: URL, _ transactionID: Int, _ externalTransactionID: String?) ->())?) {
        guard let payURL = payURL else {
            return
        }
        callback?(payURL, transactionID, externalTransactionID)
    }
    
    fileprivate func threeDs(acsURL: URL, pareq: String, md: Int) -> Promise<String?> {
        return Promise { fulfill, reject in
            guard let termUrl = self.termURL else {
                fatalError("[PaymentSDK.BaseService] provide termURL to complete 3ds verification")
            }
            PayerSDKHelper.shared.threeDs(termUrl: termUrl, acsURL: acsURL, pareq: pareq, md: md).then { (htmlString) in
                fulfill(htmlString)
            }.catch { (error) in
                reject(error)
            }
        }
    }
    
}
