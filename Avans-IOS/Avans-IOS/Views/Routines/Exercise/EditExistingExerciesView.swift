import SwiftUI

struct ExerciseEditView: View {
    @EnvironmentObject var viewModel: WorkoutRoutinesViewModel
    @Binding var exercise: Exercise
    @State var routine: WorkoutRoutine // Change to @State
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    TextField("Name", text: $exercise.name)
                    Picker("Type", selection: $exercise.type) {
                        ForEach(ExerciseType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    Stepper("Sets: \(exercise.sets)", value: $exercise.sets)
                    Stepper("Repetitions: \(exercise.repetitions)", value: $exercise.repetitions)
                    Stepper("Duration (minutes): \(exercise.duration)", value: $exercise.duration)
                }
            }
            .navigationBarTitle("Edit Exercise")
            .navigationBarItems(trailing: Button("Done") {
                viewModel.updateExercise(exercise, inRoutine: routine)
                viewModel.saveRoutines()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
