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
    
    @State private var isAddExerciseViewPresented = false

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

                        }
                    }
                    .onDelete(perform: deleteExercise)
                    Button("Voeg oefening toe") {
                        isAddExerciseViewPresented.toggle()
                    }
                }
            }
            .navigationBarTitle("Add/Edit Routine", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                saveRoutine()
            })
            // Present AddExerciseView as a sheet
            .sheet(isPresented: $isAddExerciseViewPresented) {
                AddExerciseView(exercises: $exercises)
            }
        }
        .onAppear {
            viewModel.loadRoutines()
        }
    }

    func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    func saveRoutine() {
        let newRoutine = WorkoutRoutine(id: UUID(), name: routineName, exercises: exercises)
        viewModel.addRoutine(routine: newRoutine)
        presentationMode.wrappedValue.dismiss()
        viewModel.saveRoutines()
    }
}
