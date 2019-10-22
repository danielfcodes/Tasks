//
//  AddCategoryViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class AddCategoryViewModel {
    
    var categorySaved: (() -> Void)?
    private let categoryDataSource: CategoryDataSourceProtocol
    
    init(categoryDataSource: CategoryDataSourceProtocol = CategoryDataSource()) {
        self.categoryDataSource = categoryDataSource
    }
    
    func saveCategory(name: String, colorHex: String) {
        let category = Category(name: name, color: colorHex)
        categoryDataSource.saveCategory(category) { result in
            switch result {
            case .success: self.categorySaved?()
            case .failure(let error): print("Error when saving... \(error.localizedDescription)")
            }
        }
    }
    
}
