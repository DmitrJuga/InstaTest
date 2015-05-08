//
//  LoginViewController.swift
//  InstaTest
//
//  Created by DmitrJuga on 18.04.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func loginViewController(vc: LoginViewController, authorizedWithAccessToken accessToken: String)
}

class LoginViewController: UIViewController {

    @IBOutlet weak var authWebView: UIWebView!
    
    var delegate: LoginDelegate?
    
    private var strAuthURL = ""

    override func viewDidLoad() {
        loadAuth()
    }

    func loadAuth() {
        strAuthURL = InstaAPI.authURL
        strAuthURL.replaceRange(strAuthURL.rangeOfString("{@1}")!, with: InstaAPI.ClientId)
        strAuthURL.replaceRange(strAuthURL.rangeOfString("{@2}")!, with: InstaAPI.RedirectURI)
        if let authURL = NSURL(string: strAuthURL) {
            authWebView.loadRequest(NSURLRequest(URL: authURL))
        }
    }
    
}

// MARK: - UIWebViewDelegate
extension LoginViewController: UIWebViewDelegate {

    // фильтр URL в webView
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let URL = request.URL,
        let strURL = URL.absoluteString {
            switch strURL {
            case let strURL where strURL.hasPrefix(strAuthURL) ||
                                  strURL.hasPrefix(InstaAPI.urlLogin) ||
                                  strURL.hasPrefix(InstaAPI.urlLogout):
                return true
            case let strURL where strURL.hasPrefix(InstaAPI.RedirectURI):
                let accessToken = strURL.stringByReplacingOccurrencesOfString(InstaAPI.RedirectURIWithToken, withString: "")
                 if accessToken != strURL {
                    delegate?.loginViewController(self, authorizedWithAccessToken: accessToken)
                    dismissViewControllerAnimated(false, completion: nil)
                } else {
                    loadAuth()
                }
                return false
            default: // TODO: открыть URL в браузере
                break
            }
        }
        return false
    }
    
    // обработка ошибки в webView
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        if error.code != 102 {
            println(error.description)
            webView.loadHTMLString(error.localizedDescription, baseURL:NSURL(string: strAuthURL))
        }
    }


}


