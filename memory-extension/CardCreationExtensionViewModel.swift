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
    fileprivate var searchClient = DictionarySearchAPIClient()
    
    public var originalText: String?
    public weak var delegate: CardCreationViewModelDelegate?
    public var items: [TermProtocol] = []
    
    
    public init() {
        
    }
    
    public func parse(extensionContext: NSExtensionContext) {
        parser.delegate = self
        parser.parse(extensionContext: extensionContext)
    }
    
    public func defineSelectedText(inTextView textView: UITextView) {
        textView.highlightSelectedText()
        let termToDefine = textView.selectedText
        define(searchTerm: termToDefine)
    }
    
    
    public func reset(textView: UITextView) {
        textView.text = originalText
    }
    
    public func clearTableView() {
        items.removeAll()
        // reload tableview
    }
    
    public func createCard(usingFrontText: NSAttributedString) {
        
    }
    
    //MARK: - Internal
    func define(searchTerm: String) {
        searchClient.delegate = self
        searchClient.search(forItem: searchTerm, language: .japanese)
    }
}

// MARK: - Extension Item Parsing Delegate Methods
extension CardCreationExtensionViewModel: ExtensionItemParserDelegate {
    func didParse(selectedText: String) {
        originalText = selectedText
        delegate?.setFront(usingText: selectedText)
    }
    
    func parserDidFail(withError error: Error) {
        print(error)
    }
}

//MARK: - Search Delegate Methods
extension CardCreationExtensionViewModel: DictionarySearchDelegate {
    func searchDidComplete(term: TermProtocol) {
        print("Search Completed with term: \(term)")
        items.append(term)
    }
    
    func searchDidFail(withError error: Error) {
        print("Search Failed with error: \(error.localizedDescription)")
    }
}
