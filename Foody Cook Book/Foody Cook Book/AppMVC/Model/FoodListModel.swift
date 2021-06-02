// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct FoodListModel: Codable {
    let meals: [Meals]
}

// MARK: Created only Require detail's Model, we can use all the key too.
struct Meals: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String

    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
    }
}
