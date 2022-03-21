//
//  WelcomeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    var ingredients: [String] = []
    @IBAction func addButton(_ sender: Any) {
        if let ingredientTextField = ingredientTextField.text {
            ingredients.append(ingredientTextField)
            tableView.reloadData()
        }
    }
    
   
    @IBOutlet weak var ingredientTextField: UITextField!
    
    @IBAction func clearButton(_ sender: Any) {
        ingredients = []
        tableView.reloadData()
    }
}


    

