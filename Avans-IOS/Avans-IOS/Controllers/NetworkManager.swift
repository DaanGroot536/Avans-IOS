//
//  NetworkManager.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 26/03/2024.
//

import Foundation

class NetworkManager {
    // Singleton instance for network requests
    static let shared = NetworkManager()
    
    private let baseURL = "https://pumpaesthetics.nl/api/"
    private let token = "Bearer 3|d79bwuW3qsapVZTPqy9xeKiRaJeB0UJWMbl7w7e7"
    
    func fetchMealPlans(completion: @escaping ([MealPlan]?) -> Void) {
        guard let url = URL(string: "\(baseURL)foodplans") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        print("Making request to \(url)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let foodSearchResponse = try JSONDecoder().decode(FoodSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(foodSearchResponse.mealPlans)
                }
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

