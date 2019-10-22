//
//  Task.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var expirationDate: String
    var isDone: Bool = false
    var category: Category
    
    init?(moTask: MOTask) {
        guard let moCategory = moTask.moCategory else { return nil }
        self.name = moTask.name ?? ""
        self.expirationDate = ""
        self.isDone = moTask.isDone
        self.category = Category(moCategory: moCategory)
        
    }
    
    init(name: String, expirationDate: String, isDone: Bool, category: Category) {
        self.name = name
        self.expirationDate = expirationDate
        self.isDone = isDone
        self.category = category
    }
}
