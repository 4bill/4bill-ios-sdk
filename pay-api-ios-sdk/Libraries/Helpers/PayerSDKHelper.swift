//
//  PayerSDKHelper.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import Foundation
import Marshal
import Alamofire
import Promise

class PayerSDKHelper {
    
    //MARK: - Shared
    
    static var shared = PayerSDKHelper()
    
    //MARK: - Lifecycle
    
    func getTransactionAuthenticationType(from result: JSONObject?) -> TransactionAuthorization? {
        guard let authTypeDescriptions = result?.optionalAny(for: APIParameterName.payerAuth.rawValue) as? String else {
            return nil
        }
        return TransactionAuthorization(rawValue: authTypeDescriptions)
    }
    
    //MARK: - 3Ds
    
    func get3DsVerification(with object: JSONObject?) -> ThreeDsVerification? {
        guard let data = object else {
            return nil
        }
        do {
            let payResult = try ThreeDsVerification(object: data)
            return payResult
        } catch {
            print("[PayerSDKHelper] get3Ds error: \(error)")
            return nil
        }
    }
    
    func threeDs(termUrl: URL, acsURL: URL, pareq: String, md: Int) -> Promise<String?> {
        return Promise { fulfill, reject in
            let parameters: [String : Any] = [
                APIParameterName.md.rawValue : md,
                APIParameterName.paReq.rawValue : pareq,
                APIParameterName.termUrl.rawValue : termUrl.description
            ]
            AF.request(acsURL, method: .post,  parameters: parameters, encoding: URLEncoding.httpBody).responseString { (response) in
                switch response.result {
                
                case .success(let htmlString):
//                    let json = SerializerUtils.toDictionary(jsonString: jsonString)
//                    let pares = json?[APIParameterName.paymentAuthResponse.rawValue] as? String
                    return fulfill(htmlString)
                case .failure(let error):
                    return reject(error)
                }
            }
        }
    }
    
    
    
}
