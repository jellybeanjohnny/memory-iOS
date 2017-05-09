//
//  CardCreationExtensionViewController.swift
//  memory-extension
//
//  Created by Matt Amerige on 5/3/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import UIKit
import SharedCode

class CardCreationExtensionViewController: UIViewController {
    
    var viewModel = CardCreationExtensionViewModel()
    // FrontTextView
    // BackTableViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let context = self.extensionContext {
            viewModel.parseSelectedText(extensionContext: context)
        }
    }
    
    

    @IBAction func done() {
        dismiss()
    }
    
    func dismiss() {
        self.extensionContext?.completeRequest(returningItems: self.extensionContext?.inputItems, completionHandler: nil)
    }
}

extension CardCreationExtensionViewController: CardCreationViewModelDelegate {
    func setFront(usingText: String) {
        // set the textview's front text
    }
}

