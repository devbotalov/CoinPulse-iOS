//
//  BaseView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {}
    
    func setupConstraints() {}
}
