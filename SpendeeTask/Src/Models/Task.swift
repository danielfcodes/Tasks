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
    var setToDone: Date?
    var expirationDate: Date
    var isDone: Bool = false
    var category: Category
    
    var expirationDateString: String {
        return DateFormatter.toString(fromDate: expirationDate)
    }
    
    init?(moTask: MOTask) {
        guard let moCategory = moTask.moCategory else { return nil }
        self.name = moTask.name ?? ""
        self.expirationDate = moTask.expirationDate ?? Date()
        self.isDone = moTask.isDone
        self.setToDone = moTask.setToDone
        self.category = Category(moCategory: moCategory)
    }
    
    init(name: String, expirationDate: String, isDone: Bool, category: Category) {
        self.name = name
        self.expirationDate = DateFormatter.toDate(fromString: expirationDate) ?? Date()
        self.isDone = isDone
        self.category = category
    }
}
