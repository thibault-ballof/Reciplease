//
//  DetailFavoriteViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 13/04/2022.
//

import UIKit
import Alamofire

class DetailFavoriteViewController: UIViewController {
    // MARK: - Properties
    var recipes = FavoriteRecipes()
    var countIngredientsList = 0
    var isFavorite = true
    
    //MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countIngredientsList =  recipes.ingredientsLine!.count
        timeLabel.text = recipes.time
        yieldLabel.text = recipes.yield
        label.text = recipes.label
        
        if let image = recipes.image {
            AF.request( image,method: .get).response { response in
                
                switch response.result {
                case .success(let responseData):
                    self.image.image = UIImage(data: responseData!)
                    
                case .failure(let error):
                    print("error--->",error)
                }
            }
        }
        
        
        // Do any additional setup after loading the view.    
    }
    
    @IBAction func getDirectionsButton(_ sender: Any) {
        if let url = URL(string: recipes.url!) {
            UIApplication.shared.open(url)
        }
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
