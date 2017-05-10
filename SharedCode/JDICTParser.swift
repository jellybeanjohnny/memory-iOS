//
//  JDICTParser.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/10/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct JDICTParser {

    public func parse(json: JSON) -> JapaneseTerm {
        var kanji: [String] = []
        var kana: [String] = []
        var sense: [String] = []
        for item in json["items"].arrayValue {
            kanji = parseKanji(item: item)
            kana = parseKana(item: item)
            sense = parseSense(item: item)
        }
        let japaneseTerm = JapaneseTerm(kana: kana, kanji: kanji, sense: sense)
        return japaneseTerm
    }
    
    fileprivate func parseKanji(item: JSON) -> [String] {
        var results: [String] = []
        let kanji = item["kanji"].arrayValue
        for member in kanji {
            results.append(member["text"].stringValue)
        }
        return results
    }
    
    fileprivate func parseKana(item: JSON) -> [String] {
        var results: [String] = []
        let kana = item["kana"].arrayValue
        for member in kana {
            results.append(member["text"].stringValue)
        }
        return results
    }
    
    fileprivate func parseSense(item: JSON) -> [String] {
        var results: [String] = []
        let sense = item["sense"].arrayValue
        for member in sense {
            for gloss in member["gloss"].arrayValue {
                results.append(gloss["text"].stringValue)
            }
        }
        return results
    }
}
