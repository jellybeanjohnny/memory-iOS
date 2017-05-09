//
//  EnglishTerm.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/3/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

public struct EnglishTerm: TermProtocol {
    let word: String
    let termDefinition: String
    
    public var term: String {
        return word
    }
    
    public var definition: String {
        return termDefinition
    }
}
