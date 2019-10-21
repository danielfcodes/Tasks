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
    var sectionType: DetailSection { get }
    var sectionTitle: String { get }
    var task: Task { get }
}

struct DetailItem: DetailItemProtocol {
    
    let sectionType: DetailSection
    let task: Task
    
    var sectionTitle: String {
        return sectionType.rawValue.capitalized
    }
    
    init(sectionType: DetailSection, task: Task) {
        self.sectionType = sectionType
        self.task = task
    }
    
}
