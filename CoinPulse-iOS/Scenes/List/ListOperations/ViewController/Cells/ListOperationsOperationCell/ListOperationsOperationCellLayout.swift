//
//  ListOperationsOperationCellLayout.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

final class ListOperationsOperationCellLayout {
    
    private init() {}
    
    static func layout(width: CGFloat) -> NSCollectionLayoutSection {
        let sizeItem = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(50)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: sizeItem
        )
        
        let sizeGroup = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: sizeItem.heightDimension
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: sizeGroup,
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(
            group: group
        )
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 12, leading: 32, bottom: 12, trailing: 32
        )
        
        let background = NSCollectionLayoutDecorationItem.background(
            elementKind: BottomRoundedBackgroundView.kindView
        )
        
        background.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 20, bottom: 0, trailing: 20
        )
        
        let sizeHeader = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(36)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sizeHeader,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let sizeFooter = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(52)
        )
        
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sizeFooter,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        section.interGroupSpacing = 10
        section.decorationItems = [background]
        section.boundarySupplementaryItems = [header, footer]
        
        return section
    }
}
