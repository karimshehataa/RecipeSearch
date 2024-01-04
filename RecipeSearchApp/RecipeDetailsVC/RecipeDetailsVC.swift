//
//  RecipeDetailsVC.swift
//  RecipeSearchApp
//
//  Created by karim  on 03/01/2024.
//

import UIKit
import AlamofireImage

class RecipeDetailsVC: UIViewController {

    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var recipeCalories: UILabel!
    
    @IBOutlet weak var recipeTotalWeight: UILabel!
    
    @IBOutlet weak var recipeTotalTime: UILabel!
    var viewModel:RecipeDetailsViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.recipe = { recipe in
            self.recipeTitle.text = recipe.recipe?.label
            self.recipeCalories.text = "Calories is \(recipe.recipe?.calories ?? 0)"
            self.recipeTotalWeight.text = "Total Weight is \(recipe.recipe?.totalWeight ?? 0)"
            self.recipeTotalTime.text = "Total Time is \(recipe.recipe?.totalTime ?? 0)"
            let image = recipe.recipe?.image
            let url = URL(string: image ?? "")
            self.recipeImage.af.setImage(withURL: url ?? URL(fileURLWithPath: ""))
            
        }
        // Do any additional setup after loading the view.
    }
    init(viewModel: RecipeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
