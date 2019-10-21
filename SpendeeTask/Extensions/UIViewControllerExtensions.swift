//
//  UIViewControllerExtensions.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
