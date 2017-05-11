//
//  JapaneseTerm.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/3/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

public struct JapaneseTerm: TermProtocol {
    let kana: [String]
    let kanji: [String]
    let sense: [String]
    
    public var term: String {
        let kanjiString = reduceToString(array: kanji)
        let kanaString = reduceToString(array: kana)
        return "\(kanjiString) (\(kanaString))"
    }
    
    public var definition: String {
        return reduceToString(array: sense)
    }
    
    func reduceToString(array: [String]) -> String {
        let result = array.joined(separator: ", ")
        return result
    }
}
