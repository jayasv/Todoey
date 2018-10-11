//
//  ViewController.swift
//  Todoey
//
//  Created by user142012 on 10/6/18.
//  Copyright © 2018 user142012. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
       // print(dataFilePath!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        let newItem1 = Item()
        newItem1.title = "Banana"
        itemArray.append(newItem1)
        let newItem2 = Item()
        newItem2.title = "Strawberries"
        itemArray.append(newItem2)
       
        loadItems()
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false
        }
        saveItems()
        
                tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title:"Add new a Todo item ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
           
           self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    //MARK - Model Manipulation methods
    
    func saveItems() {
       
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
        
    }
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let  decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error \(error)")
            }
        }
    }
    
    
}

