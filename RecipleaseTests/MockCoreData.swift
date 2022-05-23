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

    // 1
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType

    // 2
      let container = NSPersistentContainer(name: "Reciplease")
    // 3
    container.persistentStoreDescriptions = [persistentStoreDescription]

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    // 4
    persistentContainer = container
  }
}


