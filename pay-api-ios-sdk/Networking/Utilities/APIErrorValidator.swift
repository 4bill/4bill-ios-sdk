//
//  APIErrorValidator.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Foundation
import Alamofire

func APIErrorValidator(_ error: Error) -> APIError {
    if error is APIError {
        return error as! APIError
    }
    if let afError = error as? AFError,
       let apiError = afError.underlyingError as? APIError {
        return apiError
    }
    if (error as NSError).code == NSURLErrorCancelled {
        return APIError.cancelledRequest
    }
    if (error as NSError).code == NSURLErrorNotConnectedToInternet {
        return APIError.noInternet
    }
    if let error = APIError.from(code: error.errorCode, description: error.localizedDescription) {
        return error
    }
    return APIError.server(errorDescription: nil)
}
