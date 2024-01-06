//
//  SearchRecipeRepository.swift
//  RecipeSearchApp
//
//  Created by karim  on 06/01/2024.
//

import Foundation

protocol SearchRecipeRepositoryProtocol {
    func getSearchRecipe(endPoint:EndPoint,onComplete: @escaping onComplete<RecipeSearchModel>)
}

 class SearchRecipeRepository:SearchRecipeRepositoryProtocol {
    func getSearchRecipe(endPoint:EndPoint,onComplete: @escaping onComplete<RecipeSearchModel>) {
        API.shared.startAPI(endPoint: endPoint, onComplete: onComplete)
    }
}
