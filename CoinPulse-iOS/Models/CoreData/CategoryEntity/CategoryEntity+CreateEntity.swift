//
//  CategoryEntity+CreateEntity.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import CoreData

extension CategoryEntity {
    static func create(context: NSManagedObjectContext, emoji: String, title: String, type: String, operations: NSSet) -> CategoryEntity {
        let categoryEntity = CategoryEntity(context: context)
        let color = emoji.emojiColor()?.hexString ?? ""
        
        categoryEntity.color = color
        categoryEntity.emoji = emoji
        categoryEntity.title = title
        categoryEntity.type = type
        categoryEntity.operations = operations
        
        return categoryEntity
    }
}
