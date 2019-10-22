//
//  AddCategoryViewController.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import UIKit
import SnapKit

class AddCategoryViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let colors: [UIColor] = [.black, .blue, .brown, .cyan, .gray, .green, .magenta, .orange, .purple, .red]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        view.backgroundColor = .white
        title = "Add a Category"
        setupViews()
    }
    
    private func setupViews() {
        let nameStack = stackHorizontally(views: [nameLabel, nameTextField])
        view.addSubview(nameStack)
        view.addSubview(colorView)
        view.addSubview(collectionView)
        
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
    }
    
}

extension AddCategoryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 50, height: 50)
//    }
    
}

extension AddCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
}
