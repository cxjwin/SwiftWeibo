//
//  StatusImageView.swift
//  SwiftWeibo
//
//  Created by cxjwin on 10/27/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import UIKit

class StatusImageView: UIView {
    
    var image: UIImage?
    
    var picURLs: Array<[String : String]> = [] {
        willSet {
            self.image = nil;
            self.setNeedsDisplay()
        }
        
		didSet {
            if picURLs.isEmpty {
                return
            }
            
            if let URLString = picURLs[0]["thumbnail_pic"] {
                let avatarUrl = NSURL(string: URLString);
                
                let manager = SDWebImageManager.sharedManager()
                let cacheImage: UIImage? = manager.imageCache.imageFromDiskCacheForKey(avatarUrl!.absoluteString)
                
                if cacheImage != nil {
                    self.image = cacheImage!
                } else {
                    self.image = nil
                    if avatarUrl != nil {
                        manager.downloadImageWithURL(avatarUrl, options: .CacheMemoryOnly, progress: nil,
                            completed: { [weak self] (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, URL: NSURL!) in
                                self!.image = image
                                self!.setNeedsDisplay()
                            })
                    }
                }
            }
		}
	}
	
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        if self.image != nil {
            self.image!.drawInRect(rect)
        }
    }
	
}
