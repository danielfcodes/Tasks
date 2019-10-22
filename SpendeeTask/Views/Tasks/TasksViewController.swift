//
//  TasksViewController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit
import SnapKit

class TasksViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tableView
    }()
    
    private let viewModel: TasksViewModel
    
    init(viewModel: TasksViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getTasks()
    }
    
    private func initialSetup() {
        view.backgroundColor = .white
        title = "Tasks"
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
        let addTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskPressed))
        let settingsButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showSettingsPressed))
        navigationItem.rightBarButtonItems = [addTaskButton, settingsButton]
    }
    
    private func makeBindings() {
        viewModel.tasksDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc
    private func addTaskPressed() {
        let addTaskViewModel = AddTaskViewModel()
        let addTaskViewController = AddTaskViewController(viewModel: addTaskViewModel)
        navigationController?.pushViewController(addTaskViewController, animated: true)
    }
    
    @objc
    private func showSettingsPressed() {
        let settingsViewController = SettingsViewController()
        let navigationController = CustomNavigationController(rootViewController: settingsViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    private func showDetailTask(indexPath: IndexPath) {
        let task = viewModel.getTask(atIndexPath: indexPath)
        let detailViewModel = DetailTaskViewModel(task: task)
        let detailTaskViewController = DetailTaskViewController(withViewModel: detailViewModel)
        navigationController?.pushViewController(detailTaskViewController, animated: true)
    }
    
}

extension TasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = viewModel.items[indexPath.section].sectionType
        switch sectionType {
        case .done: return 100
        case .pending: return 120
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetailTask(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitleForHeader(index: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension TasksViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else { return UITableViewCell() }
        cell.delegate = self
        cell.viewModel = viewModel.getTaskCellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTask(atIndexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
}

extension TasksViewController: TaskCellDelegate {
    
    func taskCellDelegateDidSetToDone(taskCell: TaskCell) {
        guard let oldIndexPath = tableView.indexPath(for: taskCell),
            let deletedTask = viewModel.taskRemoveFromPending(withIndexPath: oldIndexPath) else { return }
        tableView.deleteRows(at: [oldIndexPath], with: .left)
        
        let newIndexPath = IndexPath(row: 0, section: 1)
        viewModel.taskAddToDone(withIndexPath: newIndexPath, task: deletedTask)
        tableView.insertRows(at: [newIndexPath], with: .right)
    }
    
}
