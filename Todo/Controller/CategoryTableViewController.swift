//
//  CategoryTableViewController.swift
//  Todo
//
//  Created by Kavin HS on 21/12/17.
//  Copyright © 2017 Kavin. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    var realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }
    
    
    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories Added"
        return cell
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "New Category", message: "Add a new Category to the list", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            if !(alertTextField.text?.isEmpty)! {
                let newCategory = Category()
                newCategory.name = alertTextField.text!
                
                self.saveCategory(category: newCategory)
            }
            
        }
        
        alert.addAction(action)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Add new Category"
            alertTextField = textField
            
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK - Add Category
    
    func saveCategory(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error in saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK - Data MAnipulation
    
    func loadCategory(){
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
}
