//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 09/04/2022.
//

import UIKit

class DetailRecipeViewController: UIViewController, UITableViewDataSource  {
    var recipe: Recipe!
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
