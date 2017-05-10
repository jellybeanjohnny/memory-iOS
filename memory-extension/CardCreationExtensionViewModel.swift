//
//  CardCreationExtensionViewModel.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/9/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

protocol CardCreationViewModelDelegate: class {
    func setFront(usingText text: String)
}

class CardCreationExtensionViewModel {
    
    fileprivate let parser = ExtensionItemParser()
    
    var originalText: String?
    weak var delegate: CardCreationViewModelDelegate?
    
    func parse(extensionContext: NSExtensionContext) {
        parser.delegate = self
        parser.parse(extensionContext: extensionContext)
    }
    
    func defineSelectedText(inTextView textView: UITextView) {
        textView.highlightSelectedText()
        let termToDefine = textView.selectedText
        print("Should define: \(termToDefine)")
    }
    
    func reset(textView: UITextView) {
        textView.text = originalText
    }
    
    func clearTableView() {
        
    }
    
    func createCard(usingFrontText: NSAttributedString) {
        
    }
}

extension CardCreationExtensionViewModel: ExtensionItemParserDelegate {
    func didParse(selectedText: String) {
        originalText = selectedText
        delegate?.setFront(usingText: selectedText)
    }
    
    func parserDidFail(withError error: Error) {
        print(error)
    }
}
