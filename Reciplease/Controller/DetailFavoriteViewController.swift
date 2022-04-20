//
//  DetailFavoriteViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 13/04/2022.
//

import UIKit

class DetailFavoriteViewController: UIViewController {
    //MARK: - Variables
    var recipes = FavoriteRecipes()
    var countIngredientsList = 0
    var isFavorite = true
    
    //MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countIngredientsList =  recipes.ingredientsLine!.count
        // Do any additional setup after loading the view.    
    }
    
    @IBAction func removeFavoriteButton(_ sender: UIButton) {
        
            CoreDataStack.sharedInstance.viewContext.delete(recipes)
            try? CoreDataStack.sharedInstance.viewContext.save()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
}



extension DetailFavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFavoriteCell", for: indexPath)
        cell.textLabel?.text = "\(recipes.ingredientsLine![indexPath.row])"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.ingredientsLine!.count
    }
}
