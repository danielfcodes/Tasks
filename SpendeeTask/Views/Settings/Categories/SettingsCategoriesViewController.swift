//
//  SettingsCategoriesViewController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

class SettingsCategoriesViewController: UIViewController {
    
    private lazy var categoriesChildController: CategoriesViewController = {
        let child = CategoriesViewController()
        child.delegate = self
        return child
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        add(categoriesChildController)
        addBarButtons()
    }
    
    private func addBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategoryPressed))
    }
    
    @objc
    private func addCategoryPressed() {
        print("add category")
    }
    
}

extension SettingsCategoriesViewController: CategoriesViewControllerDelegate {
    
    func categoriesViewControllerDelegate(didSelectRowAt indexPath: IndexPath) {
        print("edit category")
    }
    
}
