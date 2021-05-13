//
//  UICollectionView+CellRegistration.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 10.04.2021.
//

import UIKit

extension UICollectionView {
    
    func registerCells<T: AutoIndentifierCell>(cells: [T.Type]) {
        for cell in cells {
            self.register(UINib(nibName: cell.nibName, bundle: nil), forCellWithReuseIdentifier: cell.identifier)
        }
    }
    
    func register(cells: [AutoIndentifierCell.Type]) {
        for cell in cells {
            self.register(UINib(nibName: cell.nibName, bundle: nil), forCellWithReuseIdentifier: cell.identifier)
        }
    }
    
    func getReusableCell<T: AutoIndentifierCell>(type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
    
}
