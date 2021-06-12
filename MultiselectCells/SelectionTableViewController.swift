//
//  SelectionTableViewController.swift
//  MultiselectCells
//
//  Created by Mohamed Ramadan on 6/12/21.
//

import UIKit

struct ItemModel {
    let title: String
    var isSelected: Bool = false
}

class SelectionTableViewController: UITableViewController {

    var items:[ItemModel] = []
    let cellIdentifier = "Cell"
    var updatePreviousVCSelectedItems:(([ItemModel])->()) = {_ in} // closure to notify previous vc with selected items
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupDoneButton()
        self.setupTableView()
        self.setupTableViewWithPreSelectedItems()
    }
    

    // MARK: - Private Methods
    
    private func setupDoneButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didClickDoneButton))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.isEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }

    @objc func didClickDoneButton() {
        // notify previous vc with selected items
        self.updatePreviousVCSelectedItems(items)
        self.navigationController?.popViewController(animated: true)
    }
    
    // Configure table view selection with previous VC items
    private func setupTableViewWithPreSelectedItems() {
        for (index, item) in self.items.enumerated() {
            if item.isSelected {
                self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
            }
        }
    }
    
    // MARK: - Table view data source
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        
        // change selection background color
        cell.selectionColor = .clear
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select \(items[indexPath.row].title)")
        items[indexPath.row].isSelected = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselect \(items[indexPath.row].title)")
        items[indexPath.row].isSelected = false
    }
}

extension UITableViewCell {
    var selectionColor: UIColor {
        set {
            let view = UIView()
            view.backgroundColor = newValue
            self.selectedBackgroundView = view
        }
        get {
            return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
        }
    }
}
