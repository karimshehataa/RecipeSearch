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

class RecipeSearchViewModel {
    var arrTest:[Hit] = [Hit]()
    private (set) var nextPage:String?
    private (set) var count:Int?
    private var RecipeModelSubject = PublishSubject<[Hit]>()
    var RecipeObservable: Observable<[Hit]> {
        return RecipeModelSubject
    }
    
    func searchRecipe(recipe:String,health:String? = nil,isPaginate:Bool) {
        print(recipe)
        fetchData(recipe: recipe,health: health, isPaginate: isPaginate) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                print(data.links?.next?.href)
                self.RecipeModelSubject.onNext(data.hits ?? [])
                self.count = data.to
                self.nextPage = data.links?.next?.href
                print(data.hits?.count)
                print(data.from)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchData(recipe:String,health:String? = nil,isPaginate:Bool,onComplete: @escaping onComplete<RecipeSearchModel>) {
        print(recipe)
        print(health)
        var endPoint: EndPoint
        if isPaginate == true {
            let fullUrl = nextPage
             endPoint = EndPoint(method: .get,fullURL: fullUrl)

        } else {
            let fullUrl = URLEndpoints.searchRecipe
            var queryItems = [URLQueryItem(name: "q", value: recipe),URLQueryItem(name: "type", value: "public"),URLQueryItem(name: "app_id", value: "5bf8c454"),URLQueryItem(name: "app_key", value: "76b760fd386f782b3ccb9df687306b52"),URLQueryItem(name: "health", value: health)]
            if health == "" {
                queryItems.remove(at: 4)
            }
            var urlComps = URLComponents(string:fullUrl)!
            urlComps.queryItems = queryItems
            let urlParams = urlComps.url?.absoluteString ?? ""
            endPoint = EndPoint(method: .get,endPoint: urlParams)
        }
        API.shared.startAPI(endPoint: endPoint, onComplete: onComplete)

        
    }
}
