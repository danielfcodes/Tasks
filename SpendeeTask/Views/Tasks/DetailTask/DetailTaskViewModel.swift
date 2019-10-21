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
    
    func sectionForHeader(index: Int) -> String {
        return items[index].sectionTitle
    }
    
    private func setupItems() {
        items.append(DetailItem(section: .general, task: task))
        items.append(DetailItem(section: .category, task: task))
    }
    
}
