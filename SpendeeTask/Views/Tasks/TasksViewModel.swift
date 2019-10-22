//
//  TasksViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

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
    
    func getTaskCellViewModel(at indexPath: IndexPath) -> TaskCellViewModel {
        return TaskCellViewModel(task: getTask(atIndexPath: indexPath))
    }
    
    func sectionTitleForHeader(index: Int) -> String {
        return items[index].sectionTitle
    }
    
    func getTask(atIndexPath indexPath: IndexPath) -> Task {
        return items[indexPath.section].tasks[indexPath.row]
    }
    
    func taskRemoveFromPending(withIndexPath indexPath: IndexPath) -> Task? {
        guard var pendingTasks = items.first(where: { $0.sectionType == .pending }) else { return nil }
        return pendingTasks.tasks.remove(at: indexPath.row)
    }
    
    func taskAddToDone(withIndexPath indexPath: IndexPath, task: Task) {
        guard var doneTasks = items.first(where: { $0.sectionType == .done }) else { return }
        doneTasks.tasks.insert(task, at: indexPath.row)
    }
    
    func deleteTask(atIndexPath indexPath: IndexPath) {
        let taskToRemove = items[indexPath.section].tasks.remove(at: indexPath.row)
        taskDataSource.deleteTask(withName: taskToRemove.name)
    }
    
    private func setupItems() {
        var doneTasks = tasks.filter { $0.isDone }
        doneTasks.sort(by: { $0.setToDone!.compare($1.setToDone!) == .orderedDescending })
        let pendingTasks = tasks.filter { !$0.isDone }
        items.append(TaskItem(sectionType: .pending, tasks: pendingTasks))
        items.append(TaskItem(sectionType: .done, tasks: doneTasks))
        self.tasksDidLoad?()
    }
    
}
