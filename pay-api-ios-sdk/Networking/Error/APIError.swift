//
//  APIError.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Foundation
import Alamofire

public enum APIError: Error {
    case noInternet
    case invalidResponse
    case cancelledRequest
    case objectNotFound(errorDescription: APIErrorDescription?)
    
    
    //4billio
    case server(errorDescription: APIErrorDescription?)
    
    case success(description: String?)
    case badRequest(description: String?)
    case invalidAuth(description: String?)
    case incorrectHeaders(description: String?)
    case internalError(description: String?)
    case forbiddenIP(description: String?)
    case requestsLimitExceeded(description: String?)
    case invalidToken(description: String?)
    case serverUnavailable(description: String?)
    case transparencyTokenIsRequired(description: String?)
    case transparencyTokenIsExpired(description: String?)
    case transparencyTokenNotFoundInSystem(description: String?)
    case transparencyTokenOrExternalTransactionIdNotFoundInSystem(description: String?)
    case invalidTransparencyToken(description: String?)
    case accountNotFound(description: String?)
    case walletNotFound(description: String?)
    case notEnoughBalance(description: String?)
    case currencyNotSupportedByWallet(description: String?)
    case unableToConvertCurrency(description: String?)
    case currencyIsRequired(description: String?)
    case walletHasReachedServiceLimit(description: String?)
    case serviceLimitHasBeenReached(description: String?)
    case transactionNotFound(description: String?)
    case serviceNotFound(description: String?)
    case invalidServiceFieldValue(description: String?)
    case transactionWithSuchExternalIdExists(description: String?)
    case validationFailed(description: String?)
    case reverseCanNotBeDone(description: String?)
    case checkMinimumAmount(description: String?)
    case checkMaximumAmount(description: String?)
    case transactionWithIdNotFound(description: String?)
    case serviceNotAllowedForThisWallet(description: String?)
    case methodConfirmNotAllowedForThisService(description: String?)
    case noServiceCommissionsForThisServiceOrPoint(description: String?)
    case serviceLogicIsMissing(description: String?)
    case methodUpdateNotAllowedForThisService(description: String?)
    case methodPayNotAllowedForThisService(description: String?)
    case paymentFailed(description: String?)
    case currencyNotSupportedByService(description: String?)
    case paymentCreationIsFailed(description: String?)
    case incomingTransactionIdIsRequired(description: String?)
    case incomingTransactionIsNotFound(description: String?)
    case fieldExternalCommissionAmountRequired(description: String?)
    case fieldExternalCommissionAmountDoesNotExpected(description: String?)
    case cardHasLimitOnCardCreditTransaction(description: String?)
    case amountOverholdAmount(description: String?)
    case invalidSignature(description: String?)
    case cardHasLimitOnMotoTransaction(description: String?)
    case rejectedByAntifraud(description: String?)
    case unableToRegisterPayment(description: String?)
    case unableToConfirmRegisteredPayment(description: String?)
    case transactionWithSuchIdAlreadySubmitted(description: String?)
}

enum APIErrorCode: Int {
    case success = 0
    case badRequest = 10
    case invalidAuth = 11
    case incorrectHeaders = 12
    case internalError = 13
    case forbiddenIP = 14
    case requestsLimitExceeded = 15
    case invalidToken = 16
    case serverUnavailable = 17
    case transparencyTokenIsRequired = 18
    case transparencyTokenIsExpired = 19
    case transparencyTokenNotFoundInSystem = 20
    case transparencyTokenOrExternalTransactionIdNotFoundInSystem = 21
    case invalidTransparencyToken = 22
    case accountNotFound = 100
    case walletNotFound = 104
    case notEnoughBalance = 105
    case currencyNotSupportedByWallet = 106
    case unableToConvertCurrency = 107
    case currencyIsRequired = 108
    case walletHasReachedServiceLimit = 109
    case serviceLimitHasBeenReached = 110
    case transactionNotFound = 200
    case serviceNotFound = 201
    case invalidServiceFieldValue = 202
    case transactionWithSuchExternalIdExists = 203
    case validationFailed = 204
    case reverseCanNotBeDone = 205
    case checkMinimumAmount = 206
    case checkMaximumAmount = 207
    case transactionWithIdNotFound = 208
    case serviceNotAllowedForThisWallet = 209
    case methodConfirmNotAllowedForThisService = 210
    case noServiceCommissionsForThisServiceOrPoint = 211
    case serviceLogicIsMissing = 212
    case methodUpdateNotAllowedForThisService = 213
    case methodPayNotAllowedForThisService = 214
    case paymentFailed = 215
    case currencyNotSupportedByService = 216
    case paymentCreationIsFailed = 217
    case incomingTransactionIdIsRequired = 218
    case incomingTransactionIsNotFound = 219
    case fieldExternalCommissionAmountRequired = 220
    case fieldExternalCommissionAmountDoesNotExpected = 221
    case cardHasLimitOnCardCreditTransaction = 222
    case amountOverholdAmount = 223
    case invalidSignature = 224
    case cardHasLimitOnMotoTransaction = 225
    case rejectedByAntifraud = 240
    case unableToRegisterPayment = 300
    case unableToConfirmRegisteredPayment = 301
    case transactionWithSuchIdAlreadySubmitted = 350
}

