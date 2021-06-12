//
//  ViewController.swift
//  MultiselectCells
//
//  Created by Mohamed Ramadan on 6/12/21.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var selectedItemsLabel: UILabel!
    
    var items: [ItemModel] = [ItemModel(title: "Item 1"),
                              ItemModel(title: "Item 2"),
                              ItemModel(title: "Item 3"),
                              ItemModel(title: "Item 4"),
                              ItemModel(title: "Item 5")]
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.selectedItemsLabel.text = "No Items Selected"
    }

    @IBAction func didClickSelectItemsButton(_ sender: Any) {
        guard let selectionTVC = self.storyboard?.instantiateViewController(identifier: "SelectionTableViewController") as? SelectionTableViewController else { return }
        selectionTVC.items = items
        selectionTVC.updatePreviousVCSelectedItems = { updatedItemsList in
            self.items = updatedItemsList
            
            let selectedItems = self.items.filter({$0.isSelected==true})
            self.selectedItemsLabel.text = selectedItems.isEmpty ? "No Items Selected" : selectedItems.map({$0.title}).joined(separator: ", ")
        }
        
        self.navigationController?.pushViewController(selectionTVC, animated: true)
    }
}

