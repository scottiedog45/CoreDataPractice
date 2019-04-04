//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Scott OToole on 4/4/19.
//  Copyright © 2019 Scott OToole. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
	
	let itemArray : [String] = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		
		if cell?.accessoryType == .checkmark {
			cell?.accessoryType = .none
		} else {
		
		cell?.accessoryType = .checkmark
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		
	}


}

