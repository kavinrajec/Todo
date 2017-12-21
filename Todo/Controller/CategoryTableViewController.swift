//
//  CategoryTableViewController.swift
//  Todo
//
//  Created by Kavin HS on 21/12/17.
//  Copyright © 2017 Kavin. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }
    
    
    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        return cell
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "New Category", message: "Add a new Category to the list", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            if !(alertTextField.text?.isEmpty)! {
                let newCategory = Category(context: self.context)
                newCategory.name = alertTextField.text
                
                self.categoryArray.append(newCategory)
                self.saveCategory()
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
    
    func saveCategory(){
        
        do {
            try context.save()
        } catch {
            print("Error in saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK - Data MAnipulation
    
    func loadCategory(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching category list context \(error)")
        }
        tableView.reloadData()
    }
    
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
}
