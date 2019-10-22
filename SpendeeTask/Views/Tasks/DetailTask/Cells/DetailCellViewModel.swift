//
//  DetailCellViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class DetailCellViewModel {
    
    var name: String {
        return task.name
    }
    
    var expirationDate: String {
        return task.expirationDate
    }
    
    var isDone: Bool {
        return task.isDone
    }
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
}
