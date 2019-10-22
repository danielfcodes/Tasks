//
//  AddCategoryViewController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit
import SnapKit

class AddCategoryViewController: ToggleKeyboardViewController, StackCreator {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
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
    
    private let colors: [UIColor] = [.black, .blue, .brown, .cyan, .gray, .green, .magenta, .orange, .purple, .red]
    private let viewModel: AddCategoryViewModel
    
    init(viewModel: AddCategoryViewModel) {
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
        viewModel.getCategoryIfNeeded()
    }
    
    private func initialSetup() {
        view.backgroundColor = .white
        title = viewModel.title
        setupViews()
        
    }
    
    private func setupViews() {
        let nameStack = stackHorizontally(views: [nameLabel, nameTextField], alignment: .fill, distribution: .fillEqually)
        view.addSubview(nameStack)
        view.addSubview(colorView)
        view.addSubview(collectionView)
        view.addSubview(saveButton)
        
        nameStack.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        colorView.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(colorView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
    }
    
    private func makeBindings() {
        viewModel.categorySaved = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.categoryDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.nameTextField.text = self?.viewModel.categoryName
                self?.colorView.backgroundColor = UIColor(hexString: self?.viewModel.categoryColor ?? "")
            }
        }
    }
    
    private func changeColorView(withColor color: UIColor) {
        colorView.backgroundColor = color
    }
    
    @objc
    private func saveButtonPressed() {
        // TODO: Make some validations
        viewModel.saveCategory(name: nameTextField.text ?? "", colorHex: colorView.backgroundColor?.toHexString() ?? "")
    }
    
}

extension AddCategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changeColorView(withColor: colors[indexPath.item])
    }
    
}

extension AddCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
}
