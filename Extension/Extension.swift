//
//  Extention.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//
import UIKit
import Alamofire
//MARK: - SearchViewController

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = "\(ingredients[indexPath.row])"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
}


//MARK: - RecipeViewController

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {
            
            return UITableViewCell()
            
        }
        cell.totalTimeLabel.text = "\(recipes.hits[indexPath.row].recipe.totalTime)"
        cell.label.text = recipes.hits[indexPath.row].recipe.label
        var indregientsLine: String = ""
        for i in 0 ..< recipes.hits[indexPath.row].recipe.ingredientLines.count {
            indregientsLine += recipes.hits[indexPath.row].recipe.ingredientLines[i]
            cell.indregredientsListLabel.text = indregientsLine
        }
        
        
        AF.request( "\(recipes.hits[indexPath.row].recipe.image)",method: .get).response{ response in
            
            switch response.result {
            case .success(let responseData):
                cell.recipeImage.image = UIImage(data: responseData!)
                
            case .failure(let error):
                print("error--->",error)
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.hits.count
    }
    
    // Send data to DetailRecipeViewController
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        print("test")
        selectedRecipe = recipes.hits[indexPath.row].recipe
        performSegue(withIdentifier: "PassData", sender: self)
    }
}

//MARK: - FavoriteViewController

extension FavoriteViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {
            
            return UITableViewCell()
            
        }
        cell.favoriteIngredientsListLabel.text = recipes[indexPath.row].ingredientsLine?.joined(separator: ",")
        cell.labelFavorite.text = recipes[indexPath.row].label
        
        
        
        AF.request( recipes[indexPath.row].image!,method: .get).response{ response in
            
            switch response.result {
            case .success(let responseData):
                cell.favoriteRecipeImage.image = UIImage(data: responseData!)
                
            case .failure(let error):
                print("error--->",error)
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        selectedRecipe = recipes[indexPath.row]
        performSegue(withIdentifier: "PassFavoriteData", sender: self)
    }
    
    
}
//MARK: - DetailRecipeViewController
extension DetailRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailIngredientCell", for: indexPath)
        cell.textLabel?.text = "\(recipe.ingredientLines[indexPath.row])"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredientLines.count
    }
}
//MARK: - DetailFavoriteViewController
extension DetailFavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFavoriteCell", for: indexPath)
        cell.textLabel?.text = "\(recipes.ingredientsLine![indexPath.row])"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.ingredientsLine!.count
    }
}
