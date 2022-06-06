//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation
@testable import Reciplease

class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO  = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    
    class RecipeError: Error {}
    static let error = RecipeError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var incorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "BadRecipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let noData = "error".data(using: .utf8)!
}
