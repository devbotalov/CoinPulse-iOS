//
//  OperationEntity+CreateEntity.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import CoreData

extension OperationEntity {
    static func create(context: NSManagedObjectContext, amount: Double, note: String? = nil, type: String, category: CategoryEntity) -> OperationEntity {
        let operationEntity = OperationEntity(context: context)
        
        operationEntity.amount = amount
        operationEntity.date = Date.now
        operationEntity.note = note
        operationEntity.type = type
        operationEntity.category = category
        
        return operationEntity
    }
}
