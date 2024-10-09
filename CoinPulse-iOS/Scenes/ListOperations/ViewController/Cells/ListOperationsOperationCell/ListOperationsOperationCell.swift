//
//  ListOperationsOperationCell.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

final class ListOperationsOperationCell: BaseCollectionViewCell {
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .secondaryText)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .secondaryText)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryEmojiView: CategoryEmojiView = {
        let view = CategoryEmojiView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let amountAndAccountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func setupCell() {
        super.setupCell()
        setCornerRadius(16)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(categoryEmojiView)
        addSubview(categoryTitleLabel)
        
        addSubview(descriptionLabel)
        addSubview(amountAndAccountStackView)
        
        amountAndAccountStackView.addArrangedSubview(amountLabel)
        amountAndAccountStackView.addArrangedSubview(accountLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            categoryEmojiView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categoryEmojiView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            categoryEmojiView.widthAnchor.constraint(equalToConstant: 40),
            categoryEmojiView.heightAnchor.constraint(equalToConstant: 40),
            
            categoryTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryEmojiView.trailingAnchor, constant: 10),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: categoryTitleLabel.trailingAnchor),
            
            amountAndAccountStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            amountAndAccountStackView.leadingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor),
            amountAndAccountStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
            amountAndAccountStackView.trailingAnchor.constraint(equalTo: categoryTitleLabel.trailingAnchor),
        ])
    }
}

extension ListOperationsOperationCell: ListOperationsOperationCellProtocol {
    func configureCell(with title: String) {
        categoryTitleLabel.text = "Home"
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor."
        amountLabel.text = "2000₽"
        accountLabel.text = "Cash"
        
        categoryEmojiView.configureView(with: "🐥", color: UIColor(resource: .accentYellow))
        
        backgroundColor = UIColor(resource: .accentYellow).withAlphaComponent(0.1)
    }
}