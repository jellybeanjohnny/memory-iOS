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
        addDefineMenu()
        
        viewModel.delegate = self
        if let context = self.extensionContext {
            viewModel.parse(extensionContext: context)
        }
    }
    
    func addDefineMenu() {
        let defineMenuItem = UIMenuItem(title: "Define", action: #selector(defineButtonPushed))
        UIMenuController.shared.menuItems = [defineMenuItem]
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
        // should clear all edits done to the front of the card
        viewModel.reset()
        // should clear the back tableview
        viewModel.clearTableView()
        
    }
    
    @IBAction func createCardButtonPushed() {
        print("Create card button pushed")
        // should create a single card
        viewModel.createCard(usingFrontText: frontTextView.attributedText)
    }
    
    @IBAction func defineButtonPushed() {
        print("Define button pushed")
        // should parse the selected text, highlight it, and define it
        viewModel.define(searchTerm: frontTextView.selectedText)
    }
    

}

extension CardCreationExtensionViewController: CardCreationViewModelDelegate {
    func setFront(usingAttributedText text: NSAttributedString) {
        frontTextView.attributedText = text
    }
}

