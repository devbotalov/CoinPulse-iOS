//
//  CoreDataManager.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation
import CoreData

final class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared: CoreDataManagerProtocol = CoreDataManager()
    
    private var persistentContainer: NSPersistentContainer?
    private var context: NSManagedObjectContext?
    
    private init() {
        setupPersistentContainer()
        setupManagedObjectContext()
        
        // FIXME: Fixed after
        guard let context else { return }
        
        //        let category = CategoryEntity.create(
        //            context: context,
        //            emoji: "🛍️",
        //            title: "Shopping",
        //            type: OperationType.expense.rawValue,
        //            operations: []
        //        )
        
        //        let fetchCategory = CategoryEntity.fetchRequest()
        //        let categories = try! context.fetch(fetchCategory)
        //
        //        let shop = categories.first(where: { $0.title == "Shopping" })!
        //
        //        shop.operations = [
        //            OperationEntity.create(
        //                context: context,
        //                amount: 1000,
        //                note: "Note",
        //                type: OperationType.expense.rawValue,
        //                category: shop
        //            )
        //        ]
        //
        //        try? saveContext()
    }
}

extension CoreDataManager {
    func fetchOperations(with predicate: NSPredicate?) throws -> [OperationEntity] {
        guard let context else { return [] }
        let fetchRequest = OperationEntity.fetchRequest()
        fetchRequest.predicate = predicate
        return try context.fetch(fetchRequest)
    }
    
    func fetchCategories(with predicate: NSPredicate?) throws -> [CategoryEntity] {
        guard let context else { return [] }
        let fetchRequest = CategoryEntity.fetchRequest()
        fetchRequest.predicate = predicate
        let categories = try context.fetch(fetchRequest)
        categories.forEach { category in
            category.willAccessValue(forKey: "operations")
        }
        
        return categories
    }
}

private extension CoreDataManager {
    func setupPersistentContainer() {
        persistentContainer = NSPersistentContainer(name: "PersistentContainer")
        
        persistentContainer?.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func setupManagedObjectContext() {
        context = persistentContainer?.viewContext
    }
    
    func saveContext() throws {
        if context?.hasChanges ?? false {
            try? context?.save()
        }
    }
}
