//
//  RecipeSearchModel.swift
//  RecipeSearchApp
//
//  Created by karim  on 03/01/2024.
//

// MARK: - RecipeSearchModel
struct RecipeSearchModel: Codable,GenericResponse {
    var code:Int?
    let from, to, count: Int?
    let links: RecipeSearchModelLinks?
    let hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
    let links: HitLinks?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: Next?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Next
struct Next: Codable {
    let href: String?
    let title: Title?
}

enum Title: String, Codable {
    case nextPage = "Next page"
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let totalWeight: Double?
    let totalTime: Double?
    let calories:Double?
}

// MARK: - RecipeSearchModelLinks
struct RecipeSearchModelLinks: Codable {
    let next: Next?
}
