//
//  ListOperationsCalendarDayCell.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

final class ListOperationsCalendarDayCell: BaseCollectionViewCell {
    
    private let shortDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .accentLightGray)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayMonthLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func setupCell() {
        super.setupCell()
        setCornerRadius(12)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(commonStackView)
        
        commonStackView.addArrangedSubview(shortDayLabel)
        commonStackView.addArrangedSubview(dayMonthLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            commonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            commonStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension ListOperationsCalendarDayCell: ListOperationsCalendarDayCellProtocol {
    func configureCell(shortDay: String, dayMonth: String, isCurrent: Bool, isSelected: Bool) {
        shortDayLabel.text = shortDay
        dayMonthLabel.text = dayMonth
        
        if isCurrent {
            dayMonthLabel.textColor = .white
            backgroundColor = UIColor(resource: .accentBlue)
        }
        
        if isSelected {
            setBorderColor(UIColor(resource: .accentBlue), width: 1)
        }
    }
}
