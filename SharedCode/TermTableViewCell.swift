//
//  TermTableViewCell.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/11/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

public class TermTableViewCell: UITableViewCell {

    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    public func set(term: String) {
        termLabel.text = term
    }
    
    public func set(definition: String) {
        definitionLabel.text = definition
    }
}
