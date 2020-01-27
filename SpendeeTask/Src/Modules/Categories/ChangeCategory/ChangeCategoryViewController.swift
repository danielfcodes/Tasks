//
//  ChangeCategoryViewController.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

protocol ChangeCategoryViewControllerDelegate: class {
    func changeCategoryViewControllerDelegate(changeCategoryViewController: ChangeCategoryViewController, didSelectCategory category: Category)
}

class ChangeCategoryViewController: UIViewController {
    
    weak var delegate: ChangeCategoryViewControllerDelegate?
    
    private lazy var categoriesChildController: CategoriesViewController = {
        let viewModel = CategoriesViewModel()
        let child = CategoriesViewController(viewModel: viewModel)
        child.delegate = self
        return child
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose a category"
        add(categoriesChildController)
    }
        
    }

extension ChangeCategoryViewController: CategoriesViewControllerDelegate {
    
    func categoriesViewControllerDelegate(didSelectRowAt indexPath: IndexPath, category: Category) {
        delegate?.changeCategoryViewControllerDelegate(changeCategoryViewController: self, didSelectCategory: category)
        dismiss(animated: true, completion: nil)
    }
    
}