func ErrorValidator(error: Error) -> APIError {
    if error is APIError {
        return error as! APIError
    }
    if error.errorCode == NSURLErrorNotConnectedToInternet {
        return APIError.noInternet
    }
    if error.errorCode == NSURLErrorCancelled {
        return APIError.cancelledRequest
    }
    if let afError = error as? AFError,
       let apiError = afError.underlyingError as? APIError {
        return apiError
    }
    return APIError.server(errorDescription: nil)
}

extension APIError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .cancelledRequest:
            return "Cancelled request"
        case .noInternet:
            return "No internet connection"
        case .objectNotFound(let errorDescription):
            return errorDescription?.text ?? "Object has been deleted"
        case .server(let errorDescription):
            return errorDescription?.text ?? "Server error"
        case .success(let description):
            return description
        case .badRequest(let description):
            return description
        case .invalidAuth(let description):
            return description
        case .incorrectHeaders(let description):
            return description
        case .internalError(let description):
            return description
        case .forbiddenIP(let description):
            return description
        case .requestsLimitExceeded(let description):
            return description
        case .invalidToken(let description):
            return description
        case .serverUnavailable(let description):
            return description
        case .transparencyTokenIsRequired(let description):
            return description
        case .transparencyTokenIsExpired(let description):
            return description
        case .transparencyTokenNotFoundInSystem(let description):
            return description
        case .transparencyTokenOrExternalTransactionIdNotFoundInSystem(let description):
            return description
        case .invalidTransparencyToken(let description):
            return description
        case .accountNotFound(let description):
            return description
        case .walletNotFound(let description):
            return description
        case .notEnoughBalance(let description):
            return description
        case .currencyNotSupportedByWallet(let description):
            return description
        case .unableToConvertCurrency(let description):
            return description
        case .currencyIsRequired(let description):
            return description
        case .walletHasReachedServiceLimit(let description):
            return description
        case .serviceLimitHasBeenReached(let description):
            return description
        case .transactionNotFound(let description):
            return description
        case .serviceNotFound(let description):
            return description
        case .invalidServiceFieldValue(let description):
            return description
        case .transactionWithSuchExternalIdExists(let description):
            return description
        case .validationFailed(let description):
            return description
        case .reverseCanNotBeDone(let description):
            return description
        case .checkMinimumAmount(let description):
            return description
        case .checkMaximumAmount(let description):
            return description
        case .transactionWithIdNotFound(let description):
            return description
        case .serviceNotAllowedForThisWallet(let description):
            return description
        case .methodConfirmNotAllowedForThisService(let description):
            return description
        case .noServiceCommissionsForThisServiceOrPoint(let description):
            return description
        case .serviceLogicIsMissing(let description):
            return description
        case .methodUpdateNotAllowedForThisService(let description):
            return description
        case .methodPayNotAllowedForThisService(let description):
            return description
        case .paymentFailed(let description):
            return description
        case .currencyNotSupportedByService(let description):
            return description
        case .paymentCreationIsFailed(let description):
            return description
        case .incomingTransactionIdIsRequired(let description):
            return description
        case .incomingTransactionIsNotFound(let description):
            return description
        case .fieldExternalCommissionAmountRequired(let description):
            return description
        case .fieldExternalCommissionAmountDoesNotExpected(let description):
            return description
        case .cardHasLimitOnCardCreditTransaction(let description):
            return description
        case .amountOverholdAmount(let description):
            return description
        case .invalidSignature(let description):
            return description
        case .cardHasLimitOnMotoTransaction(let description):
            return description
        case .rejectedByAntifraud(let description):
            return description
        case .unableToRegisterPayment(let description):
            return description
        case .unableToConfirmRegisteredPayment(let description):
            return description
        case .transactionWithSuchIdAlreadySubmitted(let description):
            return description
        default:
            return "Server error"
        }
    }
    
    public var code: Int? {
        switch self {
        case .success(description: _):
            return APIErrorCode.success.rawValue
            
        case .badRequest(description: _):
            return APIErrorCode.badRequest.rawValue
            
        case .invalidAuth(description: _):
            return APIErrorCode.invalidAuth.rawValue
            
        case .incorrectHeaders(description: _):
            return APIErrorCode.incorrectHeaders.rawValue
            
        case .internalError(description: _):
            return APIErrorCode.internalError.rawValue
            
            
        case .forbiddenIP(description: _):
            return APIErrorCode.forbiddenIP.rawValue
            
        case .requestsLimitExceeded(description: _):
            return APIErrorCode.requestsLimitExceeded.rawValue
            
        case .invalidToken(description: _):
            return APIErrorCode.invalidToken.rawValue
            
        case .serverUnavailable(description: _):
            return APIErrorCode.serverUnavailable.rawValue
            
        case .transparencyTokenIsRequired(description: _):
            return APIErrorCode.transparencyTokenIsRequired.rawValue
            
        case .transparencyTokenIsExpired(description: _):
            return APIErrorCode.transparencyTokenIsExpired.rawValue
            
        case .transparencyTokenNotFoundInSystem(description: _):
            return APIErrorCode.transparencyTokenNotFoundInSystem.rawValue
            
        case .transparencyTokenOrExternalTransactionIdNotFoundInSystem(description: _):
            return APIErrorCode.transparencyTokenOrExternalTransactionIdNotFoundInSystem.rawValue
            
        case .invalidTransparencyToken(description: _):
            return APIErrorCode.invalidTransparencyToken.rawValue
            
        case .accountNotFound(description: _):
            return APIErrorCode.accountNotFound.rawValue
            
        case .walletNotFound(description: _):
            return APIErrorCode.walletNotFound.rawValue
            
        case .notEnoughBalance(description: _):
            return APIErrorCode.notEnoughBalance.rawValue
            
        case .currencyNotSupportedByWallet(description: _):
            return APIErrorCode.currencyNotSupportedByWallet.rawValue
            
        case .unableToConvertCurrency(description: _):
            return APIErrorCode.unableToConvertCurrency.rawValue
            
        case .currencyIsRequired(description: _):
            return APIErrorCode.currencyIsRequired.rawValue
            
        case .walletHasReachedServiceLimit(description: _):
            return APIErrorCode.walletHasReachedServiceLimit.rawValue
            
        case .serviceLimitHasBeenReached(description: _):
            return APIErrorCode.serviceLimitHasBeenReached.rawValue
            
        case .transactionNotFound(description: _):
            return APIErrorCode.transactionNotFound.rawValue
            
        case .serviceNotFound(description: _):
            return APIErrorCode.serviceNotFound.rawValue
            
        case .invalidServiceFieldValue(description: _):
            return APIErrorCode.invalidServiceFieldValue.rawValue
            
        case .transactionWithSuchExternalIdExists(description: _):
            return APIErrorCode.transactionWithSuchExternalIdExists.rawValue
            
        case .validationFailed(description: _):
            return APIErrorCode.validationFailed.rawValue
            
        case .reverseCanNotBeDone(description: _):
            return APIErrorCode.reverseCanNotBeDone.rawValue
            
        case .checkMinimumAmount(description: _):
            return APIErrorCode.checkMinimumAmount.rawValue
            
        case .checkMaximumAmount(description: _):
            return APIErrorCode.checkMaximumAmount.rawValue
            
        case .transactionWithIdNotFound(description: _):
            return APIErrorCode.transactionWithIdNotFound.rawValue
            
        case .serviceNotAllowedForThisWallet(description: _):
            return APIErrorCode.serviceNotAllowedForThisWallet.rawValue
            
        case .methodConfirmNotAllowedForThisService(description: _):
            return APIErrorCode.methodConfirmNotAllowedForThisService.rawValue
            
        case .noServiceCommissionsForThisServiceOrPoint(description: _):
            return APIErrorCode.noServiceCommissionsForThisServiceOrPoint.rawValue
            
        case .serviceLogicIsMissing(description: _):
            return APIErrorCode.serviceLogicIsMissing.rawValue
            
        case .methodUpdateNotAllowedForThisService(description: _):
            return APIErrorCode.methodUpdateNotAllowedForThisService.rawValue
            
        case .methodPayNotAllowedForThisService(description: _):
            return APIErrorCode.methodPayNotAllowedForThisService.rawValue
            
        case .paymentFailed(description: _):
            return APIErrorCode.paymentFailed.rawValue
            
        case .currencyNotSupportedByService(description: _):
            return APIErrorCode.currencyNotSupportedByService.rawValue
            
        case .paymentCreationIsFailed(description: _):
            return APIErrorCode.paymentCreationIsFailed.rawValue
            
        case .incomingTransactionIdIsRequired(description: _):
            return APIErrorCode.incomingTransactionIdIsRequired.rawValue
            
        case .incomingTransactionIsNotFound(description: _):
            return APIErrorCode.incomingTransactionIsNotFound.rawValue
            
        case .fieldExternalCommissionAmountRequired(description: _):
            return APIErrorCode.fieldExternalCommissionAmountRequired.rawValue
            
        case .fieldExternalCommissionAmountDoesNotExpected(description: _):
            return APIErrorCode.fieldExternalCommissionAmountDoesNotExpected.rawValue
            
        case .cardHasLimitOnCardCreditTransaction(description: _):
            return APIErrorCode.cardHasLimitOnCardCreditTransaction.rawValue
            
        case .amountOverholdAmount(description: _):
            return APIErrorCode.amountOverholdAmount.rawValue
            
        case .invalidSignature(description: _):
            return APIErrorCode.invalidSignature.rawValue
            
        case .cardHasLimitOnMotoTransaction(description: _):
            return APIErrorCode.cardHasLimitOnMotoTransaction.rawValue
            
        case .rejectedByAntifraud(description: _):
            return APIErrorCode.rejectedByAntifraud.rawValue
            
        case .unableToRegisterPayment(description: _):
            return APIErrorCode.unableToRegisterPayment.rawValue
            
        case .unableToConfirmRegisteredPayment(description: _):
            return APIErrorCode.unableToConfirmRegisteredPayment.rawValue
            
        case .transactionWithSuchIdAlreadySubmitted(description: _):
            return APIErrorCode.transactionWithSuchIdAlreadySubmitted.rawValue
            
        default:
            return nil
        }
    }
}

