//
//  CategoryCellViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class CategoryCellViewModel {
    
    var name: String {
        return category.name
    }
    
    var color: String {
        return category.color
    }
    
    private let category: Category
    
    init(category: Category) {
        self.category = category
    }
    
}
