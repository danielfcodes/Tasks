//
//  DetailCell.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit
import SnapKit

class DetailCell: UITableViewCell {
    
    var viewModel: DetailCellViewModel? {
        didSet {
            makeBindings()
            fillUI()
        }
    }
    
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
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        addSubview(nameTextField)
        addSubview(dateTextField)
        addSubview(doneButton)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(34)
            make.width.equalTo(100)
        }
    }
    
    private func fillUI() {
        nameTextField.text = viewModel?.name
        dateTextField.text = viewModel?.expirationDate
        doneButton.isHidden = viewModel?.isDone ?? true
    }
    
    private func makeBindings() {
        viewModel?.taskDidSetToDone = { [weak self] in
            DispatchQueue.main.async {
                self?.fillUI()
            }
        }
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
