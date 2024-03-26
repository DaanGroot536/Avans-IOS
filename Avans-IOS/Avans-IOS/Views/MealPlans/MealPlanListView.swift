//
//  MealPlanListView.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 26/03/2024.
//

import SwiftUI

struct MealPlanListView: View {
    @State private var mealPlans: [MealPlan]? = nil
    @State private var fetchError: Bool = false
    
    var body: some View {
        NavigationView {
            List(mealPlans ?? []) { plan in
                NavigationLink(destination: MealPlanDetailView(mealPlan: plan)) {
                    Text(plan.name)
                }
            }
            .onAppear {
                NetworkManager.shared.fetchMealPlans() { response in
                    if let mealPlans = response {
                        self.mealPlans = mealPlans
                    } else {
                        self.fetchError = true
                    }
                }
            }
            .alert(isPresented: $fetchError) {
                Alert(title: Text("Error"), message: Text("Failed to fetch meal plans."), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Meal Plans")
        }
    }
}

