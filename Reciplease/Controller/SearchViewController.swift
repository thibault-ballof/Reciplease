//
//  WelcomeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - Variables
    var ingredients: [String] = []
    
    //MARK: -Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
        if let ingredientTextField = ingredientTextField.text {
            ingredients.append(ingredientTextField)
            tableView.reloadData()
        }
        ingredientTextField.text = ""
    }
    
    
    
    @IBAction func clearButton(_ sender: Any) {
        ingredients = []
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ingredients == [] {
            let alert = UIAlertController(title: "Missing ingredients", message: "You must add ingredients before continuing.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        guard let RecipeVC = segue.destination as? RecipeViewController else { return }
        RecipeVC.ingredients = ingredients
    }
}






