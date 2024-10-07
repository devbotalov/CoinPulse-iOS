//
//  BaseCollectionReusableView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionReusableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionReusableView() {
        backgroundColor = UIColor.clear
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {}
    
    func setupConstraints() {}
}
