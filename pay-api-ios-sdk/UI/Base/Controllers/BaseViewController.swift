//
//  BaseViewController.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 11.04.2021.
//

import UIKit

public class BillioBaseViewController: UIViewController {
    
    //MARK: - Defaults
    
    private enum KeyboardPosition {
        static let padding: CGFloat = 16.0
    }
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    //MARK: - Observers
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func killObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func popController(animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func setNavigationBar(isHidden: Bool) {
        self.navigationController?.isNavigationBarHidden = isHidden
    }
    
    // MARK: - Notification
    
    @objc
    func keyboardWillShow(notification: Notification) { }
    
    @objc
    func keyboardWillHide(notification: Notification) { }
    
    @objc
    func hideKeyboard(notification: Notification) {
        self.view.endEditing(true)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Helpers

extension BillioBaseViewController {
 
    internal func setViewportOffset(of element: UIView, inputViewFrame frame: CGRect) {
        var offset = (self.view.frame.height - element.frame.maxY) - (frame.height + KeyboardPosition.padding)
        if offset > 0 {
            return
        }
        
        if let navBar = self.navigationController?.navigationBar {
            offset += navBar.isHidden ? 0 : navBar.height + self.statusBarHeight
        }
        UIView.animate(withDuration: AnimationDuration.default) {
            self.view.frame.origin.y = offset
        }
    }
    
    internal func resetViewportOffset(animated: Bool = true) {
        var offset: CGFloat = 0
        if let navBar = self.navigationController?.navigationBar {
            offset = navBar.isHidden ? 0 : navBar.height + self.statusBarHeight
        }
        if !animated {
            self.view.frame.origin.y = offset
            self.view.endEditing(true)
            return
        }
        UIView.animate(withDuration: AnimationDuration.default) {
            self.view.frame.origin.y = offset
        }
    }
    
}
