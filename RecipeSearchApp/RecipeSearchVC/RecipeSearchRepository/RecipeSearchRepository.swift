//
//  RecipeSearchRepository.swift
//  RecipeSearchApp
//
//  Created by karim  on 04/01/2024.
//

import Foundation

protocol RecipeSearchRepository {
    
    func searchRecipe(recipe:String,health:String?,isPaginate:Bool,onComplete: @escaping onComplete<RecipeSearchModel>)
}
