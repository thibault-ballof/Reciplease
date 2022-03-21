//
//  RecipeData.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import Foundation

struct RecipeData: Codable {
    
    let hits: [Hits]
    
    struct Hits: Codable {
        let recipe: Recipe
        
        struct Recipe: Codable {

            let label: String
            let image: String
            let ingredientLines: [String]
          
        }
        
    }
}
