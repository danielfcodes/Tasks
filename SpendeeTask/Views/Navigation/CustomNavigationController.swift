//
//  CustomNavigationController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(red: 236/255, green: 90/255, blue: 70/255, alpha: 1.0)
        
        self.navigationBar.standardAppearance = navBarAppearance
        self.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.tintColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
