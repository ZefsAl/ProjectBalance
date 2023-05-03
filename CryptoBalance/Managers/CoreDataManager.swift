//
//  CoreDataManager.swift
//  CryptoBalance
//
//  Created by Serj on 05.02.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    // Context
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    // Описание сущности
    func entityName(name: String) -> NSEntityDescription {
        guard let returnVal = NSEntityDescription.entity(forEntityName: name, in: context) else { return NSEntityDescription() }
        return returnVal
    }
    
// MARK: CoreData
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "DataStorage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
// MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
