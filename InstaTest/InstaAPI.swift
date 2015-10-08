//
//  Insta.swift
//  InstaTest
//
//  Created by DmitrJuga on 19.04.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

import Foundation

 struct InstaAPI {

    static let clientID = "653fea9f3a084befa44fe62b32ac9902"
    static let redirectURI = "http://bestphoto.com"
    
    static let authURL = "https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token"
    static let urlLogin = "https://instagram.com/accounts/login/?"
    static let urlLogout = "https://instagram.com/accounts/logout"
    
    static let urlGetSelfMedia = "https://api.instagram.com/v1/users/self/media/recent"
    
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