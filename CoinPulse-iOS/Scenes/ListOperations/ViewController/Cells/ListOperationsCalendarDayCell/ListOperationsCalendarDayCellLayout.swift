//
//  ListOperationsCalendarDayCellLayout.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

final class ListOperationsCalendarDayCellLayout {
    
    private init() {}
    
    static func layout(countDay: Int, width: CGFloat) -> NSCollectionLayoutSection {
        let widthWidthSpace = CGFloat(10 * (countDay - 1))
        let widthWithInsets: CGFloat = 72
        let widthSize = (width - widthWidthSpace  - widthWithInsets) / CGFloat(countDay)
        
        let sizeItem = NSCollectionLayoutSize(
            widthDimension: .absolute(CGFloat(widthSize)),
            heightDimension: .absolute(76)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: sizeItem
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: sizeItem,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(
            group: group
        )
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 12, leading: 36, bottom: 12, trailing: 36
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
            top: 20, leading: 20, bottom: 0, trailing: 20
        )
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.boundarySupplementaryItems = [header]
        section.decorationItems = [background]
        
        return section
    }
}
