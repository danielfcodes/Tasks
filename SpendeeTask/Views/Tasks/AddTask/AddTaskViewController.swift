//
//  AddTaskViewController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit

class AddTaskViewController: ToggleKeyboardViewController, StackCreator {
    
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
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private let expirationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Expiration Date"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let expirationDateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let categoryValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Category", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorPalette.infoColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(changeCategoryPressed), for: .touchUpInside)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorPalette.secondaryColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let datePicker:  UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        return datePicker
    }()
    
    private let viewModel: AddTaskViewModel
    
    init(viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        makeBindings()
        setupDatePicker()
    }
    
    private func initialSetup() {
        view.backgroundColor = .white
        title = "Add a Task"
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(introductionLabel)
        
        let nameStack = stackHorizontally(views: [nameLabel, nameTextField], alignment: .fill, distribution: .fillEqually)
        let expirationStack = stackHorizontally(views: [expirationDateLabel, expirationDateTextField], alignment: .fill, distribution: .fillEqually)
        let categoryStack = stackHorizontally(views: [categoryLabel, categoryValueLabel], alignment: .fill, distribution: .fillEqually)
        let verticalStack = stackVertically(views: [nameStack, expirationStack, categoryStack], alignment: .fill, distribution: .fillEqually)
        let buttonStack = stackHorizontally(views: [categoryButton, saveButton], alignment: .fill, distribution: .fillEqually)

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
    
    private func makeBindings() {
        viewModel.categoryDidUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.categoryValueLabel.text = self?.viewModel.category?.name
            }
        }
        
        viewModel.taskSaved = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setupDatePicker() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDatePickerPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDatePickerPressend));
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        expirationDateTextField.inputAccessoryView = toolbar
        expirationDateTextField.inputView = datePicker
    }
    
    @objc
    private func changeCategoryPressed() {
        let changeCategoryViewController = ChangeCategoryViewController()
        changeCategoryViewController.delegate = self
        let navigationController = CustomNavigationController(rootViewController: changeCategoryViewController)
        present(navigationController, animated: true, completion: nil)
    }

    @objc
    private func doneDatePickerPressed(){
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.stringFormat
        expirationDateTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }

    @objc
    private func cancelDatePickerPressend(){
        view.endEditing(true)
    }
    
    @objc
    private func saveButtonPressed() {
        // TODO: Make some validations
        viewModel.saveTask(name: nameTextField.text ?? "", expirationDate: expirationDateTextField.text ?? "")
    }
    
}

extension AddTaskViewController: ChangeCategoryViewControllerDelegate {
    
    func changeCategoryViewControllerDelegate(changeCategoryViewController: ChangeCategoryViewController, didSelectCategory category: Category) {
        changeCategoryViewController.dismiss(animated: true, completion: nil)
        viewModel.setCategory(category)
    }
    
}
