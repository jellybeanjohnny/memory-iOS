//
//  JapaneseTerm.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/3/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

public struct JapaneseTerm: TermProtocol {
    let kana: String
    let kanji: String
    let termDefinition: String
    
    public var term: String {
        return "\(kanji) (\(kana))"
    }
    
    public var definition: String {
        return termDefinition
    }
}
