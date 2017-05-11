//
//  DefineJapaneseWordSpec.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/11/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import SharedCode

class DefineJapaneseWordSpec: QuickSpec {
    override func spec() {
        describe("Defining a Japanese word") {
            
            let cardViewModel = CardCreationExtensionViewModel()
            cardViewModel.originalText = "土竜土竜もぐら"
            cardViewModel.attributedText = NSMutableAttributedString(string: "土竜土竜もぐら")
            
            context("Pushing the define word button") {
                
                it("Should highlight the word at the specified range") {
                    
                    let highlightedText = NSMutableAttributedString(string: "土竜土竜もぐら")
                    highlightedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location: 2, length: 2))
                    cardViewModel.highlightText(atRange: NSRange(location: 2, length: 2))
                    expect(cardViewModel.attributedText!).to(equal(highlightedText))
                }
                
                it("should lookup the definition for the item and return a correctly parsed definition object") {
                    let hijacker = NetworkHijacker()
                    hijacker.hijackDefineRequest(toHost: "https://5bfa5988.ngrok.io/search?term=土竜")
                    cardViewModel.defineText(atRange: NSRange(location: 2, length: 2))
                    
                    let mockItem = MockItem()
                    expect(cardViewModel.items.count).toEventually(equal(1))
                    
                    if let item = cardViewModel.items.first {
                        expect(item.term).toEventually(equal(mockItem.term))
                        expect(item.definition).toEventually(equal(mockItem.definition))
                    }
                }
            }
        }
    }
}
