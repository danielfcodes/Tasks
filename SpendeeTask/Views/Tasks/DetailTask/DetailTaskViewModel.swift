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
    
    private var items: [DetailItemProtocol] = []
    private let task: Task
    
    init(task: Task) {
        self.task = task
        setupItems()
    }
    
    func sectionForHeader(index: Int) -> DetailSection {
        return items[index].sectionType
    }
    
    func sectionTitleForHeader(index: Int) -> String {
        return items[index].sectionTitle
    }
    
    private func setupItems() {
        items.append(DetailItem(sectionType: .general, task: task))
        items.append(DetailItem(sectionType: .category, task: task))
    }
    
}
