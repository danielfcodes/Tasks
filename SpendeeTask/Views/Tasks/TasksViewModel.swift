//
//  TasksViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

enum TaskSection: String {
    case pending
    case done
}

protocol TaskItemProtocol {
    var sectionType: TaskSection { get }
    var sectionTitle: String { get }
    var tasks: [Task] { get }
}

struct TaskItem: TaskItemProtocol {
    
    let sectionType: TaskSection
    let tasks: [Task]
    
    var sectionTitle: String {
        return sectionType.rawValue.capitalized
    }
    
    init(sectionType: TaskSection, tasks: [Task]) {
        self.sectionType = sectionType
        self.tasks = tasks
    }
    
}

class TasksViewModel {
    
    var tasksDidLoad: (() -> Void)?
    var items: [TaskItemProtocol] = []
    
    private var tasks: [Task] = []
    private let taskDataSource: TaskDataSourceProtocol
    
    init(taskDataSource: TaskDataSourceProtocol = TaskDataSource()) {
        self.taskDataSource = taskDataSource
    }
    
    func getTasks() {
        items.removeAll()
        tasks.removeAll()
        taskDataSource.getTasks { result in
            switch result {
            case .success(let tasks):
                self.tasks = tasks
                self.setupItems()
            case .failure(let error): print("Error when fetching tasks \(error.localizedDescription)")
            }
        }
    }
    
    func getViewModel(at indexPath: IndexPath) -> TaskCellViewModel {
        return TaskCellViewModel(task: getTask(atIndexPath: indexPath))
    }
    
    func sectionTitleForHeader(index: Int) -> String {
        return items[index].sectionTitle
    }
    
    func getTask(atIndexPath indexPath: IndexPath) -> Task {
        return items[indexPath.section].tasks[indexPath.row]
    }
    
    private func setupItems() {
        let doneTasks = tasks.filter { $0.isDone }
        let pendingTasks = tasks.filter { !$0.isDone }
        items.append(TaskItem(sectionType: .pending, tasks: pendingTasks))
        items.append(TaskItem(sectionType: .done, tasks: doneTasks))
        self.tasksDidLoad?()
    }
    
}
