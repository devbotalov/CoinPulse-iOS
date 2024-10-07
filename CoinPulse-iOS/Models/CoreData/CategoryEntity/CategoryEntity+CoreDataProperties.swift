//
//  CategoryEntity+CoreDataProperties.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var color: NSObject?
    @NSManaged public var emoji: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var operations: NSSet?

}

// MARK: Generated accessors for operations
extension CategoryEntity {

    @objc(addOperationsObject:)
    @NSManaged public func addToOperations(_ value: OperationEntity)

    @objc(removeOperationsObject:)
    @NSManaged public func removeFromOperations(_ value: OperationEntity)

    @objc(addOperations:)
    @NSManaged public func addToOperations(_ values: NSSet)

    @objc(removeOperations:)
    @NSManaged public func removeFromOperations(_ values: NSSet)

}

extension CategoryEntity : Identifiable {

}
