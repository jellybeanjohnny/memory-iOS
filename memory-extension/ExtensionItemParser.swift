//
//  ExtensionItemParser.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/9/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import MobileCoreServices

protocol ExtensionItemParserDelegate: class {
    func didParse(selectedText: String)
    func parserDidFail(withError error: Error)
}

class ExtensionItemParser {
    
    weak var delegate: ExtensionItemParserDelegate?
    
    func parse(extensionContext: NSExtensionContext) {
        guard let item = extensionContext.inputItems.first as? NSExtensionItem else { return }
        guard let itemProvider = item.attachments?.first as? NSItemProvider else { return }
        loadItem(usingProvider: itemProvider)
    }
    
    fileprivate func loadItem(usingProvider provider: NSItemProvider) {
        if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
            provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { [unowned self] (result, error) in
                
                DispatchQueue.main.async {
                    if let text = result as? String {
                        self.delegate?.didParse(selectedText: text)
                    }
                    
                    if let error = error {
                        self.delegate?.parserDidFail(withError: error)
                    }
                }
                

            })
        }
    }
}
