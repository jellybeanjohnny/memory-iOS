//
//  CardCreationSpec.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/9/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import SharedCode

class CardCreationSpec: QuickSpec {
    override func spec() {
        describe("Creating a new card") {
            
            let cardCreationViewModel = CardCreationExtensionViewModel()
            cardCreationViewModel.originalText = "みんなの土竜たちが土の穴から出てきました。"
            let spy = CardCreationSpy()
            cardCreationViewModel.delegate = spy
            
            context("Pushing the define word button") {
                it("should parse the selected word") {
                    let textView = UITextView()
                    textView.text = cardCreationViewModel.originalText
                    textView.selectedRange = NSRange(location: 4, length: 2)
                    expect(textView.selectedText).to(equal("土竜"))
                }
                it("should lookup the definition for the word") {
                    // Stub
                }
                
                it("should add the definition to the back table view") {
                    // stub
                }
            }
            
            
            context("pushing the create button") {
                it("Should generate the appropriate card model") {
                    // stub
                }
            }
            
            context("Pushing the reset button") {
                it ("should reset the front text to the original") {
                    let textView = UITextView()
                    let wrongText = "This is the wrong text"
                    textView.text = wrongText
                    cardCreationViewModel.reset(textView: textView)
                    expect(textView.text).to(equal(cardCreationViewModel.originalText))
                }
                
                it("should clear the back table view") {
                    // Stub
                }
            }
        }
    }
}

class CardCreationSpy: CardCreationViewModelDelegate {
    func setFront(usingText text: String) {
        // stub
    }
}
