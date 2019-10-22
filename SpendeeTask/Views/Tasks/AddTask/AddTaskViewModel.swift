//
//  AddTaskViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class AddTaskViewModel {
    
    var category: Category? {
        didSet {
            categoryDidUpdate?()
        }
    }
    
    var categoryDidUpdate: (() -> Void)?
    
    func setCategory(_ category: Category) {
        self.category = category
    }
    
}
