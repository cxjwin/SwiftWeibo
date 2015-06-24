//
//  WBStatus.swift
//  SwiftWeibo
//
//  Created by cxjwin on 10/26/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import Foundation
import UIKit

class WBStatus {
    let statusID: String!
    let text: String!

    let picURLs: Array<[String : String]>!
    let user: WBUser!
    
    var retweetedStatus: WBStatus!
    
    init?(info: [String : AnyObject]) {
        self.statusID = info["idstr"] as? String
        self.text = info["text"] as? String
        
        let userInfo = info["user"] as? [String : AnyObject] ?? [String : AnyObject]()
        self.user = WBUser(info: userInfo)
        
        self.picURLs = info["pic_urls"] as? Array<[String : String]> ?? []
        
        self.retweetedStatus = {
            let optionRetweetedStatusInfo = info["retweeted_status"] as? [String : AnyObject]
            if let retweetedStatusInfo = optionRetweetedStatusInfo {
                return WBStatus(info: retweetedStatusInfo)
            } else {
                return nil
            }
        }()        
        
        guard let idstr = info["idstr"] as? String where !idstr.isEmpty else { return nil }
    }
}
