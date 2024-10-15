//
//  BriefStatisticsView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import UIKit

final class BriefStatisticsView: BaseView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .secondaryText)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(commonStackView)
        
        commonStackView.addArrangedSubview(titleLabel)
        commonStackView.addArrangedSubview(subtitleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            commonStackView.topAnchor.constraint(equalTo: topAnchor),
            commonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            commonStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension BriefStatisticsView: BriefStatisticsViewProtocol {
    func configureView(title: String, subtitle: String) {
        titleLabel.text = title + ":"
        subtitleLabel.text = subtitle
    }
}
