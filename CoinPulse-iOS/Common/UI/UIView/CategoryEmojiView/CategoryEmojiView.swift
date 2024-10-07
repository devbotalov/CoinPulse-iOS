//
//  CategoryEmojiView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

final class CategoryEmojiView: BaseView {
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .primaryText)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius(frame.height / 2)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(emojiLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension CategoryEmojiView: CategoryEmojiViewProtocol {
    func configureView(with emoji: String, color: UIColor?) {
        emojiLabel.text = emoji
        backgroundColor = color?.withAlphaComponent(0.5)
    }
}
