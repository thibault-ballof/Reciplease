//
//  ServiceTest.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 16/05/2022.
//

import XCTest
import Alamofire
@testable import Reciplease

class ServiceTest: XCTestCase {
    
    
    /*var service: Service!
    
    
    
    func testGetRecipeShouldPostFailCallbackIfNoData() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.af.default
                configuration.protocolClasses = [MockURLProtocol.self]
                let session = Session(configuration: configuration)
        let service = Service(session: session)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        service.fetch(ingredient: [""]) { (sucess, recipe) in
            //then
            XCTAssertFalse(sucess)
            XCTAssertNil(recipe)
            //XCTAssertEqual(FakeResponseData.responseKO?.statusCode, 500)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
        
    }
    
    
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data: Data? = FakeResponseData.correctData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.af.default
                configuration.protocolClasses = [MockURLProtocol.self]
                let session = Session(configuration: configuration)
        let service = Service(session: session)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        service.fetch(ingredient: [""]) { (sucess, recipe) in
            //then
            XCTAssertFalse(sucess)
            XCTAssertNil(recipe)
            //XCTAssertEqual(FakeResponseData.responseKO?.statusCode, 500)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
        
        
    }
    
     func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = FakeResponseData.correctData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        let service = Service(session: session)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        service.fetch(ingredient: [""]) { (sucess, recipe) in
            //then
            XCTAssertTrue(sucess)
            XCTAssertNotNil(recipe)
            //XCTAssertEqual(FakeResponseData.responseKO?.statusCode, 500)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
        
        
    }
}*/

    func testGetRecipeShouldPostFailCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: nil, result: .failure(.invalidURL(url: "")) )
                let session = FakeSession(fakeResponse: fakeResponse)
                let service = Service(session: session)
                let expectation = XCTestExpectation(description: "Wait for change")
            
            service.fetch(ingredient: [""]) { (sucess, recipe) in
                //then
                XCTAssertFalse(sucess)
                XCTAssertNil(recipe)
                //XCTAssertEqual(FakeResponseData.responseKO?.statusCode, 500)
                
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 30.0)
        
        }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.incorrectData, result: .failure(.invalidURL(url: "")) )
                let session = FakeSession(fakeResponse: fakeResponse)
                let service = Service(session: session)
                let expectation = XCTestExpectation(description: "Wait for change")
            
            service.fetch(ingredient: [""]) { (sucess, recipe) in
                //then
                XCTAssertFalse(sucess)
                XCTAssertNil(recipe)
                //XCTAssertEqual(FakeResponseData.responseKO?.statusCode, 500)
                
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 30.0)
        
        
    }
    
    func testGetRecipeShouldProvideResult() {
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, result: .success(FakeResponseData.fakeRecipeData))
                let session = FakeSession(fakeResponse: fakeResponse)
                let service = Service(session: session)
                let expectation = XCTestExpectation(description: "Wait for change")
        let url = URL(string: "http://Google.com")
        session.request(url: url!) { response in
            XCTAssertTrue(response.value?.hits.count == 0)
            XCTAssertTrue(response.response?.statusCode == 200)
        
            
                
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 30.0)
        
    }
    
    
    func testGetRecipeShouldNotProvideResult() {
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: nil, result: .failure(.invalidURL(url: "")) )
                let session = FakeSession(fakeResponse: fakeResponse)
                let service = Service(session: session)
                let expectation = XCTestExpectation(description: "Wait for change")
            
            service.fetch(ingredient: [""]) { (sucess, recipe) in
                //then
                XCTAssertFalse(sucess)
                XCTAssertNil(recipe)
                
                //XCTAssertEqual(FakeResponseData.responseKO?.statusCode, 500)
                
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 30.0)
        
        }
    
}

