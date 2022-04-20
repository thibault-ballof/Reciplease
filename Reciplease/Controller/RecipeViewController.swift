//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit
import CoreData
import Alamofire

class RecipeViewController: UIViewController {
    
    //MARK: - Variables
    var recipes: RecipeData = RecipeData(hits: [Hits]())
    var ingredients: [String] = []
    var selectedRecipe: Recipe!
    private let recipeService = Service()
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecipes()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func getRecipes() {
        recipeService.fetch(ingredient: ingredients) { (sucess, recipe) in
            if sucess {
                self.recipes = recipe!
                self.tableView.reloadData()       
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassData" {
            print(selectedRecipe.label)
            guard let DetailRecipeVC = segue.destination as? DetailRecipeViewController else { return }
            DetailRecipeVC.recipe = selectedRecipe
            
        }
        
        
    }
    
}

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
