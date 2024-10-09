//
//  AllOperationsFooterReusableView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

final class AllOperationsFooterReusableView: BaseCollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .accentGray)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(resource: .accentGray)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private weak var delegate: AllOperationsFooterReusableViewDelegate?
    
    override func setupReusableView() {
        super.setupReusableView()
        
        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(viewDidTapped)
        )
        addGestureRecognizer(tapGesture)
        
        isUserInteractionEnabled = true
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(titleLabel)
        addSubview(arrowImageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            arrowImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

extension AllOperationsFooterReusableView: AllOperationsFooterReusableViewProtocol {
    func configureView(isCollapsed: Bool, delegate: AllOperationsFooterReusableViewDelegate?) {
        self.delegate = delegate
        
        titleLabel.text = isCollapsed ? "Show all" : "Collapse"
        arrowImageView.shakeAnimation()
    }
}

private extension AllOperationsFooterReusableView {
    @objc func viewDidTapped() {
        delegate?.viewDidTapped()
    }
}
