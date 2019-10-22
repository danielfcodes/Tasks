//
//  Category.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

struct Category {
    var name: String
    var color: UIColor
    
    init(moCategory: MOCategory) {
        self.name = moCategory.name ?? ""
        self.color = UIColor.color(data: moCategory.color! as Data) ?? .black
    }
}
