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
    @IBOutlet weak var backTableView: UITableView!
    
    struct CellIdentifier {
        static let termCell = String(describing: TermTableViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDefineMenu()
        
        viewModel.delegate = self
        if let context = self.extensionContext {
            viewModel.parse(extensionContext: context)
        }
        
        setTableViewDelegatesAndRegisterCells()
    }
    
    func setTableViewDelegatesAndRegisterCells() {
        backTableView.delegate = self
        backTableView.dataSource = self
        // Get access to the correct bundle that contains the TermTableViewCell so that it can be registered
        let bundleUtil = BundleUtility()
        let bundle = bundleUtil.sharedCodeBundle()
        let nib = UINib(nibName: CellIdentifier.termCell, bundle: bundle)
        backTableView.register(nib, forCellReuseIdentifier: CellIdentifier.termCell)
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
        viewModel.createCard()
    }
    
    @IBAction func defineButtonPushed() {
        viewModel.defineText(atRange: frontTextView.selectedRange)
    }
}

extension CardCreationExtensionViewController: CardCreationViewModelDelegate {
    func setFront(usingAttributedText text: NSAttributedString) {
        frontTextView.attributedText = text
    }
    
    func refresh() {
        backTableView.reloadData()
    }
}

extension CardCreationExtensionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.termCell, for: indexPath) as? TermTableViewCell else {
            return UITableViewCell()
        }
        let item = viewModel.items[indexPath.row]
        cell.set(term: item.term)
        cell.set(definition: item.definition)
        return cell
    }
}

