//
//  MediaCell.swift
//  InstaTest
//
//  Created by DmitrJuga on 27.04.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {

    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelLikesCount: UILabel!
    @IBOutlet weak var labelTagsCount: UILabel!
    @IBOutlet weak var labelCommentsCount: UILabel!
    @IBOutlet weak var labelUsersCount: UILabel!
    @IBOutlet weak var imageBox: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    func loadCell(item: NSDictionary) {
        imageBox.image = nil
        indicator.startAnimating()
        imageBox.layer.borderWidth = 1
        imageBox.layer.borderColor = UIColor.lightGrayColor().CGColor
        if let strURL = item.valueForKeyPath("images.thumbnail.url") as? String {
            ImageCacheManager.loadImage(strURL) {(image, _ ) in
                if let image = image {
                    self.imageBox.image = image
                    self.indicator.stopAnimating()
                }
            }
        }
        labelLocation.text = ""
        if let location = item.valueForKeyPath("location.name") as? String {
            labelLocation.text = location
        }
        labelDate.text = ""
        if let createdTime = item.valueForKey("created_time") as? NSString {
            let date = NSDate(timeIntervalSince1970: createdTime.doubleValue)
            let formater = NSDateFormatter()
            formater.dateFormat = "dd.MM.YYYY HH:mm"
            labelDate.text = formater.stringFromDate(date)
        }
        labelLikesCount.text = "0"
        if let likes = item.valueForKeyPath("likes.count")?.stringValue  {
            labelLikesCount.text = likes
        }
        labelTagsCount.text = "0"
        if let tags = item.valueForKey("tags") as? [String] {
            labelTagsCount.text = String(tags.count)
        }
        labelCommentsCount.text = "0"
        if let comments = item.valueForKeyPath("comments.count")?.stringValue  {
            labelCommentsCount.text = comments
        }
        labelUsersCount.text = "0"
        if let users = item.valueForKey("users_in_photo") as? [NSDictionary] {
            labelUsersCount.text = String(users.count)
        }
    }
    
}
