//
//  BillioPayViewController+UITableView.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import UIKit

//MARK: - UITableViewDelegate
extension BillioPayViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension BillioPayViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        self.uiViewModel.getSectionsCount()
    }
    
    //MARK: - Cells
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.uiViewModel.getSectionType(from: section) else {
            return 0
        }
        return section.cellsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = self.uiViewModel.getSectionType(from: indexPath.section) else {
            return UITableViewCell()
        }
        guard let cellType = self.uiViewModel.getCellType(from: indexPath.row, section: section) else {
            return UITableViewCell()
        }
        switch cellType {
        case BillioPayUIViewModel.PaymentGeneralCells.logo:
            let cell = tableView.getReusableCell(type: BillioPayLogoTableViewCell.self, for: indexPath)!
            cell.logo = PaymentSDK.shared.logo
            return cell
        case BillioPayUIViewModel.PaymentGeneralCells.title:
            let title = self.uiViewModel.getTransactionNumberTitle()
            let cell = tableView.getReusableCell(type: BillioPayGeneralTitleTableViewCell.self, for: indexPath)!
            cell.title = title
            return cell
        case BillioPayUIViewModel.PaymentGeneralCells.sum:
            let sum = self.uiViewModel.getTransactionAmount()
            let cell = tableView.getReusableCell(type: BillioPayGeneralSumTableViewCell.self, for: indexPath)!
            cell.sum = sum
            return cell
        case BillioPayUIViewModel.CardInfoCells.cardName:
            let cell = tableView.getReusableCell(type: BillioPayCardNameTableViewCell.self, for: indexPath)!
            cell.delegate = self
            return cell
        case BillioPayUIViewModel.CardInfoCells.cardNumber:
            let number = self.uiViewModel.getCardNumber()
            let cell = tableView.getReusableCell(type: BillioPayCardNumberTableViewCell.self, for: indexPath)!
            cell.cardNumber = number
            cell.delegate = self
            return cell
        case BillioPayUIViewModel.CardInfoCells.cardDates:
            let month = self.uiViewModel.getCardExpirationMonth()
            let year = self.uiViewModel.getCardExpirationYear()
            let cell = tableView.getReusableCell(type: BillioPayCardDatesTableViewCell.self, for: indexPath)!
            cell.delegate = self
            cell.month = month
            cell.year = year
            return cell
        case BillioPayUIViewModel.CardInfoCells.cardCVV:
            let cell = tableView.getReusableCell(type: BillioPayCardCVVTableViewCell.self, for: indexPath)!
            cell.delegate = self
            return cell
        case BillioPayUIViewModel.ActionButtons.pay:
            let cell = tableView.getReusableCell(type: BillioPayActionButtonTableViewCell.self, for: indexPath)!
            cell.title = BillioPayUIViewModel.ActionButtons.pay.name
            cell.delegate = self
            cell.isFilled = true
            cell.indexPath = indexPath
            return cell
        case BillioPayUIViewModel.ActionButtons.save:
            let cell = tableView.getReusableCell(type: BillioPayActionButtonTableViewCell.self, for: indexPath)!
            cell.title = BillioPayUIViewModel.ActionButtons.save.name
            cell.delegate = self
            cell.isFilled = false
            cell.indexPath = indexPath
            return cell
        case BillioPayUIViewModel.PaymentCompanies.logos:
            let cell = tableView.getReusableCell(type: BillioPayCompaniesTableViewCell.self, for: indexPath)!
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    //MARK: - Header
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    //MARK: - Footer
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
}
