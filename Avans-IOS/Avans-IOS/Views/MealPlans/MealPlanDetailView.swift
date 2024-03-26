//
//  MealPlanDetailView.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 26/03/2024.
//

import SwiftUI

struct MealPlanDetailView: View {
    var mealPlan: MealPlan
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(mealPlan.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)

                // Example of displaying macros - adjust according to your actual data structure
                Text("Macros Overview")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)

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

