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

    internal override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.hackingwithswift.com")!
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
            self.openPage(url: "apple.com")
        }))

        alertController.addAction(UIAlertAction(title: "hackingwithswift", style: .default, handler: {_ in
            self.openPage(url: "hackingwithswift.com")
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
    
    internal override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath != #keyPath(WKWebView.estimatedProgress)) { return }
        progressView.progress = Float(webView.estimatedProgress)
    }
}

