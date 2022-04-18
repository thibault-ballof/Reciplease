//
//  Service.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import Foundation
import Alamofire

class Service {
    
    
    //static var shared = Service()
    //private init() {}
    //var task: URLSessionDataTask?
    
    
    
    // MARK: - INJECT DEPENDENCY
    //private var session = URLSession(configuration: .default)
    //init(session: URLSession) {
    // self.session = session
    //}
    // MARK: - API CONFIGURATION
    /* func getRecipes(ingredient: [String], callback: @escaping (Bool, RecipeData?) -> Void)  {
     
     
     var request = createURL(ingredient: ingredient)
     request.httpMethod = "GET"
     task = session.dataTask(with: request) { (data, response, error) in
     DispatchQueue.main.async {
     guard let data = data, error == nil else {
     callback(false, nil)
     return
     }
     guard  let response = response as? HTTPURLResponse, response.statusCode == 200 else {
     callback(false, nil)
     return
     }
     guard let responseJSON = try? JSONDecoder().decode(RecipeData.self, from: data) else {
     callback(false, nil)
     return
     }
     
     callback(true, responseJSON)
     }
     }
     
     task?.resume()
     }*/
    
    func createURL(ingredient: [String]) -> URLRequest{
        var ingredientsParams: String = ""
        for i in 0 ..< ingredient.count {
            ingredientsParams += ingredient[i]
            if i+1 < ingredient.count {
                ingredientsParams += ","
            }
        }
        let escapedString = ingredientsParams.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return URLRequest(url: URL(string: "https://api.edamam.com/search?q=" + escapedString + "&app_id=1dc84b29&app_key=fc27995dc80de75197992b58c55f8253")!)
    }
    
    
    func fetch(ingredient: [String], callback: @escaping (Bool, RecipeData?) -> Void)  {
        
        
        var makeUrl = createURL(ingredient: ingredient)
        let request = AF.request(makeUrl)
        
        request.response { (data) in
            
            guard data.response?.statusCode == 200 else {
                callback(false, nil)
                return
            }
            guard  let data = data.data else {
                callback(false, nil)
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(RecipeData.self, from: data) else {
                callback(false, nil)
                return
            }
            
            callback(true, responseJSON)
            
        }
        
    }
    
}

