//
//  BillioPayActionButtonTableViewCell.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 13.04.2021.
//

import UIKit

protocol BillioPayActionButtonTableViewCellDelegate: class {
    
    func didTouchButton(with indexPath: IndexPath)
    
}

class BillioPayActionButtonTableViewCell: UITableViewCell {
    
    //MARK: - Defaults
    
    private enum Defaults {
        static let shadowFilter = "multiplyBlendMode"
    }
    
    //MARK: - Properties
    
    @IBOutlet weak private var btnAction: BorderedButton!
    
    @IBOutlet weak private var vShadow: UIView!
    
    weak var delegate: BillioPayActionButtonTableViewCellDelegate?
    
    lazy var topShadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.appGray.withAlphaComponent(0.06).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.compositingFilter = Defaults.shadowFilter
        return layer
    }()
    
    lazy var bottomShadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.appGray.withAlphaComponent(0.08).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.compositingFilter = Defaults.shadowFilter
        return layer
    }()
    
    var indexPath: IndexPath?
    
    var title: String? {
        didSet {
            self.btnAction.setTitle(self.title, for: .normal)
        }
    }
    
    var isFilled: Bool = false {
        didSet {
            self.updateButtonUI()
            
        }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateButtonUI() {
        if self.isFilled {
            self.btnAction.backgroundColor = UIColor.sdkGreen
            self.btnAction.tintColor = .white
            self.applyShadows()
            return
        }
        self.btnAction.backgroundColor = .clear
        self.btnAction.tintColor = .black
    }
    
    private func applyShadows() {
        DispatchQueue.main.async {
            let topShadow = UIBezierPath(roundedRect: self.vShadow.bounds, cornerRadius: 0)
            self.topShadowLayer.shadowPath = topShadow.cgPath
            self.topShadowLayer.bounds = self.vShadow.frame
            self.topShadowLayer.position = self.vShadow.center
            self.vShadow.layer.addSublayer(self.topShadowLayer)
            
            let bottomShadow = UIBezierPath(roundedRect: self.vShadow.bounds, cornerRadius: 0)
            self.bottomShadowLayer.shadowPath = bottomShadow.cgPath
            self.bottomShadowLayer.bounds = self.vShadow.frame
            self.bottomShadowLayer.position = self.vShadow.center
            self.vShadow.layer.addSublayer(self.bottomShadowLayer)
        }
    }
    
    //MARK: - Handlers
    
    @IBAction private func didTouchActionButton(_ sender: Any) {
        guard let path = self.indexPath else {
            return
        }
        self.delegate?.didTouchButton(with: path)
    }
}

//MARK: - AutoIndentifierCell
extension BillioPayActionButtonTableViewCell: AutoIndentifierCell {}
