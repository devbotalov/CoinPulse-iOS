//
//  ModelForSection.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import Foundation

enum ModelForSection: Hashable {
    case calendar(Int)
    case operations(OperationEntity)
    case categories(CategoryEntity)
}
