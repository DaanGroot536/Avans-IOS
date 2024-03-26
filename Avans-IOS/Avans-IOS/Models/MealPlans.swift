//
//  MealPlans.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 26/03/2024.
//

import Foundation

// Define your data models corresponding to the JSON response
struct FoodSearchResponse: Codable {
    var success: Bool
    var mealPlans: [MealPlan]
    
    // CodingKeys to map the JSON keys to your Swift variable names if they don't match exactly
    enum CodingKeys: String, CodingKey {
        case success
        case mealPlans = "meal_plans"
    }
}

struct FoodPlanResponse: Codable {
    var success: Bool
    var mealPlan: [MealPlan]
    
    enum CodingKeys: String, CodingKey {
        case success
        case mealPlan = "meal_plan"
    }
}

struct MealPlan: Codable, Identifiable {
    var id: Int
    var userId: Int
    var name: String
    var createdAt: String
    var updatedAt: String
    var mealNumbers: [MealNumber]
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mealNumbers = "meal_numbers"
    }
}

struct MealNumber: Codable, Identifiable {
    var id: Int
    var name: String
    var mealPlanId: Int
    var createdAt: String
    var updatedAt: String
    var mealItems: [MealItem]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case mealPlanId = "meal_plan_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mealItems = "meal_items"
    }
}

struct MealItem: Codable, Identifiable {
    var id: Int
    var mealNumberId: Int
    var standardMealId: Int
    var quantity: Int
    var createdAt: String
    var updatedAt: String
    var standardMeal: StandardMeal
    
    enum CodingKeys: String, CodingKey {
        case id
        case mealNumberId = "meal_number_id"
        case standardMealId = "standard_meal_id"
        case quantity
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case standardMeal = "standard_meal"
    }
}

struct StandardMeal: Codable, Identifiable {
    var id: Int
    var product: String
    var quantity: Int
    var unit: String
    var calories: Int
    var protein: Int
    var fat: Int
    var carbohydrates: Int
    var type: String
    var createdAt: String?
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case product
        case quantity
        case unit
        case calories
        case protein
        case fat
        case carbohydrates
        case type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

