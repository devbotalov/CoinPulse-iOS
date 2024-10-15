//
//  AllCategoriesCategoryCell.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import UIKit

final class AllCategoriesCategoryCell: BaseCollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryEmojiView: CategoryEmojiView = {
        let view = CategoryEmojiView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Brief statistics"
        label.textColor = UIColor(resource: .secondaryText)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weekStatisticsView = BriefStatisticsView()
    
    private let monthStatisticsView = BriefStatisticsView()
    
    private let yearStatisticsView = BriefStatisticsView()
    
    private let statisticsStackView: UIStackView = {
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
        setCornerRadius(12)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(titleLabel)
        addSubview(categoryEmojiView)
        addSubview(subtitleLabel)
        addSubview(statisticsStackView)
        
        statisticsStackView.addArrangedSubview(weekStatisticsView)
        statisticsStackView.addArrangedSubview(monthStatisticsView)
        statisticsStackView.addArrangedSubview(yearStatisticsView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            categoryEmojiView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categoryEmojiView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            categoryEmojiView.widthAnchor.constraint(equalToConstant: 40),
            categoryEmojiView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: categoryEmojiView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: categoryEmojiView.centerYAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: categoryEmojiView.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: categoryEmojiView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            statisticsStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            statisticsStackView.leadingAnchor.constraint(equalTo: categoryEmojiView.leadingAnchor),
            statisticsStackView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -10),
            statisticsStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}

extension AllCategoriesCategoryCell: AllCategoriesCategoryCellProtocol {
    func configureCell(category: CategoryEntity?) {
        guard let category else { return }
        
        titleLabel.text = category.title
        
        categoryEmojiView.configureView(
            with: category.emoji,
            color: UIColor(hex: category.color)
        )
        
        weekStatisticsView.configureView(
            title: "Per week",
            subtitle: Double(200).toCurrency
        )
        
        monthStatisticsView.configureView(
            title: "Per month",
            subtitle: Double(400).toCurrency
        )
        
        yearStatisticsView.configureView(
            title: "Per year",
            subtitle: Double(600).toCurrency
        )
        
        backgroundColor = UIColor(hex: category.color).withAlphaComponent(0.2)
    }
}
