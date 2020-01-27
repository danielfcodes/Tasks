//
//  TaskItem.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
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
    var tasks: [Task] { get set }
}

class TaskItem: TaskItemProtocol {
    
    let sectionType: TaskSection
    var tasks: [Task]
    
    var sectionTitle: String {
        return sectionType.rawValue.capitalized
    }
    
    init(sectionType: TaskSection, tasks: [Task]) {
        self.sectionType = sectionType
        self.tasks = tasks
    }
    
}
