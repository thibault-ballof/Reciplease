//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit
import CoreData

class RecipeViewController: UIViewController {
    
    //MARK: - Variables
    var recipes: RecipeData = RecipeData(hits: [Hits]())
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
        Service.shared.getRecipes(ingredient: ingredients) { (sucess, recipe) in
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
