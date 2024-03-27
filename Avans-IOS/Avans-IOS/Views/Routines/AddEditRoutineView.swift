//
//  AddEditRoutineView.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 27/03/2024.
//

import SwiftUI

struct AddEditRoutineView: View {
    @EnvironmentObject var viewModel: WorkoutRoutinesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var routineName = ""
    @State private var exercises: [Exercise] = []

    // Een tijdelijke structuur voor het toevoegen van oefeningen in deze view
    @State private var newExerciseName = ""
    @State private var newExerciseType: ExerciseType = .strength
    @State private var newExerciseSets = 1
    @State private var newExerciseRepetitions = 1
    @State private var newExerciseDuration = 0 // Duur in minuten, indien van toepassing

    @State private var showingEditExerciseView = false
    @State private var exerciseToEdit: Exercise?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Routine Name")) {
                    TextField("Naam", text: $routineName)
                }
                
                Section(header: Text("Oefeningen")) {
                    ForEach(exercises.indices, id: \.self) { index in
                            HStack {
                                Text(exercises[index].name)
                                Spacer()
                                Button(action: {
                                    exerciseToEdit = exercises[index]
                                    showingEditExerciseView = true
                                }) {
                                    Image(systemName: "pencil")
                                }
                                .sheet(isPresented: $showingEditExerciseView) {
                                    if let exerciseToEdit = exerciseToEdit {
                                        EditExerciseView(exercise: Binding(get: { exerciseToEdit }, set: { exercises[index] = $0 }), saveAction: {
                                            showingEditExerciseView = false
                                        })
                                    }
                                }
                                .buttonStyle(BorderlessButtonStyle()) 
                            }
                        }
                        .onDelete(perform: deleteExercise)
                    Button("Voeg oefening toe") {
                        showAddExerciseView()
                    }
                }
            }
            .navigationBarTitle("Add/Edit Routine", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                saveRoutine()
            })
        }
    }
    
    func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    func showAddExerciseView() {
        // Tijdelijke methode om nieuwe oefening toe te voegen
        let newExercise = Exercise(id: UUID(), name: newExerciseName, type: newExerciseType, sets: newExerciseSets, repetitions: newExerciseRepetitions, duration: newExerciseDuration)
        exercises.append(newExercise)
        // Reset tijdelijke variabelen indien nodig
    }

    func saveRoutine() {
        let newRoutine = WorkoutRoutine(id: UUID(), name: routineName, exercises: exercises)
        viewModel.addRoutine(routine: newRoutine)
        presentationMode.wrappedValue.dismiss()
    }
}

