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
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        tableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassFavoriteData" {
            
            guard let FavoriteDetailRecipeVC = segue.destination as? DetailFavoriteViewController else { return }
            FavoriteDetailRecipeVC.recipes = selectedRecipe
            
        }
    
       
    }

    @objc func refresh() {
        tableView.reloadData()
    }
}
