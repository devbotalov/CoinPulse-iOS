//
//  OperationEntity+CoreDataProperties.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//
//

import Foundation
import CoreData


extension OperationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OperationEntity> {
        return NSFetchRequest<OperationEntity>(entityName: "OperationEntity")
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var category: CategoryEntity?

}

extension OperationEntity : Identifiable {

}