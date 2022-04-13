//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    //MARK: - Variables
    var recipes = [FavoriteRecipes]()
    var selectedRecipe = FavoriteRecipes()
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        guard let recipe = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else { return }
        
        recipes = recipe
        tableView.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassFavoriteData" {
            
            guard let FavoriteDetailRecipeVC = segue.destination as? DetailFavoriteViewController else { return }
            FavoriteDetailRecipeVC.recipes = selectedRecipe
            
        }
    
       
    }

}
