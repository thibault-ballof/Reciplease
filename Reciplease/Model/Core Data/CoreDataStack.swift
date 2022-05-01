//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Thibault Ballof on 09/04/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Public
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    // MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Private

    private init() {}
    
     lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Reciplease")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()
}
