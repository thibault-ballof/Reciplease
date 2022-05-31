//
//  Service.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import Foundation
import Alamofire

class Service {
    
    
    // MARK: - Singleton
    static var shared = Service()
    
    
    // MARK: - Init
    private let session: SessionProtocol
    init(session: SessionProtocol = RecipeSession()) {
            self.session = session
        }
    
    
    func createURL(ingredient: [String]) -> URL{
        var ingredientsParams: String = ""
        for i in 0 ..< ingredient.count {
            ingredientsParams += ingredient[i]
            if i+1 < ingredient.count {
                ingredientsParams += ","
            }
        }
        let escapedString = ingredientsParams.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return  URL(string: "https://api.edamam.com/search?q=" + escapedString + "&app_id=1dc84b29&app_key=fc27995dc80de75197992b58c55f8253")!
    }
    
    
    func fetch(ingredient: [String], callback: @escaping (Bool, RecipeData?) -> Void) {
        
        
        let makeUrl = createURL(ingredient: ingredient)
       
        
        session.request(url: makeUrl) { (data) in
            
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

