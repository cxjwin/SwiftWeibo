//
//  RTImageStatusCell.swift
//  SwiftWeibo
//
//  Created by cxjwin on 10/27/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import UIKit

class RTImageStatusCell: UITableViewCell {

	@IBOutlet weak var avatarView: AvatarView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var textView: CWCoreTextView!
	@IBOutlet weak var rtTextView: CWCoreTextView!
	@IBOutlet weak var picView: UIView!
	
	var status: WBStatus! {
		didSet {
			// user
			avatarView.URLString = status.user.profileImageUrl
			
			// name
			nameLabel.text = status.user.screenName
			
			// text
			let text = status.text
			let storage = text.transformText()
			
			let paragraphStyle: NSParagraphStyle = {
				let paragraphStyle = NSMutableParagraphStyle()
				
				paragraphStyle.lineSpacing = 5
				paragraphStyle.paragraphSpacing = 15
				paragraphStyle.alignment = .Left
				paragraphStyle.firstLineHeadIndent = 0
				paragraphStyle.headIndent = 0
				paragraphStyle.tailIndent = -5
				paragraphStyle.lineBreakMode = .ByWordWrapping
				paragraphStyle.minimumLineHeight = 10
				paragraphStyle.maximumLineHeight = 20
				paragraphStyle.baseWritingDirection = .LeftToRight
				paragraphStyle.lineHeightMultiple = 0.8
				paragraphStyle.hyphenationFactor = 2
				paragraphStyle.paragraphSpacingBefore = 0
				
				return paragraphStyle.copy() as! NSParagraphStyle
				}()
			
			let range = NSMakeRange(0, storage.length)
			storage.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(16), range: range)
			storage.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
			
			textView.textStorage = storage
			
			// retweeted text
			if let retweetedStatus = status.retweetedStatus {
				let rtText = retweetedStatus.text
				let storage = rtText.transformText()
				
				let range = NSMakeRange(0, storage.length)
				storage.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(16), range: range)
				storage.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
				
				rtTextView.textStorage = storage
			}
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
