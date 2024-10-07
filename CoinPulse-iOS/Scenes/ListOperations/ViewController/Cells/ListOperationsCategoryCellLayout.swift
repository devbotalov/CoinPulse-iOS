//
//  ListOperationsCategoriesCellLayout.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

final class ListOperationsCategoryCellLayout {
    
    private init() {}
    
    static func layout() -> NSCollectionLayoutSection {
        let sizeItem = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: sizeItem
        )
        
        let sizeGroup = NSCollectionLayoutSize(
            widthDimension: item.layoutSize.widthDimension,
            heightDimension: item.layoutSize.heightDimension
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: sizeGroup,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(
            group: group
        )
        
        return section
    }
}
