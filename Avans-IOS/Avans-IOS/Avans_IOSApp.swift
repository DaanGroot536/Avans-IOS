//
//  Avans_IOSApp.swift
//  Avans-IOS
//
//  Created by Daan Groot on 20/03/2024.
//

import SwiftUI
import SwiftData

@main
struct Avans_IOSApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject var settingsStore = SettingsStore()
    @StateObject var workoutRoutinesViewModel = WorkoutRoutinesViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                RoutineListView()
                    .tabItem {
                        Label("Routines", systemImage: "flame")
                    }
                    .environmentObject(workoutRoutinesViewModel)
                    .environmentObject(settingsStore)


                MealPlanListView()
                    .tabItem {
                        Label("Meal Plans", systemImage: "list.bullet")
                    }
            }
            .modelContainer(sharedModelContainer)
        }

    }
}
