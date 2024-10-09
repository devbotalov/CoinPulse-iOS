//
//  UICollectionView+Register.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

extension UICollectionView {
    final func registerCell<Cell: BaseCollectionViewCell>(_: Cell.Type) where Cell: BaseCollectionViewCell {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseID)
    }
    
    final  func dequeueReusableCell<Cell: BaseCollectionViewCell>(for indexPath: IndexPath) -> Cell where Cell: BaseCollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with ID: \(Cell.reuseID)")
        }
        
        return cell
    }
    
    final func registerHeader<View: BaseCollectionReusableView>(_: View.Type) where View: BaseCollectionReusableView {
        register(View.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: View.reuseID)
    }
    
    final func dequeueHeader<View: BaseCollectionReusableView>(for indexPath: IndexPath) -> View where View: BaseCollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: View.reuseID,
            for: indexPath
        ) as? View else { fatalError("Could not dequeue header with ID: \(View.reuseID)") }
        
        return view
    }
    
    final func registerFooter<View: BaseCollectionReusableView>(_: View.Type) where View: BaseCollectionReusableView {
        register(View.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: View.reuseID)
    }
    
    final func dequeueFooter<View: BaseCollectionReusableView>(for indexPath: IndexPath) -> View where View: BaseCollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: View.reuseID,
            for: indexPath
        ) as? View else { fatalError("Could not dequeue header with ID: \(View.reuseID)") }
        
        return view
    }
    
    final func registerBackground<View: BaseCollectionReusableView>(_: View.Type, forDecorationViewOfKind: String) where View: BaseCollectionReusableView {
        collectionViewLayout.register(View.self, forDecorationViewOfKind: forDecorationViewOfKind)
    }
}
