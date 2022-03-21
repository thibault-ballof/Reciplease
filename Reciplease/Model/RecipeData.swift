//
//  RecipeData.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import Foundation
struct RecipeData: Codable {
    let hits : [Hits]
    
    struct Hits: Codable {
        let recipe : Recipe
        
        struct Recipe : Codable {
            let uri : String
            let label : String
            let image : String
            let source : String
            let url : String
            let shareAs : String
            let ingredientLines : [String]
            let ingredients : [Ingredients]
     
            
            struct Ingredients : Codable {
                let text : String
                let quantity : Double
                let measure : String
                let food : String
                let weight : Double
                let foodCategory : String
                let foodId : String
                let image : String
            }
        }
        
    }
}
