//
//  ArticleViewController.swift
//  Media
//
//  Created by junya.kawai on 2020/01/30.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKNavigationDelegate{
    let webView = WKWebView()
    var link: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        self.view = self.webView
        
        let url = URL(string: link)!

        self.webView.load(URLRequest(url: url))
    }
}
