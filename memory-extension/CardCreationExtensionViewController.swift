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
    @IBOutlet weak var frontTextView: UITextView!
    // BackTableView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        if let context = self.extensionContext {
            viewModel.parse(extensionContext: context)
        }
    }
    
    func dismiss() {
        self.extensionContext?.completeRequest(returningItems: self.extensionContext?.inputItems, completionHandler: nil)
    }
    
    //MARK: - Buttons
    @IBAction func closeButtonPushed() {
        dismiss()
    }
    
    @IBAction func resetButtonPushed() {
        print("Reset button pushed")
    }
    
    @IBAction func createCardButtonPushed() {
        print("Create card button pushed")
    }
    
    @IBAction func defineButtonPushed() {
        print("Define button pushed")
    }
    

}

extension CardCreationExtensionViewController: CardCreationViewModelDelegate {
    func setFront(usingText text: String) {
        frontTextView.text = text
    }
}

