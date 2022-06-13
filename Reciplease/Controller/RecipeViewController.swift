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
    
    // MARK: - Properties
    var recipes = [Hits]()
    var ingredients: [String] = []
    var selectedRecipe: Recipe!
    
    
    
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipes()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func getRecipes() {
        RecipeService.shared.fetch(ingredient: ingredients) { (sucess, recipe) in
            if sucess {
                guard let recipes = recipe else { return }
                self.recipes = recipes.hits
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
        cell.totalTimeLabel.text = "\(recipes[indexPath.row].recipe.totalTime)"
        cell.label.text = recipes[indexPath.row].recipe.label
        cell.yield.text = "\(recipes[indexPath.row].recipe.yield)"
        var indregientsLine: String = ""
        for i in 0 ..< recipes[indexPath.row].recipe.ingredientLines.count {
            indregientsLine += recipes[indexPath.row].recipe.ingredientLines[i]
            cell.indregredientsListLabel.text = indregientsLine
        }
        
        RecipeService.shared.fecthImg(url: "\(recipes[indexPath.row].recipe.image)", image: cell.recipeImage)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    // Send data to DetailRecipeViewController
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        selectedRecipe = recipes[indexPath.row].recipe
        performSegue(withIdentifier: "PassData", sender: self)
    }
}
