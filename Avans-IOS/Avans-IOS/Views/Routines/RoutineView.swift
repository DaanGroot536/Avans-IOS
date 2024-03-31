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
    @State private var showingDeleteAlert = false
    @State private var routineToDelete: WorkoutRoutine?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.routines) { routine in
                    NavigationLink(destination: RoutineDetailView(routine: routine).environmentObject(viewModel)) {
                        Text(routine.name)
                    }
                    .contextMenu {
                        Button(action: {
                            routineToDelete = routine
                            showingDeleteAlert = true
                        }) {
                            Label("Verwijder", systemImage: "trash")
                        }
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
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Routine Verwijderen"),
                    message: Text("Weet je zeker dat je deze routine wilt verwijderen? Dit kan niet ongedaan gemaakt worden."),
                    primaryButton: .destructive(Text("Verwijder")) {
                        if let routine = routineToDelete {
                            if let index = viewModel.routines.firstIndex(of: routine) {
                                viewModel.routines.remove(at: index)
                                viewModel.saveRoutines()
                            }
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .preferredColorScheme(settingsStore.settings.darkModeEnabled ? .dark : .light)
        .onAppear {
            viewModel.loadRoutines()
        }
    }
}


