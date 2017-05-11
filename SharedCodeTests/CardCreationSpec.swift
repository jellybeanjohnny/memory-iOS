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
            let searchTerm = "土竜"
            
            context("Pushing the define word button") {
   
                it("should lookup the definition for the item and return a correctly parsed definition object") {
                    let hijacker = NetworkHijacker()
                    hijacker.hijackDefineRequest(toHost: "https://5bfa5988.ngrok.io/search?term=\(searchTerm)")
                    cardCreationViewModel.define(searchTerm: searchTerm)
                    
                    let mockItem = Item()
                    expect(cardCreationViewModel.items.count).toEventually(equal(1))
                    
                    if let item = cardCreationViewModel.items.first {
                        expect(item.term).toEventually(equal(mockItem.term))
                        expect(item.definition).toEventually(equal(mockItem.definition))
                    }
                }
            }
            
            context("pushing the create button") {
                it("Should generate the appropriate card model given the front text and back items") {
                    
                    let frontAttributedText = NSMutableAttributedString(string: cardCreationViewModel.originalText!)
                    let range = (cardCreationViewModel.originalText! as NSString).range(of: "土竜")
                    let attributes = [
                        NSForegroundColorAttributeName : UIColor.red,
                        NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]
                    frontAttributedText.addAttributes(attributes, range: range)
                    
                    let mockItem = Item()
                    let mockCard = CardModel(front: frontAttributedText, back: [mockItem])
                    
                    cardCreationViewModel.createCard(usingFrontText: cardCreationViewModel.attributedText!)

                    expect(cardCreationViewModel.card!.front).to(equal(mockCard.front))
                    expect(cardCreationViewModel.card!.back.count).to(equal(mockCard.back.count))
                    expect(cardCreationViewModel.card!.back.first!.term).to(equal(mockCard.back.first!.term))
                    expect(cardCreationViewModel.card!.back.first!.definition).to(equal(mockCard.back.first!.definition))
                }
            }
            
            context("Pushing the reset button") {
                it ("should reset the front text to the original") {
                    let clearedAttributedString = NSMutableAttributedString(string: cardCreationViewModel.originalText!)
                    cardCreationViewModel.reset()
                    expect(cardCreationViewModel.attributedText!).to(equal(clearedAttributedString))
                }

                it("should clear the back table view") {
                    cardCreationViewModel.clearTableView()
                    let itemCount = cardCreationViewModel.items.count
                    expect(itemCount).to(equal(0))
                }
            }
        }
    }
}

struct Item: TermProtocol {
    var term: String = "土竜, 土龍, (もぐら, むぐらもち, むぐら, もぐらもち, どりゅう, モグラ, モグラモチ)"
    var definition: String = "mole (Talpidae spp., esp. the small Japanese mole, Mogera imaizumii)"
}
