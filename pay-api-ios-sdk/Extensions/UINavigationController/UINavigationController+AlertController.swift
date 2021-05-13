//
//  UINavigationController+AlertController.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import UIKit

extension UINavigationController {
    
    func presentEnterForm(title: String, completion: @escaping(String?) -> Void) {
        let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        controller.addTextField()
        let submitAction = UIAlertAction(title: "Enter", style: .default) { [weak controller] _ in
            let text = controller?.textFields?.first?.text
            completion(text)
        }
        controller.addAction(submitAction)
        self.present(controller, animated: true, completion: nil)
    }
    
}
