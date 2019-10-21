//
//  CellProtocol.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

protocol CellProtocol: class {
    static var identifier: String { get }
}

extension CellProtocol where Self: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
