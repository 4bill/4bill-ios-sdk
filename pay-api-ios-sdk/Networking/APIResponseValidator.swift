//
//  APIResponseValidator.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Foundation
import Alamofire
import Marshal

func APIResponseValidator(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Request.ValidationResult {
    var errorDescription: APIErrorDescription? = nil
    if let jsonData = data, let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? MarshaledObject, let errorJSON = json.optionalAny(for: APIParameterName.error.rawValue) as? MarshaledObject {
        errorDescription = try? APIErrorDescription(object: errorJSON)
    }
    
    if let description = errorDescription {
        print("errorDescription: \(description)")
    }
    switch response.statusCode {
    default:
        if let code = errorDescription?.code,
           let error = APIError.from(code: code, description: errorDescription?.text ?? errorDescription?.title ?? "undefined") {
            if error.code == APIErrorCode.success.rawValue {
                return .success(Void())
            }
            return .failure(error)
        }
        if let error = APIError.from(code: response.statusCode, description: errorDescription?.text ?? "undefined") {
            return .failure(error)
        }
        break
    }
    return .success(Void())
}
