//
//  UITextView+Extensions.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/9/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

public extension UITextView {
    
    public var selectedText: String {
        var result = ""
        
        if self.selectedRange.length != 0 {
            let text = self.text as NSString
            result = text.substring(with: self.selectedRange) as String
        }
        return result
    }
    
    public func highlightSelectedText() {
        let range = self.selectedRange
        let text = NSMutableAttributedString(attributedString: self.attributedText)
        let attributes = [
            NSForegroundColorAttributeName : UIColor.red,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]
        text.addAttributes(attributes, range: range)
        self.attributedText = text
    }
}
