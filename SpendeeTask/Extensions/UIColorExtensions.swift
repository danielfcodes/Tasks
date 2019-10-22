//
//  UIColorExtensions.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

extension UIColor {

     class func color(data: Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> NSData? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false) as NSData
     }
    
}
