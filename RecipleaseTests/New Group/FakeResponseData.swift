//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 16/05/2022.
//

import Foundation	

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
        static let incorrectData = "error".data(using: .utf8)!
}
