//
//  MockCoreData.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 16/05/2022.
//



@testable import Reciplease
import Foundation
import CoreData

class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        
        let container = NSPersistentContainer(name: "Reciplease")
        
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        
        persistentContainer = container
    }
}


