//
//  Item.swift
//  CoreDataPractice
//
//  Created by Scott OToole on 4/4/19.
//  Copyright © 2019 Scott OToole. All rights reserved.
//

import Foundation

class Item {
	var title : String = ""
	var done : Bool = false
	
	init(title: String, done: Bool) {
		self.title = title
		self.done = done
	}
}
