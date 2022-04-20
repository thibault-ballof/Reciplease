//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 09/04/2022.
//

import UIKit
import Alamofire

class DetailRecipeViewController: UIViewController {
    //MARK: - Variables
    var recipe: Recipe!
    
    //MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        label.text = recipe.label
        AF.request( recipe.image,method: .get).response{ response in
            
            switch response.result {
            case .success(let responseData):
                self.recipeImage.image = UIImage(data: responseData!)
                
            case .failure(let error):
                print("error--->",error)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getDirection(_ sender: Any) {
        if let url = URL(string: recipe.url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        saveFavoriteButton(name: recipe.label, image: recipe.image, ingredientLines: recipe.ingredientLines)
    }
    
    func saveFavoriteButton(name: String, image: String, ingredientLines: [String]) {
        let favoriteRecipe = FavoriteRecipes(context: CoreDataStack.sharedInstance.viewContext)
        favoriteRecipe.label = name
        favoriteRecipe.image = image
        favoriteRecipe.ingredientsLine = ingredientLines
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        
        do {
            try CoreDataStack.sharedInstance.viewContext.save()
        } catch {
            print("error")
        }
        
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
