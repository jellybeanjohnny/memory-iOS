//
//  CardCreationExtensionViewModel.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/9/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation

protocol CardCreationViewModelDelegate: class {
    func setFront(usingText text: String)
}

class CardCreationExtensionViewModel {
    let parser = ExtensionItemParser()
    weak var delegate: CardCreationViewModelDelegate?
    
    
    func parse(extensionContext: NSExtensionContext) {
        parser.delegate = self
        parser.parse(extensionContext: extensionContext)
    }
}

extension CardCreationExtensionViewModel: ExtensionItemParserDelegate {
    func didParse(selectedText: String) {
        delegate?.setFront(usingText: selectedText)
    }
    
    func parserDidFail(withError error: Error) {
        print(error)
    }
}
