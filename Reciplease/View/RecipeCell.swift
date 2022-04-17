//
//  ViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 04/04/2022.
//

import UIKit


class RecipeCell: UITableViewCell {
    override func awakeFromNib() {

       super.awakeFromNib()

       // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {

       super.setSelected(selected, animated: animated)


       // Configure the view for the selected state

    }
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 25
    }

    @IBOutlet weak var indregredientsListLabel: UILabel!
    @IBOutlet weak var labelFavorite: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
}

