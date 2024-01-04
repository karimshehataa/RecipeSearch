//
//  RecipeCell.swift
//  RecipeSearchApp
//
//  Created by karim  on 03/01/2024.
//

import UIKit

class RecipeCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipetitle: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        recipeImage.layer.cornerRadius = 20
    }
}
