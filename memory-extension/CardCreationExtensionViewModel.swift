//
//  CardCreationExtensionViewModel.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/9/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

public protocol CardCreationViewModelDelegate: class {
    func setFront(usingText text: String)
}

public class CardCreationExtensionViewModel {
    
    fileprivate let parser = ExtensionItemParser()
    
    public var originalText: String?
    public weak var delegate: CardCreationViewModelDelegate?
    
    public init() {
        
    }
    
    public func parse(extensionContext: NSExtensionContext) {
        parser.delegate = self
        parser.parse(extensionContext: extensionContext)
    }
    
    public func defineSelectedText(inTextView textView: UITextView) {
        textView.highlightSelectedText()
        let termToDefine = textView.selectedText
        print("Should define: \(termToDefine)")
    }
    
    public func reset(textView: UITextView) {
        textView.text = originalText
    }
    
    public func clearTableView() {
        
    }
    
    public func createCard(usingFrontText: NSAttributedString) {
        
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
