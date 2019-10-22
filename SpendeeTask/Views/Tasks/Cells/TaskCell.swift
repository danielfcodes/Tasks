//
//  TaskCell.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/21/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    var viewModel: TaskCellViewModel? {
        didSet {
            makeBindings()
            fillUI()
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let expirationDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let categoryView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorPalette.secondaryColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(expirationDateLabel)
        addSubview(categoryView)
        addSubview(doneButton)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
        }
        
        expirationDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo(60)
            make.height.equalTo(15)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(34)
            make.width.equalTo(100)
        }
    }
    
    private func fillUI() {
        nameLabel.text = viewModel?.name
        expirationDateLabel.text = viewModel?.expirationDate
        categoryView.backgroundColor = UIColor(hexString: viewModel?.categoryColor ?? "")
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
    private func doneButtonPressed() {
        viewModel?.setTaskToDone()
    }
    
}
