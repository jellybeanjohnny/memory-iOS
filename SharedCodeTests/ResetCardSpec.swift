//
//  ResetCardSpec.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/11/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SharedCode

class ResetCardSpec: QuickSpec {
    override func spec() {
        describe("Resetting a card in the editor") {
            
            let cardViewModel = CardCreationExtensionViewModel()
            cardViewModel.originalText = "土竜土竜土竜もぐら"
            cardViewModel.attributedText = NSMutableAttributedString(string: "土竜土竜土竜もぐら")
            let mockItem = MockItem()
            cardViewModel.items.append(mockItem)
            
            context("Pushing the reset button") {
                it ("should reset the front text to the original") {
                    let clearedAttributedString = NSMutableAttributedString(string: "土竜土竜土竜もぐら")
                    // highlight text
                    cardViewModel.highlightText(atRange: NSRange(location: 0, length: 2))
                    cardViewModel.reset()
                    expect(cardViewModel.attributedText!).to(equal(clearedAttributedString))
                }
                
                it("should clear the back table view") {
                    cardViewModel.clearTableView()
                    let itemCount = cardViewModel.items.count
                    expect(itemCount).to(equal(0))
                }
            }

        }
    }
}
