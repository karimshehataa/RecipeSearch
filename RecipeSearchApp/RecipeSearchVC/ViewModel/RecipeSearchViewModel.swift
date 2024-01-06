//
//  RecipeSearchViewModel.swift
//  RecipeSearchApp
//
//  Created by karim  on 03/01/2024.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

protocol RecipeSearchViewModelProtocol:AnyObject {
    var RecipeObservable:Observable<[Hit]> { get }
    func getSearchRecipe(recipe:String,health:String?,isPaginate:Bool,isFilter:Bool)
}
class RecipeSearchViewModel {
    let searchInteractor: SearchRecipeInteractorProtocol
    init(searchInteractor: SearchRecipeInteractorProtocol) {
        self.searchInteractor = searchInteractor
    }
    private (set) var recipeDataArr: [Hit]? = []
    private (set) var nextPage:String?
    private var RecipeModelSubject = PublishSubject<[Hit]>()
    var RecipeObservable: Observable<[Hit]> {
        return RecipeModelSubject
    }
}
extension RecipeSearchViewModel:RecipeSearchViewModelProtocol {
    func getSearchRecipe(recipe:String,health:String?,isPaginate:Bool,isFilter:Bool) {
        var endPoint: EndPoint
        if isPaginate == true {
            let fullUrl = nextPage
            endPoint = EndPoint(method: .get,fullURL: fullUrl)
        } else {
            let fullUrl = URLEndpoints.searchRecipe
            var queryItems = [URLQueryItem(name: "q", value: recipe),URLQueryItem(name: "app_key", value: "76b760fd386f782b3ccb9df687306b52"),URLQueryItem(name: "app_id", value: "5bf8c454"),URLQueryItem(name: "type", value: "public"),URLQueryItem(name: "health", value: health)]
            if health == "All" {
                queryItems.remove(at: 4)
            }
            var urlComps = URLComponents(string:fullUrl)!
            urlComps.queryItems = queryItems
            let urlParams = urlComps.url?.absoluteString ?? ""
            print(urlParams)
            endPoint = EndPoint(method: .get,endPoint: urlParams)
        }
        
        searchInteractor.getSearchRecipe(endPoint: endPoint) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.recipeDataArr?.append(contentsOf: data.hits ?? [])
                if isPaginate {
                    self.RecipeModelSubject.onNext(self.recipeDataArr ?? [])
                } else {
                    self.RecipeModelSubject.onNext(data.hits ?? [])
                }
                self.nextPage = data.links?.next?.href
            case .failure(let error):
                print(error)
            }
        }
    }
}
