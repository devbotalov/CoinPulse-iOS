//
//  AddCategoryViewController.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 18.10.2024.
//

import UIKit

final class AddCategoryViewController: AddCategory.DisplayLogic {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = UIColor(resource: .primaryText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var interactor: AddCategory.BusinessLogic?
    
    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}

