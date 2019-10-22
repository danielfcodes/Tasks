//
//  AddCategoryViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class AddCategoryViewModel {
    
    var title: String {
        return isEditing ? "Edit" : "Add a Category"
    }
    
    var categoryName: String {
        return category?.name ?? ""
    }
    
    var categoryColor: String {
        return category?.color ?? ""
    }
    
    var isEditing: Bool {
        return category != nil
    }
    
    var categorySaved: (() -> Void)?
    var categoryDidLoad: (() -> Void)?
    
    private let categoryDataSource: CategoryDataSourceProtocol
    private var category: Category?
    private var moCategory: MOCategory?
    
    init(category: Category? = nil, categoryDataSource: CategoryDataSourceProtocol = CategoryDataSource()) {
        self.category = category
        self.categoryDataSource = categoryDataSource
    }
    
    func saveCategory(name: String, colorHex: String) {
        if isEditing {
            updateCategoryInDB(name: name, colorHex: colorHex)
        } else {
            saveCategoryInDB(name: name, colorHex: colorHex)
        }
    }
    
    func getCategoryIfNeeded() {
        guard category != nil else { return }
        categoryDataSource.getCategory(withName: category!.name) { result in
            switch result {
            case .success(let moCategory):
                self.moCategory = moCategory
                self.categoryDidLoad?()
            case .failure(let error): print("Error when fetching specific category \(error.localizedDescription)")
            }
        }
    }
    
    private func saveCategoryInDB(name: String, colorHex: String) {
        let category = Category(name: name, color: colorHex)
        categoryDataSource.saveCategory(category) { result in
            switch result {
            case .success: self.categorySaved?()
            case .failure(let error): print("Error when saving... \(error.localizedDescription)")
            }
        }
    }
    
    private func updateCategoryInDB(name: String, colorHex: String) {
        moCategory?.name = name
        moCategory?.color = colorHex
        categoryDataSource.updateCategory { result in
            switch result {
            case .success: self.categorySaved?()
            case .failure(let error): print("Error when saving... \(error.localizedDescription)")
            }
        }
    }
    
}
