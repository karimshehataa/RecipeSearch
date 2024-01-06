//
//  SearchRecipeInteractor.swift
//  RecipeSearchApp
//
//  Created by karim  on 06/01/2024.
//

import Foundation

protocol SearchRecipeInteractorProtocol {
    func getSearchRecipe(endPoint:EndPoint,onComplete: @escaping onComplete<RecipeSearchModel>)
}

class SearchRecipeInteractor {
    private let searchRecipeRepository: SearchRecipeRepository
    init(searchRecipeRepository: SearchRecipeRepository) {
        self.searchRecipeRepository = searchRecipeRepository
    }
}

extension SearchRecipeInteractor:SearchRecipeInteractorProtocol {
    func getSearchRecipe(endPoint: EndPoint, onComplete: @escaping onComplete<RecipeSearchModel>) {
        searchRecipeRepository.getSearchRecipe(endPoint: endPoint, onComplete: onComplete)
    }
}
