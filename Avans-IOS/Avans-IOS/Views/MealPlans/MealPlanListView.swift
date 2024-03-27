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
    @State private var isOffline = false

    var body: some View {
        NavigationView {
            List {
                if isOffline {
                    HStack {
                        Image(systemName: "wifi.slash")
                            .foregroundColor(.red)
                        Text("Offline Mode")
                            .foregroundColor(.secondary)
                    }
                }
                ForEach(mealPlans ?? []) { plan in
                    NavigationLink(destination: MealPlanDetailView(mealPlan: plan)) {
                        Text(plan.name)
                    }
                }
            }
            .onAppear {
                NetworkManager.shared.fetchMealPlans() { response in
                    if let mealPlans = response {
                        self.mealPlans = mealPlans
                        NetworkManager.shared.saveMealPlansToFile(mealPlans: mealPlans)
                        self.isOffline = false
                    } else {
                        self.mealPlans = NetworkManager.shared.loadMealPlansFromFile()
                        self.isOffline = self.mealPlans != nil
                        self.fetchError = self.mealPlans == nil
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

