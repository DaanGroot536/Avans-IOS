//
//  MealPlanDetailView.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 26/03/2024.
//

import SwiftUI

struct MealPlanDetailView: View {
    var mealPlan: MealPlan
    
    private func calculateTotalMacros() -> (calories: Int, protein: Int, fat: Int, carbohydrates: Int) {
            var totalCalories = 0
            var totalProtein = 0
            var totalFat = 0
            var totalCarbohydrates = 0

            for mealNumber in mealPlan.mealNumbers {
                for item in mealNumber.mealItems {
                    totalCalories += item.standardMeal.calories
                    totalProtein += item.standardMeal.protein
                    totalFat += item.standardMeal.fat
                    totalCarbohydrates += item.standardMeal.carbohydrates
                }
            }

        return (totalCalories, totalProtein, totalFat, totalCarbohydrates)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(mealPlan.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)

                let macros = calculateTotalMacros()
                            VStack(alignment: .leading) {
                                Text("Macros Overview")
                                    .font(.headline)
                                    .padding(.bottom, 2)
                                Text("Calories: \(macros.calories)")
                                Text("Protein: \(macros.protein)g")
                                Text("Fat: \(macros.fat)g")
                                Text("Carbs: \(macros.carbohydrates)g")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)

                ForEach(mealPlan.mealNumbers, id: \.id) { mealNumber in
                    VStack(alignment: .leading) {
                        Text(mealNumber.name)
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        ForEach(mealNumber.mealItems, id: \.id) { mealItem in
                            Text("\(mealItem.standardMeal.product) - \(mealItem.quantity)")
                                .padding(.bottom, 2)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Meal Plan Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

