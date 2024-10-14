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
        let request = NSFetchRequest<OperationEntity>(entityName: "OperationEntity")
        request.returnsObjectsAsFaults = false
        return request
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var note: String?
    @NSManaged public var type: String
    @NSManaged public var category: CategoryEntity

}

extension OperationEntity : Identifiable {

}
