//
//  DetailTaskViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class DetailTaskViewModel {
    
    var numberOfRows: Int {
        return items.count
    }
    
    var isDone: Bool {
        return task.isDone
    }
    
    var categorySaved: (() -> Void)?
    var categoryDidUpdate: (() -> Void)?
    
    private let taskDataSource: TaskDataSourceProtocol
    private let notificationScheduler: NotificationSchedulerDelegate
    private var items: [DetailItemProtocol] = []
    private var task: Task
    private var moTask: MOTask?
    
    init(task: Task, taskDataSource: TaskDataSourceProtocol = TaskDataSource(),
         notificationScheduler: NotificationSchedulerDelegate = NotificationScheduler()) {
        self.task = task
        self.taskDataSource = taskDataSource
        self.notificationScheduler = notificationScheduler
        setupItems()
        getMOTask()
    }
    
    func setCategory(_ category: Category) {
        task.category = category
        categoryDidUpdate?()
    }
    
    func sectionForHeader(index: Int) -> DetailSection {
        return items[index].sectionType
    }
    
    func sectionTitleForHeader(index: Int) -> String {
        return items[index].sectionTitle
    }
    
    func getDetailCellViewModel() -> DetailCellViewModel {
        return DetailCellViewModel(task: task)
    }
    
    func getCategoryCellViewModel() -> CategoryCellViewModel {
        return CategoryCellViewModel(category: task.category)
    }
    
    func updateTask() {
        guard moTask != nil else { return }
        taskDataSource.updateTask(moTask: moTask!, task: task) { result in
            switch result {
            case .success:
                self.setNotification(forDate: self.task.expirationDate, name: self.task.name)
                self.categorySaved?()
            case .failure(let error): print("Error when updating task \(error.localizedDescription)")
            }
        }
    }
    
    private func setupItems() {
        items.append(DetailItem(sectionType: .general, task: task))
        items.append(DetailItem(sectionType: .category, task: task))
    }
    
    private func getMOTask() {
        taskDataSource.getTask(withName: task.name) { result in
            switch result {
            case .success(let moTask): self.moTask = moTask
            case .failure(let error): print("Error when fetching task \(error.localizedDescription)")
            }
        }
    }
    
    private func setNotification(forDate date: Date, name: String) {
        notificationScheduler.scheduleNotification(forDate: date, withName: name)
    }
    
}
