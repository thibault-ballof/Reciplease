//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation
@testable import Reciplease

class FakeResponseData {
    //MARK: - Data
    static var recipeData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: ".json")!
        return try! Data(contentsOf: url)
    }
    
    static var noRecipeData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "BadRecipe", withExtension: ".json")!
        return try! Data(contentsOf: url)
    }
    
    static var imageData: Data? {
        let bundle = Bundle.main
        let url = bundle.url(forResource: "image", withExtension: ".png")!
        return try! Data(contentsOf: url)
    }
    
    static let incorrectData = "erreur".data(using: .utf8)
    
    //MARK: - Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    //MARK: - Error
    class FakeError: Error {}
    static let error = FakeError()
}
