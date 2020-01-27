//
//  DetailCell.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit
import SnapKit

class DetailCell: UITableViewCell, StackCreator {
    
    var viewModel: DetailCellViewModel? {
        didSet {
            makeBindings()
            fillUI()
        }
    }
    
    private let introductionLabel: UILabel = {
        let label = UILabel()
        label.text = "You can still update the name, date and category of your task."
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        textField.addTarget(self, action: #selector(nameTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .systemGray
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorPalette.secondaryColor
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let datePicker:  UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        return datePicker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupDatePicker()
        backgroundColor = .systemGray6
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        addSubview(introductionLabel)

        let textFieldsStack = stackVertically(views: [nameTextField, dateTextField], alignment: .leading, distribution: .fillProportionally)
        let horizontalStack = stackHorizontally(views: [textFieldsStack, doneButton], alignment: .leading, distribution: .fillProportionally)
        
        addSubview(horizontalStack)
        
        introductionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.width.equalTo(100)
        }
        
        horizontalStack.snp.makeConstraints { make in
            make.top.equalTo(introductionLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
    }
    
    private func fillUI() {
        guard viewModel != nil else { return }
        nameTextField.text = viewModel?.name
        dateTextField.text = viewModel?.expirationDate
        nameTextField.isEnabled = !viewModel!.isDone
        dateTextField.isEnabled = !viewModel!.isDone
        
        if viewModel!.isDone {
            doneButton.isEnabled = false
            setupDoneButtonWhenDisable()
        }
    }
    
    private func makeBindings() {
        viewModel?.taskDidSetToDone = { [weak self] in
            DispatchQueue.main.async {
                self?.fillUI()
            }
        }
    }
    
    // TODO: Could be a customButton with this logic inside
    private func setupDoneButtonWhenDisable() {
        doneButton.layer.borderColor = ColorPalette.secondaryColor.cgColor
        doneButton.layer.borderWidth = 1
        doneButton.backgroundColor = .systemGray6
        doneButton.setTitleColor(ColorPalette.secondaryColor, for: .disabled)
    }
    
    @objc
    private func nameTextFieldChanged() {
        viewModel?.setName(nameTextField.text ?? "")
    }
    
    @objc
    private func doneButtonPressed() {
        viewModel?.setTaskToDone()
    }
    
    private func setupDatePicker() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDatePickerPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDatePickerPressend));
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    @objc
    private func doneDatePickerPressed(){
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.stringFormat
        dateTextField.text = formatter.string(from: datePicker.date)
        viewModel?.setExpirationDate(dateTextField.text ?? "")
        endEditing(true)
    }

    @objc
    private func cancelDatePickerPressend(){
        endEditing(true)
    }
    
}
