//
//  BaseCollectionViewCell.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, ReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        backgroundColor = UIColor.clear
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {}
    
    func setupConstraints() {}
}
