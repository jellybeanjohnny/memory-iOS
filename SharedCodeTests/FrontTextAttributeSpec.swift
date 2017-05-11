//
//  FrontTextAttributeSpec.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/11/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SharedCode

class FrontTextAttributeSpec: QuickSpec {
    override func spec() {
        describe("The attributes of the front text") {
            it("should start out with a specified size") {
                let cardViewModel = CardCreationExtensionViewModel()
                cardViewModel.originalText = "The quick brown fox jumps over the lazy dog."
                cardViewModel.attributedText = NSMutableAttributedString(string:"The quick brown fox jumps over the lazy dog.")
                
                let mockAttributedText = NSMutableAttributedString(string: "The quick brown fox jumps over the lazy dog.")
                mockAttributedText.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: Constants.frontOfCardTextSize), range: NSRange(location: 0, length: mockAttributedText.length))
                
                expect(cardViewModel.attributedText).to(equal(mockAttributedText))
            }
            
            it("should highlight the word selected") {
                let cardViewModel = CardCreationExtensionViewModel()
                cardViewModel.originalText = "土竜土竜もぐら"
                cardViewModel.attributedText = NSMutableAttributedString(string: "土竜土竜もぐら")
                
                let highlightedText = NSMutableAttributedString(string: "土竜土竜もぐら")
                highlightedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location: 2, length: 2))
                highlightedText.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 17), range: NSRange(location: 0, length: highlightedText.length))
                cardViewModel.highlightText(atRange: NSRange(location: 2, length: 2))
                expect(cardViewModel.attributedText!).to(equal(highlightedText))
            }
        }
    }
}
