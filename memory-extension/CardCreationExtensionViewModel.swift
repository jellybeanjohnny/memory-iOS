//
//  CardCreationExtensionViewModel.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/9/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit

public protocol CardCreationViewModelDelegate: class {
    func setFront(usingAttributedText text: NSAttributedString)
    func refresh()
}

public class CardCreationExtensionViewModel {
    
    fileprivate let parser = ExtensionItemParser()
    fileprivate var searchClient = DictionarySearchAPIClient()
    
    public var originalText: String?
    public var attributedText: NSMutableAttributedString?
    public weak var delegate: CardCreationViewModelDelegate?
    public var items: [TermProtocol] = []
    public var card: CardModel?
    
    public init() {
        
    }
    
    public func parse(extensionContext: NSExtensionContext) {
        parser.delegate = self
        parser.parse(extensionContext: extensionContext)
    }
    
    public func reset() {
        if let originalText = originalText {
            let uneditedText = NSMutableAttributedString(string: originalText)
            attributedText = uneditedText
            delegate?.setFront(usingAttributedText: uneditedText)
        }
    }
    
    public func clearTableView() {
        items.removeAll()
        delegate?.refresh()
    }
    
    public func createCard() {
        if let attributedText = attributedText {
            card = CardModel(front: attributedText, back: items)
        }
    }

    public func defineText(atRange range: NSRange) {
        if searchClient.delegate == nil {
            searchClient.delegate = self
        }
        
        highlightText(atRange: range)
        
        guard let originalText = originalText else { return }
        
        let searchTerm = (originalText as NSString).substring(with: range)
        
        searchClient.search(forItem: searchTerm, language: .japanese)
    }
    
    func highlightText(atRange range: NSRange) {
        
        let highlightattributes = [NSForegroundColorAttributeName : UIColor.red]
        
        if let attributedText = attributedText {
            attributedText.addAttributes(highlightattributes, range: range)
            delegate?.setFront(usingAttributedText: attributedText)
        }
    }
}

// MARK: - Extension Item Parsing Delegate Methods
extension CardCreationExtensionViewModel: ExtensionItemParserDelegate {
    func didParse(selectedText: String) {
        originalText = selectedText
        attributedText = NSMutableAttributedString(string: selectedText)
        delegate?.setFront(usingAttributedText: NSMutableAttributedString(string: selectedText))
    }
    
    func parserDidFail(withError error: Error) {
        print("Parser Error: \(error.localizedDescription)")
    }
}

//MARK: - Search Delegate Methods
extension CardCreationExtensionViewModel: DictionarySearchDelegate {
    func searchDidComplete(terms: [TermProtocol]) {
        for term in terms {
            print("\(term.term)\n\n\(term.definition)\n\n")
            items.append(term)
        }
        delegate?.refresh()
    }
    
    func searchDidFail(withError error: Error) {
        print("Search Failed with error: \(error.localizedDescription)")
    }
}
