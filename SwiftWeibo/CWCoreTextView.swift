//
//  CWCoreTextView.swift
//  CoreTextDemo_Swift
//
//  Created by cxjwin on 10/16/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import UIKit

let kTouchedLinkNotification = "kTouchedLinkNotification"
let kCWInvalidRange = NSMakeRange(NSNotFound, 0)

class CWCoreTextView: UIView, NSLayoutManagerDelegate, UIGestureRecognizerDelegate {
	
	var layoutManager: CWLayoutManager
	var textContainer: NSTextContainer
	
	var touchRange = kCWInvalidRange
	
    var startPoint: CGPoint = CGPointZero
    
	var textStorage: NSTextStorage? {
        willSet {
            if let _textStorage = textStorage {
                _textStorage.removeLayoutManager(layoutManager)
            }
        }
		didSet {
            if let _textStorage = textStorage {
                _textStorage.addLayoutManager(layoutManager)
                invalidateIntrinsicContentSize();
            }
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		layoutManager = CWLayoutManager()
		textContainer = NSTextContainer()
		
		super.init(coder: aDecoder)
		
		layoutManager.delegate = self
		layoutManager.addTextContainer(textContainer)
	}
	
	override func drawRect(rect: CGRect) {
		if let _textStorage: NSTextStorage = textStorage {
			let glyphRange = layoutManager.glyphRangeForTextContainer(textContainer)
			let point = layoutManager.locationForGlyphAtIndex(glyphRange.location)
			layoutManager.drawGlyphsForGlyphRange(glyphRange, atPoint: point)
		}
	}
	
	override var bounds: CGRect {
		didSet {
			if bounds != oldValue {
				invalidateIntrinsicContentSize();
			}
		}
	}
	
	override func intrinsicContentSize() -> CGSize {
		let containerWidth = CGRectGetWidth(self.bounds);
		textContainer.size = CGSize(width: containerWidth, height: CGFloat.max)
		let rect = layoutManager.usedRectForTextContainer(textContainer)
		let height = CGRectGetHeight(rect) + 20.0
		let size = CGSize(width: containerWidth, height: ceil(height))
		
        setNeedsDisplay()
        
		return size
	}
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch: UITouch? = touches.anyObject() as? UITouch
        startPoint = touch!.locationInView(self)
        
        var location = startPoint
        let firstPoint = layoutManager.locationForGlyphAtIndex(0)
        location = CGPoint(x: location.x - firstPoint.x, y: location.y - firstPoint.y)
        
        var fraction: CGFloat = 0
        let index = layoutManager.glyphIndexForPoint(location, inTextContainer: textContainer, fractionOfDistanceThroughGlyph: &fraction)
        
        if (0.01 < fraction && fraction < 0.99) {
            var effectiveRange: NSRange = kCWInvalidRange
            var value: AnyObject? = textStorage?.attribute(NSLinkAttributeName, atIndex: index, effectiveRange: &effectiveRange)
            if let _value: AnyObject = value {
                touchRange = effectiveRange
                layoutManager.touchRange = touchRange
                layoutManager.isTouched = true
                
                NSNotificationCenter.defaultCenter().postNotificationName(kTouchedLinkNotification, object: _value)
                println("\(_value)")
                setNeedsDisplay()
            } else {
                touchRange = kCWInvalidRange
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch: UITouch? = touches.anyObject() as? UITouch
        let currentPoint = touch!.locationInView(self)
        
        let distanceX = currentPoint.x - startPoint.x
        let	distanceY = currentPoint.y - startPoint.y
        let distance = sqrt(distanceX * distanceX + distanceY * distanceY)
        
        if distance > 10.0 {
            touchesCancelled(touches, withEvent: event)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if (touchRange.location != NSNotFound) {
            touchRange = kCWInvalidRange
            layoutManager.isTouched = false
            self.setNeedsDisplay()
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        if (touchRange.location != NSNotFound) {
            touchRange = kCWInvalidRange
            layoutManager.isTouched = false
            self.setNeedsDisplay()
        }
    }
}

// MARK: CWLayoutManager
class CWLayoutManager: NSLayoutManager {
	var touchRange = kCWInvalidRange
	var isTouched = false
	
	override func drawUnderlineForGlyphRange(glyphRange: NSRange, underlineType underlineVal: NSUnderlineStyle, baselineOffset: CGFloat, lineFragmentRect lineRect: CGRect, lineFragmentGlyphRange lineGlyphRange: NSRange, containerOrigin: CGPoint) {
		
		let firstPosition = self.locationForGlyphAtIndex(glyphRange.location).x
		
		var lastPosition: CGFloat
		
		if NSMaxRange(glyphRange) < NSMaxRange(lineGlyphRange) {
			lastPosition = self.locationForGlyphAtIndex(NSMaxRange(glyphRange)).x
		} else {
			lastPosition = self.lineFragmentUsedRectForGlyphAtIndex(NSMaxRange(glyphRange) - 1, effectiveRange:nil).size.width
		}
		
		var tempRect = lineRect
		
		tempRect.origin.x = tempRect.origin.x + firstPosition
		tempRect.size.width = lastPosition - firstPosition
		tempRect.size.height = tempRect.size.height - baselineOffset + 2
		
		tempRect.origin.x = floor(tempRect.origin.x + containerOrigin.x)
		tempRect.origin.y = floor(tempRect.origin.y + containerOrigin.y)
		
		let tempRange = NSIntersectionRange(touchRange, glyphRange)
		if (isTouched && tempRange.length != 0) {
			UIColor.purpleColor().set()
		} else {
			UIColor.greenColor().set()
		}
		
		UIBezierPath(rect: tempRect).fill()
	}
}