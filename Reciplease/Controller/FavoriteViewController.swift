//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit
import CoreData
import Alamofire

class FavoriteViewController: UIViewController {
    // MARK: - Properties
    var recipes = [FavoriteRecipes]()
    var selectedRecipe = FavoriteRecipes()
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        self.fetchFavorites()
        
        if recipes.isEmpty {
            let alert = UIAlertController(title: "No Favorites", message: "You must add favorite before continuing. Touch heart to add favorite", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassFavoriteData" {
            
            guard let FavoriteDetailRecipeVC = segue.destination as? DetailFavoriteViewController else { return }
            FavoriteDetailRecipeVC.recipes = selectedRecipe
            
        }
    }
    
    @objc func refresh() {
        self.fetchFavorites()
        tableView.reloadData()
    }
    
    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        let predicate = NSPredicate(format: "label != %@", "")
        request.predicate = predicate
        guard let recipe = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else { return }
        recipes = recipe
    }
}


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
        cell.favoriteYield.text = recipes[indexPath.row].yield
        cell.favoritetotalTimeLabel.text = recipes[indexPath.row].time
        
        if let image = recipes[indexPath.row].image {
            AF.request( image,method: .get).response{ response in
                
                switch response.result {
                case .success(let responseData):
                    cell.favoriteRecipeImage.image = UIImage(data: responseData!)
                    
                case .failure(let error):
                    print("error--->",error)
                }
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
