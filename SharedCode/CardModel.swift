//
//  CardModel.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/3/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

public struct CardModel {
    let front: NSAttributedString
    var back: [TermProtocol]
    var date: Date
    
    init(front: NSAttributedString, back: [TermProtocol], date: Date = Date()) {
        self.front = front
        self.back = back
        self.date = date
    }
}
