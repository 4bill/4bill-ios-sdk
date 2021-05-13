//
//  BillioPayCardNameTableViewCell.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import UIKit

class BillioPayCardNameTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak private var vInput: BorderedTextFieldView!
    
    weak var delegate: BorderedTextFieldViewDelegate? {
        didSet {
            self.vInput.delegate = self.delegate
        }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateUI()
    }
    
    private func updateUI() {
        self.vInput.inputType = .name
        self.vInput.buttonImage = nil
        self.vInput.maxCharactersCount = nil
        self.vInput.inputMask = nil
        self.vInput.set(contentType: .name)
    }
}

//MARK: - AutoIndentifierCell
extension BillioPayCardNameTableViewCell: AutoIndentifierCell {}
