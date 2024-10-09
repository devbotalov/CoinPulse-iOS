//
//  CoreDataManagerProtocol.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func fetchOperations(with predicate: NSPredicate?) throws -> [OperationEntity]
    func fetchCategories(with predicate: NSPredicate?) throws -> [CategoryEntity]
}
