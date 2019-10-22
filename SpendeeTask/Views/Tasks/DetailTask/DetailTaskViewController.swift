//
//  DetailTaskViewController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

class DetailTaskViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        return tableView
    }()
    
    private let viewModel: DetailTaskViewModel
    
    init(withViewModel viewModel: DetailTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        makeBindings()
    }
    
    private func initialSetup() {
        view.backgroundColor = .white
        title = "Detail"
        setupTableView()
        addBarButtons()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    private func addBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateTask))
    }
    
    private func makeBindings() {
        viewModel.categoryDidUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integersIn: 1...1), with: .fade)
            }
        }
        
        viewModel.categorySaved = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func showChangeCategory() {
        let changeCategoryViewController = ChangeCategoryViewController()
        changeCategoryViewController.delegate = self
        navigationController?.pushViewController(changeCategoryViewController, animated: true)
    }
    
    @objc
    private func updateTask() {
        // TODO: Make some validations
        viewModel.updateTask()
    }
    
}

extension DetailTaskViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = viewModel.sectionForHeader(index: indexPath.section)
        switch sectionType {
        case .general: return 200
        case .category: return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionType = viewModel.sectionForHeader(index: indexPath.section)
        switch sectionType {
        case .general: return
        case .category: showChangeCategory()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitleForHeader(index: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension DetailTaskViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = viewModel.sectionForHeader(index: indexPath.section)
        switch sectionType {
        case .general: return setupDetailCell(indexPath: indexPath)
        case .category: return setupCategoryCell(indexPath: indexPath)
        }
    }
    
    private func setupDetailCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getDetailCellViewModel()
        return cell
    }
    
    private func setupCategoryCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getCategoryCellViewModel()
        return cell
    }
    
}

extension DetailTaskViewController: ChangeCategoryViewControllerDelegate {
    
    func changeCategoryViewControllerDelegate(changeCategoryViewController: ChangeCategoryViewController, didSelectCategory category: Category) {
        changeCategoryViewController.navigationController?.popViewController(animated: true)
        viewModel.setCategory(category)
    }
    
}
