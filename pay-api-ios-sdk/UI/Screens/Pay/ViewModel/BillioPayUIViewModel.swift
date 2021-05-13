//
//  BillioPayUIViewModel.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import Foundation

protocol BillioTableViewCell { }

class BillioPayUIViewModel: NSObject {
    
    //MARK: - Defaults
    
    enum Defaults {
        static let paymentMask: String = "Оплата счета #"
    }
    
    enum Section: Int, CaseIterable {
        case paymentGeneral = 0
        case cardInfo
        case actionButtons
        case paymentCompanies
        
        var cellsCount: Int {
            switch self {
            case .paymentGeneral:
                return PaymentGeneralCells.allCases.count
            case .cardInfo:
                return CardInfoCells.allCases.count
            case .actionButtons:
                return ActionButtons.allCases.count
            case .paymentCompanies:
                return PaymentCompanies.allCases.count
            }
        }
    }
    
    enum PaymentGeneralCells: Int, CaseIterable, BillioTableViewCell {
        case title = 0
        case sum
    }
    
    enum CardInfoCells: Int, CaseIterable, BillioTableViewCell {
        case cardName = 0
        case cardNumber
        case cardDates
        case cardCVV
    }
    
    enum ActionButtons: Int, CaseIterable, BillioTableViewCell {
        case pay = 0
        case save
        
        var name: String {
            switch self {
            case .pay:
                return "Оплатить"
            case .save:
                return "Сохранить карту"
            }
        }
    }
    
    enum PaymentCompanies: Int, CaseIterable, BillioTableViewCell {
        case logos = 0
    }
    
    //MARK: - Properties
    
    private var amount: Int?
    
    private var transactionID: String?
    
    private var name: String?
    
    private var cardNumber: String?
    
    private var expirationMonth: String?
    
    private var expirationYear: String?
    
    private var cvv: String?
    
    //MARK: - Lifecycle
    
    func set(name: String?) {
        self.name = name
    }
    
    func set(number: String?) {
        self.cardNumber = number
    }
    
    func set(transactionID: String) {
        self.transactionID = transactionID
    }
    
    func set(amount: Int) {
        self.amount = amount
    }
    
    func set(expirationMonth: String?) {
        self.expirationMonth = expirationMonth
    }
    
    func set(expirationYear: String?) {
        self.expirationYear = expirationYear
    }
    
    func set(cvv: String?) {
        self.cvv = cvv
    }
    
    func getSectionsCount() -> Int {
        return Section.allCases.count
    }
    
    func getSectionType(from section: Int) -> Section? {
        return Section(rawValue: section)
    }
    
    func getCellType(from row: Int, section: Section) -> BillioTableViewCell? {
        switch section {
        case .paymentGeneral:
            return PaymentGeneralCells(rawValue: row)
        case .cardInfo:
            return CardInfoCells(rawValue: row)
        case .actionButtons:
            return ActionButtons(rawValue: row)
        default:
            return PaymentCompanies(rawValue: row)
        }
    }
    
    func getCardFields() -> HostToHostFields? {
        guard let number = self.cardNumber,
           let year = self.expirationYear,
           let month = self.expirationMonth,
           let cvv = self.cvv else {
            return nil
        }
        return HostToHostFields(cardNumber: number, expireYear: year, expireMonth: month, cvv: cvv)
    }
    
    func getCardNumber() -> String? {
        return self.cardNumber
    }
    
    func getTransactionAmount() -> String? {
        guard let amount = self.amount else {
            return nil
        }
        let prepared = Double(amount) / 100.0
        return prepared.description
    }
    
    func getTransactionCoinsAmount() -> Int? {
        return self.amount
    }
    
    func getTransactionNumberTitle() -> String? {
        guard let number = self.transactionID else {
            return nil
        }
        return Defaults.paymentMask + number
    }
    
    func getTransactionNumber() -> String? {
        return self.transactionID
    }
    
    func getCardExpirationMonth() -> String? {
        return self.expirationMonth
    }
    
    func getCardExpirationYear() -> String? {
        return self.expirationYear
    }
    
}
