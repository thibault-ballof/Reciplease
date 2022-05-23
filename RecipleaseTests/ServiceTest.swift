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
    
    
    var service: Service!
    override func setUp() {
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = FakeResponseData.incorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        service = Service(session: urlSession)
    }
    
    
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        let service = Service(session: urlSession)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        service.fetch(ingredient: [""]) { (success, recipe) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
        
    }
            
}
