//
//  AvatarView.swift
//  SinaWeibo
//
//  Created by cxjwin on 6/17/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import UIKit

class AvatarView: UIImageView {
    var URLString: String? {
	didSet {
		if let _URLString = URLString {
			let avatarUrl = NSURL(string: _URLString);
			
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
                    })
                }
            }
		}
	}
	}

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.yellowColor()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
