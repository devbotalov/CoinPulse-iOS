//
//  ListOperationsCalendarDayCell.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

final class ListOperationsCalendarDayCell: BaseCollectionViewCell {
    
    private let titleDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .accentLightGray)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberDayLabel: UILabel = {
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
        
        commonStackView.addArrangedSubview(titleDayLabel)
        commonStackView.addArrangedSubview(numberDayLabel)
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
    func configureCell(day: CalendarDay?) {
        guard let day else { return }
        
        titleDayLabel.text = day.title
        numberDayLabel.text = day.number
        
        if day.isCurrent {
            numberDayLabel.textColor = .white
            backgroundColor = UIColor(resource: .accentBlue)
        } else {
            numberDayLabel.textColor = UIColor(resource: .primaryText)
            backgroundColor = UIColor(resource: .secondaryBackground)
        }
        
        if day.isSelected {
            setBorderColor(UIColor(resource: .accentBlue), width: 1)
        } else {
            setBorderColor(UIColor(resource: .secondaryBackground), width: 1)
        }
    }
}
