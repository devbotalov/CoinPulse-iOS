//
//  CalendarHeaderReusableView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

final class CalendarHeaderReusableView: BaseCollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leftActionButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setImage(UIImage(resource: .leftArrow), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor(resource: .accentGray)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rightActionButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(UIImage(resource: .rightArrow), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor(resource: .accentGray)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private weak var delegate: CalendarHeaderReusableViewDelegate?
    
    override func setupReusableView() {
        super.setupReusableView()
        
        [leftActionButton, rightActionButton].forEach { button in
            button.addTarget(
                self,
                action: #selector(actionButtonDidTapped),
                for: .touchUpInside
            )
        }
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(titleLabel)
        addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(leftActionButton)
        buttonsStackView.addArrangedSubview(rightActionButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            
            buttonsStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            leftActionButton.widthAnchor.constraint(equalToConstant: 24),
            leftActionButton.heightAnchor.constraint(equalToConstant: 24),
            
            rightActionButton.widthAnchor.constraint(equalToConstant: 24),
            rightActionButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

extension CalendarHeaderReusableView: CalendarHeaderReusableViewProtocol {
    func configureView(with title: String, delegate: CalendarHeaderReusableViewDelegate?) {
        self.delegate = delegate
        titleLabel.text = title
    }
}

private extension CalendarHeaderReusableView {
    @objc func actionButtonDidTapped(_ sender: UIButton) {
        delegate?.actionButtonDidTapped(sender)
    }
}
