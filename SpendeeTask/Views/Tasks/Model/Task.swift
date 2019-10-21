//
//  Task.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

struct Task {
    var name: String
    var expirationDate: String
    var isDone: Bool = false
    var category: TaskCategory = .normal
    
    enum TaskCategory {
        case important
        case normal
        case trivial
    }
}
