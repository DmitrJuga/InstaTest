//
//  ImageManager.swift
//  InstaTest
//
//  Created by DmitrJuga on 27.04.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

import Foundation
import UIKit

struct ImageCacheManager {
    
    private static var cache = NSCache()
    
    static func loadImage(strUrl: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        if (!strUrl.isEmpty) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                // Try get from cache
                if let image = self.cache.objectForKey(strUrl) as? UIImage {
                    dispatch_async(dispatch_get_main_queue()) {
                        completionHandler(image: image, url: strUrl)
                    }
                    return
                }
                // Or Load
                if let url = NSURL(string: strUrl),
                    let data = NSData(contentsOfURL: url),
                    let image = UIImage(data: data) {
                        // Success
                        self.cache.setObject(image, forKey: strUrl)
                        dispatch_async(dispatch_get_main_queue()) {
                            completionHandler(image: image, url: strUrl)
                        }
                        return
                } else {
                    // Error
                    completionHandler(image: nil, url: strUrl)
                    return
                }
            }
        }
    }
    
}