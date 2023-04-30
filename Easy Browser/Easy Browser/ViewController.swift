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
}

