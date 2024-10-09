//
//  ListOperationsCategoryCell.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

final class ListOperationsCategoryCell: BaseCollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .secondaryText)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .secondaryText)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .rightArrow)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(resource: .accentGray)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryEmojiView: CategoryEmojiView = {
        let view = CategoryEmojiView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func setupCell() {
        super.setupCell()
        backgroundColor = UIColor(resource: .secondaryBackground)
        setCornerRadius(16)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(loadingView)
        addSubview(categoryEmojiView)
        addSubview(leftStackView)
        addSubview(rightStackView)
        addSubview(arrowImageView)
        
        leftStackView.addArrangedSubview(titleLabel)
        leftStackView.addArrangedSubview(countLabel)
        
        rightStackView.addArrangedSubview(amountLabel)
        rightStackView.addArrangedSubview(percentageLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 200),
            
            categoryEmojiView.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryEmojiView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            categoryEmojiView.widthAnchor.constraint(equalToConstant: 40),
            categoryEmojiView.heightAnchor.constraint(equalToConstant: 40),
            
            leftStackView.leadingAnchor.constraint(equalTo: categoryEmojiView.trailingAnchor, constant: 10),
            leftStackView.trailingAnchor.constraint(equalTo: rightStackView.leadingAnchor, constant: -10),
            leftStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightStackView.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -10),
            rightStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

extension ListOperationsCategoryCell: ListOperationsCategoryCellProtocol {
    func configureCell(with category: CategoryEntity?) {
        guard let category else { return }
        
        titleLabel.text = category.title
        countLabel.text = "\(category.operations.count) operations"
        
        let setOperations = category.operations as? Set<OperationEntity> ?? []
        let amount: Double = setOperations
            .map({ $0.amount })
            .reduce(0.0, +)
        
        // FIXME: Fix to currency
        amountLabel.text = amount.description
        
        // FIXME: Fix percentage
        percentageLabel.text = "57%"
        
        loadingView.backgroundColor = UIColor(hex: category.color).withAlphaComponent(0.2)
        categoryEmojiView.configureView(
            with: category.emoji,
            color: UIColor(hex: category.color)
        )
    }
}
