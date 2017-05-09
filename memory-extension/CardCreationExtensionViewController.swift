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
    @IBOutlet weak var frontTextView: UITextView!
    // BackTableView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        if let context = self.extensionContext {
            viewModel.parse(extensionContext: context)
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
    func setFront(usingText text: String) {
        // set the textview's front text
        frontTextView.text = text
    }
}

