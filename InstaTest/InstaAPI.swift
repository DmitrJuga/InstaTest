//
//  Insta.swift
//  InstaTest
//
//  Created by DmitrJuga on 19.04.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

import Foundation

 struct InstaAPI {

    static let ClientId = "58fa042c8bcc4051890aaa1d1dd00c5d"
    static let RedirectURI = "http://itisyourlikes.ru"
    static let RedirectURIWithToken = "http://itisyourlikes.ru/#access_token="
    
    static let authURL = "https://instagram.com/oauth/authorize/?client_id={@1}&redirect_uri={@2}&response_type=token"
    static let urlLogin = "https://instagram.com/accounts/login/?"
    static let urlLogout = "https://instagram.com/accounts/logout"
    
    static let myUrl = "https://api.instagram.com/v1/tags/{@1}/media/recent?access_token={@2}"
    static let urlSelfMedia = "https://api.instagram.com/v1/users/self/media/recent"
    
    static var authAccessToken: String {
        get {
            let plist = NSUserDefaults.standardUserDefaults()
            plist.synchronize()
            if let accessToken = plist.valueForKey("AccessToken") as? String {
                return accessToken
            } else {
                return ""
            }
        }
        set {
            let plist = NSUserDefaults.standardUserDefaults()
            plist.setValue(newValue, forKey:"AccessToken")
            plist.synchronize()
        }
    }
}