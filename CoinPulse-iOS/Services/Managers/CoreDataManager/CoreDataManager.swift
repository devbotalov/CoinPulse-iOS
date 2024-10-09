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
    }
}

extension CoreDataManager {
    func fetchCategories() throws -> [CategoryEntity] {
        guard let context else { return [] }
        let fetchRequest = CategoryEntity.fetchRequest()
        return try context.fetch(fetchRequest)
    }
    
    func fetchOperations() throws -> [OperationEntity] {
        guard let context else { return [] }
        let fetchRequest = OperationEntity.fetchRequest()
        return try context.fetch(fetchRequest)
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
