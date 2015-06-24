//
//  WBUser.swift
//  SwiftWeibo
//
//  Created by cxjwin on 10/26/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import Foundation

struct WBUser {
    let userID: String
    let profileImageUrl: String
    let screenName: String
    
    init?(info: [String : AnyObject]) {
        guard let idstr = info["idstr"] as? String where !idstr.isEmpty else { return nil }
        userID = idstr
        profileImageUrl = info["profile_image_url"] as? String ?? ""
        screenName  = info["screen_name"] as? String ?? ""
    }
}
