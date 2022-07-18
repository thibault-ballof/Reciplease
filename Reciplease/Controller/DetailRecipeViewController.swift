//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 09/04/2022.
//

import UIKit
import Alamofire
import CoreData

class DetailRecipeViewController: UIViewController {
    // MARK: - Properties
    var recipe: Recipe!
    var isActive: Bool = false
    
    //MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var NavigationBar: UINavigationItem!
    
    @IBOutlet weak var buttonFavorite: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        label.text = recipe.label
        yieldLabel.text = "\(recipe.yield)"
        timeLabel.text = "\(recipe.totalTime)"
      
        RecipeService.shared.fecthImg(url: recipe.image, image: self.recipeImage)
    }
    
    @IBAction func getDirection(_ sender: Any) {
        if let url = URL(string: recipe.url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func favoriteButton(_ sender: Any) {
        saveFavoriteButton(name: recipe.label, image: recipe.image, ingredientLines: recipe.ingredientLines, time: recipe.totalTime, yield: recipe.yield, url: recipe.url, button: buttonFavorite)
    }
    
    func saveFavoriteButton(name: String, image: String, ingredientLines: [String], time: Int, yield: Int, url: String, button: UIBarButtonItem) {
        let favoriteRecipe = FavoriteRecipes(context: CoreDataStack.sharedInstance.viewContext)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipes")
        let predicate = NSPredicate(format: "label == %@", name)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let count = try CoreDataStack.sharedInstance.viewContext.count(for: request)
            
            if(count == 0){
                
                
                favoriteRecipe.label = name
                favoriteRecipe.image = image
                favoriteRecipe.ingredientsLine = ingredientLines
                favoriteRecipe.yield = "\(yield)"
                favoriteRecipe.time = "\(time)"
                favoriteRecipe.url = url
                do {
                    try CoreDataStack.sharedInstance.viewContext.save()
                } catch {
                    print("error")
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
            } else {
                button.tintColor = .none
                showAlertAlreadyFavorite()
                
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }

    private func showAlertAlreadyFavorite() {
        let alert = UIAlertController(title: "Already in favorite", message: "The recipe is already in your favorites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}


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

