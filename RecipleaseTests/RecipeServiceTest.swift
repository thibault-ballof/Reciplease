//
//  ServiceTest.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 07/06/2022.
//

import XCTest
import Alamofire
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
   
}
