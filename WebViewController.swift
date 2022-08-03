//
//  WebViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController { // ReusableProtocol

    // static var reuseIdentifier: String = "WebViewController" // 0801
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.com"
    // App Transport Security Settings
    // http X
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        openWebPage(url: destinationURL)
        
        searchBar.delegate = self
    }
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

}

extension WebViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
