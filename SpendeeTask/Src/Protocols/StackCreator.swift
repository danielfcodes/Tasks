//
//  StackCreator.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

protocol StackCreator {
    func stackHorizontally(views: [UIView], alignment: UIStackView.Alignment, distribution: UIStackView.Distribution) -> UIStackView
    func stackVertically(views: [UIView], alignment: UIStackView.Alignment, distribution: UIStackView.Distribution) -> UIStackView
}

extension StackCreator {
    
    func stackHorizontally(views: [UIView], alignment: UIStackView.Alignment, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }
    
    func stackVertically(views: [UIView], alignment: UIStackView.Alignment, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }
    
}
