//
//  EditCardSpec.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/11/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import SharedCode

class EditCardSpec: QuickSpec {
    override func spec() {
        describe("Editing the list of items") {
            let mockCardEditorViewModel = CardCreationExtensionViewModel()
            let sentence = "The quick brown fox jumps over the lazy fuzzy dog."
            mockCardEditorViewModel.originalText = sentence
            mockCardEditorViewModel.attributedText = NSMutableAttributedString(string: sentence)
            
            highlightAndAddItem(mockCardEditorViewModel: mockCardEditorViewModel, sentence: sentence)
            
            let numberOfItems = 10
            
            it("should have the correct number of items") {
                expect(mockCardEditorViewModel.items.count).to(equal(numberOfItems))
                expect(mockCardEditorViewModel.itemRanges.count).to(equal(numberOfItems))
            }
            
            it("should only contain half the amount of items as before") {
                let halvedItemCount = 5
                for index in 0..<halvedItemCount {
                    mockCardEditorViewModel.removeItem(atRow: index)
                }
                expect(mockCardEditorViewModel.items.count).to(equal(halvedItemCount))
            }
            
            it("should remove the items range from its array") {
                expect(mockCardEditorViewModel.itemRanges.count).to(equal(mockCardEditorViewModel.items.count))
            }
            
            it("should remove the highlight from a range") {
                // highlight first word
                // remove highlight from first word
                // compare
            }
        }
    }
    
    
    func highlightAndAddItem(mockCardEditorViewModel: CardCreationExtensionViewModel, sentence: String) {
        let sentenceRange = NSRange(location: 0, length: sentence.characters.count)
        var index = 0
        (sentence as NSString).enumerateSubstrings(in: sentenceRange, options: .byWords, using: { (substring, substringRange, _, _) in
            let item = MockItem(term: "Mock Term \(index)", definition: "Mock definition \(index)")
            mockCardEditorViewModel.mostRecentRange = substringRange
            mockCardEditorViewModel.add(item: item)
            mockCardEditorViewModel.highlightText(atRange: substringRange)
            index += 1
        })
    }
}
