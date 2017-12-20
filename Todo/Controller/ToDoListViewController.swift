//
//  ViewController.swift
//  Todo
//
//  Created by Kavin HS on 19/12/17.
//  Copyright © 2017 Kavin. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        if let  items = defaults.array(forKey: "ToDoList") as? [Item]  {
//            itemArray = items
//        }
    }

   //MARK - Tableview DataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
       cell.accessoryType =  item.isSelected ? .checkmark : .none
        
        return cell
    }
    
    // MARK - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isSelected = !itemArray[indexPath.row].isSelected
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    //MARK - Add new items
    
    @IBAction func onAddPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Afetr add item by user
            if (textField.text?.isEmpty)! {
           
            } else {
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                
//                self.defaults.set(self.itemArray, forKey: "ToDoList")
                
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
             alertTextField.placeholder = "Create new ToDo"
           textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    
}

