//
//  ServiceTest.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 07/06/2022.
//

import XCTest
import Alamofire
import UIKit
@testable import Reciplease

class ServiceTest: XCTestCase {
    private var recipeService: RecipeService!
    
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        recipeService = RecipeService(session: session)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        recipeService = nil
        
    }
    
    func testFetchRecipesShouldPostFailedCompletionIfError() {
        // Given
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.error
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetch(ingredient: [""]) { success, recipes  in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchRecipesShouldPostFailedCompletionIfIncorrectData() {
        // Given
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = FakeResponseData.incorrectData
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetch(ingredient: [""]) { success, recipes in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchRecipesShouldPostFailIfNoDataHaveResponseNoError() {
        // Given
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetch(ingredient: [""]) { success, recipes in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchRecipesShouldPostSuccessIfDataGoodResponseNoError() {
        // Given
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = FakeResponseData.recipeData
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetch(ingredient: ["chicken"]) { success, recipes in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    
    }
    
    func testFetchRecipesShouldGetCorrectData() {
        // Given
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = FakeResponseData.recipeData
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fetch(ingredient: ["chicken"]) { success, recipes in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            XCTAssertEqual(recipes?.hits[0].recipe.label, "Chicken Vesuvio")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
        
    func testFetchRecipesShouldGetFalseData() {
            // Given
            MockURLProtocol.loadingHandler = { request in
                let data: Data? = nil
                let response: HTTPURLResponse = FakeResponseData.responseOK
                let error: Error? = nil
                return (response, data, error)
            }
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            recipeService.fetch(ingredient: ["chicken"]) { success, recipes in
                // Then
                XCTAssertFalse(success)
                XCTAssertNil(recipes)
                XCTAssertNotEqual(recipes?.hits[0].recipe.label, "Chicken Vesuvio")
                
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 10)
            
        
        }
    
    
    // MARK: - Test fetchImg
    
    func testFetchImageShouldGetCorrectData() {
        // Given
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = FakeResponseData.imageData
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            return (response, data, error)
            
        }
        let image = UIImageView()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fecthImg(url: "", image: image)
        
            
        XCTAssertNotNil(image)
        
            
            expectation.fulfill()
        
        
        wait(for: [expectation], timeout: 10)
    }
   
    func testFetchImageShouldGetDefaultImage() {
        // Given
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = FakeResponseData.incorrectData
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = Alamofire.AFError.invalidURL(url: "badurl")
            return (response, data, error)
            
        }
        let image = UIImageView()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.fecthImg(url: "", image: image)
        if let img = image.image {
            XCTAssertNotNil(img)
            XCTAssertEqual(img.pngData(), UIImage(named: "image")?.pngData())
        }
            
       
            
            expectation.fulfill()
        
        
        wait(for: [expectation], timeout: 10)
    }
    
    // MARK: -  TEST CREATE URL
    func testCreateURLShouldBeCorrectWithIngredient() {
        //Given
        let recipeURL =  RecipeService.shared.createURL(ingredient: ["chicken"])
        
    XCTAssertEqual("https://api.edamam.com/search?q=chicken&app_id=1dc84b29&app_key=fc27995dc80de75197992b58c55f8253", "\(recipeURL)")
        
    }
    
    func testCreateURLShouldBeCorrectWithMultipleIngredient() {
        //Given
        let recipeURL =  RecipeService.shared.createURL(ingredient: ["chicken","tomato"])
        
    XCTAssertEqual("https://api.edamam.com/search?q=chicken,tomato&app_id=1dc84b29&app_key=fc27995dc80de75197992b58c55f8253", "\(recipeURL)")
        
    }
    
    func testCreateURLShouldBeIncorrectWithNoIngredient() {
        //Given
        let recipeURL =  RecipeService.shared.createURL(ingredient: [])
        
    XCTAssertEqual("https://api.edamam.com/search?q=&app_id=1dc84b29&app_key=fc27995dc80de75197992b58c55f8253", "\(recipeURL)")
        
    }
}
