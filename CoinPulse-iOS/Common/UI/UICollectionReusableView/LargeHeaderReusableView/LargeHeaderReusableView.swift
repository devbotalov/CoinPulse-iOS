//
//  LargeHeaderReusableView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

final class LargeHeaderReusableView: BaseCollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(UIColor(resource: .accentBlue), for: .normal)
        button.setTitleColor(UIColor(resource: .accentGray), for: .disabled)
        button.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private weak var delegate: LargeHeaderReusableViewDelegate?
    
    override func setupReusableView() {
        super.setupReusableView()

        actionButton.addTarget(
            self,
            action: #selector(actionButtonDidTapped),
            for: .touchUpInside
        )
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor),
            
            actionButton.topAnchor.constraint(equalTo: topAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension LargeHeaderReusableView: LargeHeaderReusableViewProtocol {
    func configureView(with title: String, titleButton: String?, delegate: LargeHeaderReusableViewDelegate?) {
        self.delegate = delegate
        titleLabel.text = title
        actionButton.setTitle(titleButton, for: .normal)
        actionButton.isHidden = titleButton != nil ? false : true
    }
}

private extension LargeHeaderReusableView {
    @objc func actionButtonDidTapped() {
        delegate?.actionButtonDidTapped()
    }
}
