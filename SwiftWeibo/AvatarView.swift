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
			var avatarUrl = NSURL(string: _URLString);
			
			let manager = SDWebImageManager.sharedManager()
			var cacheImage: UIImage? = manager.imageCache.imageFromDiskCacheForKey(avatarUrl!.absoluteString)
			
			if let _image = cacheImage {
				self.image = _image
			} else {
				self.image = nil
				
                var completed = {
					[weak self] (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, URL: NSURL!) in
                        self!.image = image
				}
				
                manager.downloadImageWithURL(avatarUrl!, options: .CacheMemoryOnly, progress: nil, completed: completed)
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
