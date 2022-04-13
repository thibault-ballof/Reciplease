//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 09/04/2022.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    //MARK: - Variables
    var recipe: Recipe!
    
    //MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        label.text = recipe.label
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func favoriteButton(_ sender: Any) {
        saveFavoriteButton(name: recipe.label, image: recipe.image, ingredientLines: recipe.ingredientLines)
    }
    
    func saveFavoriteButton(name: String, image: String, ingredientLines: [String]) {
        let favoriteRecipe = FavoriteRecipes(context: CoreDataStack.sharedInstance.viewContext)
        favoriteRecipe.label = name
        favoriteRecipe.image = image
        favoriteRecipe.ingredientsLine = ingredientLines
        do {
            try CoreDataStack.sharedInstance.viewContext.save()
        } catch {
            print("error")
        }
    }

}
