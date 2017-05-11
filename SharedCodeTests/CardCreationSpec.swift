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
            cardCreationViewModel.originalText = "みんなの土竜たちが土の中から出てきました。"
            cardCreationViewModel.attributedText = NSMutableAttributedString(string: "みんなの土竜たちが土の中から出てきました。")
            context("pushing the create button") {
                
                let frontAttributedText = NSMutableAttributedString(string: "みんなの土竜たちが土の中から出てきました。")
                let mockItem = MockItem()
                let mockCard = CardModel(front: frontAttributedText, back: [mockItem])
                cardCreationViewModel.items.append(mockItem)

                it("should create a card object from the attributed string and the back items") {
                    cardCreationViewModel.createCard()
                    
                    expect(cardCreationViewModel.card).toNot(beNil())
                    expect(cardCreationViewModel.card!.front.string).to(equal(mockCard.front.string))
                    expect(cardCreationViewModel.card!.back.count).to(equal(mockCard.back.count))
                    expect(cardCreationViewModel.card!.back.first!.term).to(equal(mockCard.back.first!.term))
                    expect(cardCreationViewModel.card!.back.first!.definition).to(equal(mockCard.back.first!.definition))
                }
            }
            
        }
    }
}
