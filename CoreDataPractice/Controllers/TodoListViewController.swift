//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Scott OToole on 4/4/19.
//  Copyright © 2019 Scott OToole. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController : UITableViewController {
	
	var itemArray = [Item]()
	
	var selectedCategory : Category? {
		didSet {
			loadItems()
		}
	}
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Add Item", message: "Add Item Here", preferredStyle: .alert)
		
		alert.addTextField { (atf) in
			atf.placeholder = "Create New Item"
		}
		
		let action = UIAlertAction(title: "Add", style: .default) { (_) in
			
			guard let newItem = alert.textFields?.first?.text else {return}
			let otherItem = Item(context: self.context)
			otherItem.parent = self.selectedCategory
			otherItem.title = newItem
			otherItem.done = false
			self.itemArray.append(otherItem)
			self.saveItems()
		}
		
		alert.addAction(action)
		self.present(alert, animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		
		//context has to come first
		
//		context.delete(itemArray[indexPath.row])
//
//		itemArray.remove(at: indexPath.row)
		
		saveItems()
		tableView.deselectRow(at: indexPath, animated: true)
	}

	func saveItems() {
		do {
			try context.save()
		} catch {
			print("Error saving context \(error)")
		}
		self.tableView.reloadData()
	}
	
	func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
		
		let categoryPredicate = NSPredicate(format: "parent.name MATCHES %@", self.selectedCategory!.name!)
		
		if let additionalPredicate = predicate {
			request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
		} else {
			request.predicate = categoryPredicate
		}
		
		do {
			itemArray = try context.fetch(request)
		} catch {
			print("Error \(error)")
		}
		tableView.reloadData()
	}
}

//MARK: - search bar methods
extension TodoListViewController : UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let request : NSFetchRequest<Item> = Item.fetchRequest()
		let predicate : NSPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
		request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
		loadItems(with: request, predicate: predicate)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text!.count == 0 {
			loadItems()
			DispatchQueue.main.async {
				searchBar.resignFirstResponder()
			}
		}
	}
}
