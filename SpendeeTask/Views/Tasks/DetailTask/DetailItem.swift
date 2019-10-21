//
//  DetailItem.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

enum DetailSection: String {
    case general
    case category
}

protocol DetailItemProtocol {
    var sectionTitle: String { get }
    var task: Task { get }
}

struct DetailItem: DetailItemProtocol {
    
    let section: DetailSection
    let task: Task
    
    var sectionTitle: String {
        return section.rawValue.capitalized
    }
    
    init(section: DetailSection, task: Task) {
        self.section = section
        self.task = task
    }
    
}
