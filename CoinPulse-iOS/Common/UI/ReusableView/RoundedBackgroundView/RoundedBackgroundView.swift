//
//  RoundedBackgroundView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 08.10.2024.
//

import UIKit

class RoundedBackgroundView: BaseCollectionReusableView {

    static let kindView = "roundedBackgroundView"
    
    private let backgroundView: BaseView = {
        let view = BaseView()
        view.backgroundColor = UIColor(resource: .secondaryBackground)
        view.setCornerRadius(16)
        return view
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(backgroundView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
