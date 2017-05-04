//
//  ActionViewController.swift
//  memory-extension
//
//  Created by Matt Amerige on 5/3/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit
import MobileCoreServices
import SharedCode

class ActionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseSelectedText()
    }
    
    func parseSelectedText() {
        // This extension will only have one item
        guard let item = self.extensionContext?.inputItems.first as? NSExtensionItem else { return }
        guard let itemProvider = item.attachments?.first as? NSItemProvider else { return }
        loadItem(usingProvider: itemProvider)
    
    }
    
    func loadItem(usingProvider provider: NSItemProvider) {
        if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
            provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (result, error) in
                if let text = result as? String {
                    print(text)
                } else {
                    print(error.localizedDescription)
                }
            })
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
