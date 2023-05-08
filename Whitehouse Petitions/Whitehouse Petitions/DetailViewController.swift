//
//  DetailViewController.swift
//  Whitehouse Petitions
//
//  Created by Ali ÇAĞLAR on 8.05.2023.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var petition: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let petition = petition else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(petition.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)

    }

}
