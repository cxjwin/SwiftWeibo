//
//  StatusImageView.swift
//  SwiftWeibo
//
//  Created by cxjwin on 10/27/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import UIKit

class StatusImageView: UIView {

	var picURLs: NSArray? {
		didSet {
			if let _ = picURLs {
				
			}
		}
	}
	
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
	
}
