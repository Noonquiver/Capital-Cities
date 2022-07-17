//
//  WebViewController.swift
//  Capital Cities
//
//  Created by Camilo Hernández Guerrero on 16/07/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var selectedCountry: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard var country = selectedCountry else { return }
        
        if country.elementsEqual("Washington DC") {
            country = "Washington,_D.C."
        }
        
        guard let URL = URL(string: "https://en.wikipedia.org/wiki/\(country)") else { return }
        webView.load(URLRequest(url: URL))
    }
}
