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
            
            context("Pushing the define word button") {
                it("should parse the selected item") {
                    let textView = UITextView()
                    textView.text = cardCreationViewModel.originalText
                    textView.selectedRange = NSRange(location: 4, length: 2)
                    expect(textView.selectedText).to(equal("土竜"))
                    expect(textView.selectedText).notTo(equal("Wrong Word"))
                }
                
                
                it("should lookup the definition for the item and return a correctly parsed definition object") {
                    let termToDefine = "土竜"
                    let hijacker = NetworkHijacker()
                    hijacker.hijackDefineRequest(toHost: "http://localhost:8080/search?term=\(termToDefine)")
                    cardCreationViewModel.define(searchTerm: termToDefine)
                    
                    let mockItem = Item()
                    expect(cardCreationViewModel.items.count).toEventually(equal(1))
                    
                    if let item = cardCreationViewModel.items.first {
                        expect(item.term).toEventually(equal(mockItem.term))
                        expect(item.definition).toEventually(equal(mockItem.definition))
                    }
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
                    let itemCount = cardCreationViewModel.items.count
                    expect(itemCount).to(equal(0))
                }
            }
        }
    }
}

struct Item: TermProtocol {
    var term: String = "土竜"
    var definition: String = ""
}
