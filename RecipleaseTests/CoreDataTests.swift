//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 16/05/2022.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataTests: XCTestCase {
    var favoriteRecipe: FavoriteRecipes!
    var coreDataStack: TestCoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        favoriteRecipe = FavoriteRecipes(context: coreDataStack.viewContext)
        
    }
    override func tearDown() {
        super.tearDown()
        favoriteRecipe = nil
        coreDataStack = nil
    }
    func testAddingFavorite() {
        // given
        favoriteRecipe.label = "test"
        favoriteRecipe.ingredientsLine = [""]
        favoriteRecipe.image = "http://google.fr"
        //when
        try! coreDataStack.viewContext.save()
        //then
        XCTAssertEqual(favoriteRecipe.label, "test")
        XCTAssertEqual(favoriteRecipe.ingredientsLine, [""])
        XCTAssertEqual(favoriteRecipe.image, "http://google.fr")
        
        coreDataStack.viewContext.delete(favoriteRecipe)
        try! coreDataStack.viewContext.save()
    }
    
    func testRemoveFavorite() {
        //given
        let recipe = Recipe(label: "String", image: "String", ingredientLines: ["String"], url: "String", totalTime: 0, yield: 0)
        favoriteRecipe.label = recipe.label
        favoriteRecipe.ingredientsLine = recipe.ingredientLines
        favoriteRecipe.image = recipe.image
        try? coreDataStack.viewContext.save()
        //when
        coreDataStack.viewContext.delete(favoriteRecipe)
        try? coreDataStack.viewContext.save()
        //then
        XCTAssertEqual(favoriteRecipe.label, nil)
    }
    
    func testAppendElementsInFavoriteWithAlreadyExistingRecipe() {
        //given
        let recipe = Recipe(label: "String", image: "String", ingredientLines: ["String"], url: "String", totalTime: 0, yield: 0)
        favoriteRecipe.label = recipe.label
        favoriteRecipe.ingredientsLine = recipe.ingredientLines
        favoriteRecipe.image = recipe.image
        try? coreDataStack.viewContext.save()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipes")
        let predicate = NSPredicate(format: "label == %@", "String")
        request.predicate = predicate
        request.fetchLimit = 1
        
        //When
        favoriteRecipe.label = recipe.label
        favoriteRecipe.ingredientsLine = recipe.ingredientLines
        favoriteRecipe.image = recipe.image
        try? coreDataStack.viewContext.save()
        let count = try! coreDataStack.viewContext.count(for: request)
        //then
        XCTAssertEqual(count, 1)
        
        
        coreDataStack.viewContext.delete(favoriteRecipe)
        try! coreDataStack.viewContext.save()
    }
}
