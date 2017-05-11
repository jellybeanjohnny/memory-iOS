//
//  JDICTParserSpec.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/10/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftyJSON

@testable import SharedCode

class JDICTParserSpec: QuickSpec {
    override func spec() {
        describe("The Parser for Japanese JDICT entries") {
            
            let path = Bundle(for: type(of: self)).url(forResource: "mock_jp_definition_response", withExtension: "json")
            let text = try! String(contentsOf: path!)
            let json = JSON(parseJSON: text)
            let parser = JDICTParser()
            let japaneseTerm = parser.parse(json: json).first!
            
            it("should create a Japanese term object with the correct number of elements") {
                expect(japaneseTerm.kana.count).to(equal(7))
                expect(japaneseTerm.kanji.count).to(equal(2))
                expect(japaneseTerm.sense.count).to(equal(1))
            }
            
            it("should have parsed the correct data for each japanese term property") {
                let kanaArray = ["もぐら", "むぐらもち", "むぐら", "もぐらもち", "どりゅう", "モグラ", "モグラモチ"]
                let kanjiArray = ["土竜", "土龍"]
                let senseArray = ["mole (Talpidae spp., esp. the small Japanese mole, Mogera imaizumii)"]
                // Kana
                for (index, kana) in japaneseTerm.kana.enumerated() {
                    expect(kana).to(equal(kanaArray[index]))
                }
                // Kanji
                for (index, kanji) in japaneseTerm.kanji.enumerated() {
                    expect(kanji).to(equal(kanjiArray[index]))
                }
                // Sense
                for (index, sense) in japaneseTerm.sense.enumerated() {
                    expect(sense).to(equal(senseArray[index]))
                }
            }
        }
    }
}
