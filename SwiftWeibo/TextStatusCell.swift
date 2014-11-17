//
//  TextStatusCell.swift
//  SwiftWeibo
//
//  Created by cxjwin on 10/27/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import UIKit

class TextStatusCell: UITableViewCell {

	@IBOutlet weak var avatarView: AvatarView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var textView: CWCoreTextView!
	
	var status: WBStatus! {
		didSet {
			// user
			avatarView.URLString = status.user.profileImageUrl
			
			// name
			nameLabel.text = status.user.screenName
			
			// text
			let text = status.text
			var storage = text.transformText()
			
			let paragraphStyle: NSParagraphStyle = {
				var paragraphStyle = NSMutableParagraphStyle()
				
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
				
				return paragraphStyle.copy() as NSParagraphStyle
				}()
			
			let range = NSMakeRange(0, storage.length)
			storage.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(16), range: range)
			storage.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
			
			textView.textStorage = storage
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
