//
//  CategoriesViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class CategoriesViewModel {
    
    var categories: [Category] = []
    var categoriesDidLoad: (() -> Void)?
    
    private let categoryDataSource: CategoryDataSourceProtocol
    
    init(categoryDataSource: CategoryDataSourceProtocol = CategoryDataSource()) {
        self.categoryDataSource = categoryDataSource
    }
    
    func getCategories() {
        categoryDataSource.getCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                self.categoriesDidLoad?()
            case .failure(let error): print("Error when fetching \(error.localizedDescription)")
            }
        }
    }
    
    func getViewModel(at indexPath: IndexPath) -> CategoryCellViewModel {
        return CategoryCellViewModel(category: categories[indexPath.row])
    }
    
}
