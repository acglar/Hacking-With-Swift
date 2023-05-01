//
//  ViewController.swift
//  Easy Browser
//
//  Created by Ali ÇAĞLAR on 30.04.2023.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    let websites: [String] = ["apple.com", "hackingwithswift.com"]

    internal override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.\(websites[1])")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(onRightBarButtonTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresher = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
        
        toolbarItems = [progressButton, spacer, refresher]
        navigationController?.isToolbarHidden = false
    }


    @objc private func onRightBarButtonTapped() {
        let alertController = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "apple", style: .default, handler: {_ in
            self.openPage(url: self.websites[0])
        }))

        alertController.addAction(UIAlertAction(title: "hackingwithswift", style: .default, handler: {_ in
            self.openPage(url: self.websites[1])
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        // This requires for the ipads, does anchoring for the action sheet
        alertController.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }

    private func openPage(url: String) {
        guard let url = URL(string: "https://\(url)") else { return }
        webView.load(URLRequest(url: url))
    }

    internal func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    internal func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        guard let host = url?.host else {
            decisionHandler(.cancel)
            return
        }
        
        let result = websites.filter { host.contains($0) }
        decisionHandler(result.isEmpty ? .cancel : .allow)
        
        if result.isEmpty {
            let alertController = UIAlertController(title: "Blocked", message: "Website you're trying reach is not allowed.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alertController, animated: true)
        }
    }
    
    internal override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath != #keyPath(WKWebView.estimatedProgress)) { return }
        progressView.progress = Float(webView.estimatedProgress)
    }
}

