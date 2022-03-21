//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit
class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
}

class RecipeViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    func updateView(from data: Recipe, label: UILabel) {
        label.text = data.label
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {

           return UITableViewCell()

        }
            Service.shared.getTranslate(ingredient: "") { (sucess, recipe) in
                if sucess {
                    self.updateView(from: recipe!, label: cell.label)
                }
                
            }
         
            return cell
        }
        
       func numberOfSections(in tableView: UITableView) -> Int {
          return 1
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1
       }
}
