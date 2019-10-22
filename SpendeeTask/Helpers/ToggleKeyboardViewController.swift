//
//  ToggleKeyboardViewController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

class ToggleKeyboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDissmisKeyboardRecognizer()
    }
    
    private func addDissmisKeyboardRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

}
