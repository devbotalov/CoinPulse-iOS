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
    
    private let expenseDotView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .accentRed)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let incomeDotView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .accentGreen)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let dotsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func setupCell() {
        super.setupCell()
        setCornerRadius(12)
        expenseDotView.setCornerRadius(3)
        incomeDotView.setCornerRadius(3)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(commonStackView)
        addSubview(dotsStackView)
        
        commonStackView.addArrangedSubview(titleDayLabel)
        commonStackView.addArrangedSubview(numberDayLabel)
        dotsStackView.addArrangedSubview(expenseDotView)
        dotsStackView.addArrangedSubview(incomeDotView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            commonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            commonStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dotsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            dotsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            expenseDotView.widthAnchor.constraint(equalToConstant: 6),
            expenseDotView.heightAnchor.constraint(equalToConstant: 6),
            incomeDotView.widthAnchor.constraint(equalToConstant: 6),
            incomeDotView.heightAnchor.constraint(equalToConstant: 6),
        ])
    }
}

extension ListOperationsCalendarDayCell: ListOperationsCalendarDayCellProtocol {
    func configureCell(day: CalendarDay?) {
        guard let day else { return }
        
        titleDayLabel.text = day.title
        numberDayLabel.text = day.number
        
        expenseDotView.isHidden = true
        incomeDotView.isHidden = true
        
        // FIXME: Fix after brain
        /*
        switch (day.isExpense, day.isIncome) {
            case (true, true):
                expenseDotView.isHidden = false
                incomeDotView.isHidden = false
            case (true, false):
                expenseDotView.isHidden = false
                incomeDotView.isHidden = true
            case (false, true):
                expenseDotView.isHidden = true
                incomeDotView.isHidden = false
            case (false, false):
                expenseDotView.isHidden = true
                incomeDotView.isHidden = true
        }
         */
        
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
