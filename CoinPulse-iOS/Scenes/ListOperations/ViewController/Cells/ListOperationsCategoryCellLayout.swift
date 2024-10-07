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
            heightDimension: .absolute(60)
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
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16, leading: 32, bottom: 32, trailing: 32
        )
        
        let sizeHeader = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(60)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sizeHeader,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let background = NSCollectionLayoutDecorationItem.background(
            elementKind: RoundedBackgroundView.kindView
        )
        background.contentInsets = NSDirectionalEdgeInsets(
            top: 20, leading: 20, bottom: 20, trailing: 20
        )
        
        section.interGroupSpacing = 10
        section.boundarySupplementaryItems = [header]
        section.decorationItems = [background]
        
        return section
    }
}
