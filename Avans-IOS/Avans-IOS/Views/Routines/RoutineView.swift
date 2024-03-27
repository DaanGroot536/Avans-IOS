//
//  RoutineView.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 27/03/2024.
//

import SwiftUI

struct RoutineListView: View {
    @EnvironmentObject var viewModel: WorkoutRoutinesViewModel
    @EnvironmentObject var settingsStore: SettingsStore
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.routines) { routine in
                    NavigationLink(destination: RoutineDetailView(routine: routine).environmentObject(viewModel)) {
                        Text(routine.name)
                    }
                }
                .onDelete(perform: viewModel.removeRoutine)
            }
            .navigationBarTitle("Oefenroutines")
            .navigationBarItems(
                leading: Button(action: { showingSettings = true }) {
                    Image(systemName: "gear")
                },
                trailing: NavigationLink(destination: AddEditRoutineView().environmentObject(viewModel)) {
                                    Image(systemName: "plus")
                                }
            )
            .sheet(isPresented: $showingSettings) {
                SettingsView().environmentObject(settingsStore)
            }
        }
        .preferredColorScheme(settingsStore.settings.darkModeEnabled ? .dark : .light)
        .onAppear {
            viewModel.loadRoutines()
        }
    }
}

