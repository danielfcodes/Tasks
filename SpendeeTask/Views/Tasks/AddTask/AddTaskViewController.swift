//
//  AddTaskViewController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    private let introductionLabel: UILabel = {
        let label = UILabel()
        label.text = "In order to create a good task for you, we need some input from your side. Please, help us with the following information."
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return textField
    }()
    
    private let expirationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Expiration Date"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let expirationDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let categoryValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Normal"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Category", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        view.backgroundColor = .white
        title = "Add a Task"
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(introductionLabel)
        
        let nameStack = stackHorizontally(views: [nameLabel, nameTextField])
        let expirationStack = stackHorizontally(views: [expirationDateLabel, expirationDateButton])
        let categoryStack = stackHorizontally(views: [categoryLabel, categoryValueLabel])
        let verticalStack = stackVertically(views: [nameStack, expirationStack, categoryStack])
        let buttonStack = stackHorizontally(views: [categoryButton, saveButton])

        view.addSubview(verticalStack)
        view.addSubview(buttonStack)
        
        introductionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(introductionLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
}
