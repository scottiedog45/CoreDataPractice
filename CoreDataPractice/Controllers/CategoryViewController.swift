//
//  CategoryViewController.swift
//  CoreDataPractice
//
//  Created by Scott OToole on 4/4/19.
//  Copyright © 2019 Scott OToole. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
	
	var categoriesArray = [Category]()
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
		
		let ok = UIAlertAction(title: "OK", style: .default) { (action) in
			let newCategory = Category(context: self.context)
			newCategory.name = alert.textFields?.first?.text
			self.categoriesArray.append(newCategory)
			
			self.saveCategories()
			
			
		}
		
		alert.addAction(ok)
		
		alert.addTextField { (field) in
			field.placeholder = "Add New Category"
		}
		
		present(alert, animated: true, completion: nil)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		loadCategories()
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoriesArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
		
		cell.textLabel?.text = categoriesArray[indexPath.row].name
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as? TodoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC?.selectedCategory = categoriesArray[indexPath.row]
		}
	}
	
	func saveCategories() {
		do {
			try context.save()
		} catch {
			print("Error saving category \(error)")
		}
		
		tableView.reloadData()
		
	}
	
	func loadCategories() {
		let request : NSFetchRequest<Category> = Category.fetchRequest()
		
		do {
		categoriesArray = try context.fetch(request)
		} catch {
			print("error: \(error)")
		}
		
		tableView.reloadData()
	}
	

	
	
	
	
}
