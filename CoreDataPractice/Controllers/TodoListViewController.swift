//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Scott OToole on 4/4/19.
//  Copyright © 2019 Scott OToole. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
	
	var itemArray = [Item]()

	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Add Item", message: "Add Item Here", preferredStyle: .alert)
		
		alert.addTextField { (atf) in
			atf.placeholder = "Create New Item"
		}
		
		let action = UIAlertAction(title: "Add", style: .default) { (_) in
			guard let newItem = alert.textFields?.first?.text else {return}
			self.itemArray.append(Item(title: newItem, done: false))
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
			
		}
		
		alert.addAction(action)
		self.present(alert, animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let itemOne = Item(title: "Find Mike", done: false)
		let itemTwo = Item(title: "Buy Eggos", done: false)
		let itemThree = Item(title: "Destroy Demogorgon", done: false)
		
		itemArray.append(itemOne)
		itemArray.append(itemTwo)
		itemArray.append(itemThree)
		
		// Do any additional setup after loading the view.
	}
	
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
		
		cell.textLabel?.text = itemArray[indexPath.row].title
		
		itemArray[indexPath.row].done ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
		
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		tableView.reloadData()
		
		tableView.deselectRow(at: indexPath, animated: true)
	}

	

}

