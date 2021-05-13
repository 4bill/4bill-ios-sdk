//
//  APIConstants.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Foundation

enum APIConstants {
    
    static let reachabilityManagerHost = "google.com"
    
    static let apiURL = "https://api.4bill.io/"
    static let defaultUserAgent = "app/ios"
}

enum APIContentType: String {
    case applicationJSON = "application/json"
    case applicationPDF = "application/pdf"
    case applicationFormURLEncoded = "application/x-www-form-urlencoded"
}

enum APISecurityScheme: String {
    case bearer = "Bearer"
    case basic  = "Basic"
}

enum APIHeaders: String {
    case userAgent      = "User-Agent"
    case contentType    = "Content-Type"
    case authorization  = "Authorization"
}

enum APIParameterName: String {
    case code
    case title
    case message
    case success
    case error
    
    case refreshToken
    case accessToken
    
    case point
    case key
    case hash
    case auth
    
    case locale
    case externalTransactionID = "external_transaction_id"
    case externalOrderID = "external_order_id"
    case externalCustomerID = "external_customer_id"
    case customerIPAdress = "customer_ip_address"
    case amount
    case amountCurrency = "amount_currency"
    case serviceID = "service_id"
    case accountID = "account_id"
    case walletID = "wallet_id"
    case description
    case fields
    case callbackURL = "callback_url"
    case successURL = "success_url"
    case failURL = "fail_url"
    case cancelURL = "cancel_url"
    case returnURL = "return_url"
    case extra
    case id
    case isTest = "is_test"
    case pointID = "point_id"
    case result
    case status
    case statusDescription = "status_description"
    case failureReasonCode = "failure_reason_code"
    case failureReasonMessage = "failure_reason_message"
    
    case paymentAuthResponse = "PaRes"
    case md = "MD"
    case lookupCode = "lookup_code"
    case otpCode = "otp_code"
    
    case data
    
    case accountWalletAmount = "account_wallet_amount"
    case accountWalletCurrency = "account_wallet_currency"
    case created = "created_at"
    case name
    case currency
    case balance
    case balanceMin = "balance_min"
    case reserve
    case updatedAt = "updated_at"
    case wallets
    case slug
    case type
    case required
    case hint
    case mask
    case placeholder
    case regex
    case validationType = "validation_type"
    case parentID = "parent_id"
    case groups
    case services
    case groupID = "group_id"
    case minAmount = "min_amount"
    case maxAmount = "max_amount"
    case percent
    case fix
    case min
    case max
    case customer
    case commission
    case cardNumber = "card_number"
    case cardToken = "card_token"
    case isInWhitelist = "in_whitelist"
    case isInBlacklist = "in_blacklist"
    
    case browserData = "browser_data"
    case acceptHeader = "accept_header"
    case userAgent = "user_agent"
    case colorDepth = "color_depth"
    case language
    
    case payerAuth = "payer_auth"
    case expireYear = "expire_year"
    case expireMonth = "expire_month"
    case cvv
    case acsUrl = "acs_url"
    case pareq
    case paReq = "PaReq"
    case termUrl = "TermUrl"
    case redirectUrl = "redirect_url"
    case authorization
    case payUrl = "pay_url"
    case issueCardToken = "issue_card_token"
    case recipientCardNumber = "recipient_card_number"
}

enum APIPath {
    
    static let transactionCreate = "/transaction/create"
    static let payTransaction = "/transaction/pay"
    static let transactionUpdate = "/transaction/update"
    static let transactionCancel = "/transaction/cancel"
    static let transactionFind = "/transaction/find"
    
    static let accountInfo = "/account/info"
    
    static let serviceList = "/service/list"
    static let service = "/service/"
    
    static let addCardToWhitelist = "/cards/whitelist/add"
    static let cardsCheck = "/cards/check"
}

public enum RequestType {
    
    // CARD
    
    case addCardToWhitelist
    case checkCard
    
    // SERVICE
    
    case getServiceList
    case getService
    
    // ACCOUNT
    
    case getAccountInfo
    
    // TRANSACTION
    
    case createTransaction
    case payTransaction
    case updateTransaction
    case cancelTransaction
    case findTransaction
    
    // ALL
    case allRequests
}
