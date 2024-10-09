//
//  TopRoundedBackgroundView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

class TopRoundedBackgroundView: BaseCollectionReusableView {

    static let kindView = "topRoundedBackgroundView"
    
    private let backgroundView: BaseView = {
        let view = BaseView()
        view.backgroundColor = UIColor(resource: .secondaryBackground)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.setCornerRadiusForSpecificCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
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
