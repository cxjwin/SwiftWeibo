//
//  WBStatus.swift
//  SwiftWeibo
//
//  Created by cxjwin on 10/26/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import Foundation
import UIKit

class WBStatus: NSObject {
    var statusId: String = ""
    var text: String = ""
    var picURLs: NSArray! = nil

    var user: WBUser! = nil
    var retweetedStatus: WBStatus? = nil;
    
    func fillInDetailsWithJSONObject(info: NSDictionary) {
        statusId = info["idstr"] as! String
        text = info["text"] as! String
        picURLs = info["pic_urls"] as! NSArray

        user = {
            let userInfo = info["user"] as! NSDictionary

            let _user = WBUser()
            _user.userId = userInfo["idstr"] as! String
            _user.screenName = userInfo["screen_name"] as! String
            _user.profileImageUrl = userInfo["profile_image_url"] as! String
            
            return _user;
        }()
        
        retweetedStatus = {
            let _info: NSDictionary? = info.objectForKey("retweeted_status") as? NSDictionary
            if _info != nil {
                let _status = WBStatus()
                _status.fillInDetailsWithJSONObject(_info!)
                return _status
            } else {
                return nil
            }
        }()
    }
}
