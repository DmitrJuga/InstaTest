//
//  ViewController.swift
//  InstaTest
//
//  Created by DmitrJuga on 15.04.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIView!

    var arrayMedia = [NSDictionary]()
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        indicator.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
         if InstaAPI.authAccessToken.isEmpty {
            doLogin()
         } else if arrayMedia.isEmpty {
            loadData()
        }
    }

    func loadData() {
        arrayMedia.removeAll(keepCapacity: true)
        reloadUI()
        
        indicator.hidden = false
        loadPage(InstaAPI.urlSelfMedia + "?access_token=" + InstaAPI.authAccessToken)
    }

    func loadPage(strURL: String) {
        if let url = NSURL(string: strURL) {
            let task = session.dataTaskWithURL(url) {(data, _, error) in
                if let error = error {
                     println(error)
                } else {
                    let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                    self.arrayMedia.extend(json.valueForKey("data") as! [NSDictionary])
                    if let nextURL = json.valueForKeyPath("pagination.next_url") as? String {
                        //println(nextURL)
                        self.loadPage(nextURL)
                    } else {
                        self.arrayMedia.sort{
                            let a = $0.0.valueForKeyPath("likes.count")?.integerValue
                            let b = $0.1.valueForKeyPath("likes.count")?.integerValue
                            return a > b
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.indicator.hidden = true
                            self.reloadUI()
                        }
                    }
                }
            }
            task.resume()
        }
    }

    func reloadUI() {
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func doLogin() {
        if let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("Login") as? LoginViewController {
            loginVC.delegate = self
            self.presentViewController(loginVC, animated: true, completion: nil)
        }
    }
    
    func logout() {
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies as! [NSHTTPCookie] {
            if cookie.domain == "instagram.com" {
                storage.deleteCookie(cookie)
            }
        }
        InstaAPI.authAccessToken = ""
    }
    
    @IBAction func btnLogoutPressed(sender: AnyObject) {
        self.indicator.hidden = false
        logout()
        arrayMedia.removeAll(keepCapacity: true)
        reloadUI()
        doLogin()
    }
    
    @IBAction func btnRefreshPressed(sender: AnyObject) {
        arrayMedia.removeAll(keepCapacity: true)
        reloadUI()
        loadData()
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMedia.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MediaCell", forIndexPath: indexPath) as! MediaCell
        cell.loadCell(arrayMedia[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension ViewController: LoginDelegate {
    
    func loginViewController(vc: LoginViewController, authorizedWithAccessToken accessToken: String) {
        InstaAPI.authAccessToken = accessToken
    }
    
}