extension APIError {
    
    static func from(code: Int, description: String?) -> APIError? {
        guard let errorCode = APIErrorCode(rawValue: code) else {
            return nil
        }
        switch errorCode {
        
        case .success:
            return .success(description: description)
            
        case .badRequest:
            return .badRequest(description: description)
            
        case .invalidAuth:
            return .invalidAuth(description: description)
            
        case .incorrectHeaders:
            return .incorrectHeaders(description: description)
            
        case .internalError:
            return .internalError(description: description)
            
        case .forbiddenIP:
            return .forbiddenIP(description: description)
            
        case .requestsLimitExceeded:
            return .requestsLimitExceeded(description: description)
            
        case .invalidToken:
            return .invalidToken(description: description)
            
        case .serverUnavailable:
            return .serverUnavailable(description: description)
            
        case .transparencyTokenIsRequired:
            return .transparencyTokenIsRequired(description: description)
            
        case .transparencyTokenIsExpired:
            return .transparencyTokenIsExpired(description: description)
            
        case .transparencyTokenNotFoundInSystem:
            return .transparencyTokenNotFoundInSystem(description: description)
            
        case .transparencyTokenOrExternalTransactionIdNotFoundInSystem:
            return .transparencyTokenOrExternalTransactionIdNotFoundInSystem(description: description)
            
        case .invalidTransparencyToken:
            return .invalidTransparencyToken(description: description)
            
        case .accountNotFound:
            return .accountNotFound(description: description)
            
        case .walletNotFound:
            return .walletNotFound(description: description)
            
        case .notEnoughBalance:
            return .notEnoughBalance(description: description)
            
        case .currencyNotSupportedByWallet:
            return .currencyNotSupportedByWallet(description: description)
            
        case .unableToConvertCurrency:
            return .unableToConvertCurrency(description: description)
            
        case .currencyIsRequired:
            return .currencyIsRequired(description: description)
            
        case .walletHasReachedServiceLimit:
            return .walletHasReachedServiceLimit(description: description)
            
        case .serviceLimitHasBeenReached:
            return .serviceLimitHasBeenReached(description: description)
            
        case .transactionNotFound:
            return .transactionNotFound(description: description)
            
        case .serviceNotFound:
            return .serviceNotFound(description: description)
            
        case .invalidServiceFieldValue:
            return .invalidServiceFieldValue(description: description)
            
        case .transactionWithSuchExternalIdExists:
            return .transactionWithSuchExternalIdExists(description: description)
            
        case .validationFailed:
            return .validationFailed(description: description)
            
        case .reverseCanNotBeDone:
            return .reverseCanNotBeDone(description: description)
            
        case .checkMinimumAmount:
            return .checkMinimumAmount(description: description)
            
        case .checkMaximumAmount:
            return .checkMinimumAmount(description: description)
            
        case .transactionWithIdNotFound:
            return .transactionWithIdNotFound(description: description)
            
        case .serviceNotAllowedForThisWallet:
            return .serviceNotAllowedForThisWallet(description: description)
            
        case .methodConfirmNotAllowedForThisService:
            return .methodConfirmNotAllowedForThisService(description: description)
            
        case .noServiceCommissionsForThisServiceOrPoint:
            return .noServiceCommissionsForThisServiceOrPoint(description: description)
            
        case .serviceLogicIsMissing:
            return .serviceLogicIsMissing(description: description)
            
        case .methodUpdateNotAllowedForThisService:
            return .methodUpdateNotAllowedForThisService(description: description)
            
        case .methodPayNotAllowedForThisService:
            return .methodPayNotAllowedForThisService(description: description)
            
        case .paymentFailed:
            return .paymentFailed(description: description)
            
        case .currencyNotSupportedByService:
            return .currencyNotSupportedByService(description: description)
            
        case .paymentCreationIsFailed:
            return .paymentCreationIsFailed(description: description)
            
        case .incomingTransactionIdIsRequired:
            return .incomingTransactionIdIsRequired(description: description)
            
        case .incomingTransactionIsNotFound:
            return .incomingTransactionIsNotFound(description: description)
            
        case .fieldExternalCommissionAmountRequired:
            return .fieldExternalCommissionAmountRequired(description: description)
            
        case .fieldExternalCommissionAmountDoesNotExpected:
            return .fieldExternalCommissionAmountDoesNotExpected(description: description)
            
        case .cardHasLimitOnCardCreditTransaction:
            return .cardHasLimitOnCardCreditTransaction(description: description)
            
        case .amountOverholdAmount:
            return .amountOverholdAmount(description: description)
            
        case .invalidSignature:
            return .invalidSignature(description: description)
            
        case .cardHasLimitOnMotoTransaction:
            return .cardHasLimitOnMotoTransaction(description: description)
            
        case .rejectedByAntifraud:
            return .rejectedByAntifraud(description: description)
            
        case .unableToRegisterPayment:
            return .unableToRegisterPayment(description: description)
            
        case .unableToConfirmRegisteredPayment:
            return .unableToConfirmRegisteredPayment(description: description)
            
        case .transactionWithSuchIdAlreadySubmitted:
            return .transactionWithSuchIdAlreadySubmitted(description: description)
            
        }
    }
    
}
