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
    
    weak var delegate: CardCreationViewModelDelegate?
    
    func parse(extensionContext: NSExtensionContext) {
        parser.delegate = self
        parser.parse(extensionContext: extensionContext)
    }
    
    func highlightSelectedText(inTextView textView: UITextView) {
        let range = textView.selectedRange
        let text = NSMutableAttributedString(attributedString: textView.attributedText)
        let attributes = [
            NSForegroundColorAttributeName : UIColor.red,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20.0)]
        text.addAttributes(attributes, range: range)
        textView.attributedText = text
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
