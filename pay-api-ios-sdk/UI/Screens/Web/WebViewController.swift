//
//  WebViewController.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 05.05.2021.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: class {
        
    func didReceive(paRes: String?, for transactionID: Int?, md: Int?)
    
    func didCompleteRedirect(for transactionID: Int?, externalTransactionID: String?)
    
}

class WebViewController: BillioBaseViewController {
    
    //MARK: - Defaults
    
    private enum Defaults {
        static let paResDescription: String = "PaRes="
        static let mdDescription: String = "MD="
    }
    
    //MARK: - Properties
    
    @IBOutlet weak private var vWeb: WKWebView!
    
    weak var delegate: WebViewControllerDelegate?
    
    var url: URL?
    
    var htmlString: String?
    
    var transactionID: Int?
    
    var externalTransactionID: String?
    
    var md: Int?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureWebView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.clearData()
        self.clearWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareNavigationBar()
        self.updateWebViewContents()
    }
    
    private func prepareNavigationBar() {
        self.setNavigationBar(isHidden: false)
    }
    
    private func configureWebView() {
        self.vWeb.allowsBackForwardNavigationGestures = true
        self.vWeb.allowsLinkPreview = true
        self.vWeb.uiDelegate = self
        self.vWeb.navigationDelegate = self
    }
    
    private func clearData() {
        self.htmlString = nil
        self.url = nil
        self.transactionID = nil
        self.md = nil
        self.externalTransactionID = nil
    }
    
    private func clearWebView() {
        guard let clearURL = URL(string: "about:blank") else {
            return
        }
        let request = URLRequest(url: clearURL)
        self.vWeb.load(request)
    }
    
    private func updateWebViewContents() {
        if self.url != nil {
            self.updateWebViewLink()
            return
        }
        self.updateWebViewWithHtmlString()
    }
    
    private func updateWebViewWithHtmlString() {
        guard let html = self.htmlString else {
            return
        }
        self.vWeb.loadHTMLString(html, baseURL: nil)
    }
    
    private func updateWebViewLink() {
        guard let link = self.url else {
            return
        }
        let request = URLRequest(url: link)
        self.vWeb.load(request)
    }
    
    private func retriveData(data: Data) -> Bool {
        let responseString = String(decoding: data, as: UTF8.self)
        let responseComponents = responseString.components(separatedBy: "&")
        var paRes = String()
        var md = self.md
        for component in responseComponents {
            if component.contains(Defaults.paResDescription) {
                paRes = component.replacingOccurrences(of: Defaults.paResDescription, with: "")
            }
            if component.contains(Defaults.mdDescription) {
                md = Int(component.replacingOccurrences(of: Defaults.mdDescription, with: ""))
            }
        }
        if paRes.isEmpty {
            return false
        }
        self.delegate?.didReceive(paRes: paRes.isEmpty ? nil : paRes, for: self.transactionID, md: md)
        return true
    }
    
    private func checkNavigationLink(link: URL?) {
        guard let link = link else {
            return
        }
        let returnUrlDescription = PaymentSDK.shared.returnUrl?.description ?? ""
        let callbackUrlDescription = PaymentSDK.shared.callBackUrl?.description ?? ""
        if link.description.contains(returnUrlDescription) || link.description.contains(callbackUrlDescription) {
            self.delegate?.didCompleteRedirect(for: self.transactionID, externalTransactionID: self.externalTransactionID)
        }
    }
    
}

//MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let link = navigationAction.request.url
        if let data = navigationAction.request.httpBody {
            if !self.retriveData(data: data) {
                self.checkNavigationLink(link: link)
            }
            return decisionHandler(.allow)
        }
        self.checkNavigationLink(link: link)
        decisionHandler(.allow)
    }
    
}

//MARK: - WKUIDelegate
extension WebViewController: WKUIDelegate {
    
}

//MARK: - StoryboardInstantiable
extension WebViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        return Storyboard.web
    }
    
}
