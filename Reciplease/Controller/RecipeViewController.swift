//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit


class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var recipes: RecipeData = RecipeData(hits: [Hits]())
    var ingredients: [String] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecipes()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
  

    func getRecipes() {
        Service.shared.getTranslate(ingredient: ingredients) { (sucess, recipe) in
            if sucess {
                self.recipes = recipe!
                self.tableView.reloadData()
               
            }
            
        }
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {

           return UITableViewCell()

        }
        cell.label.text = recipes.hits[indexPath.row].recipe.label
         
            return cell
        }
        
       func numberOfSections(in tableView: UITableView) -> Int {
          return 1
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return recipes.hits.count
       }
}