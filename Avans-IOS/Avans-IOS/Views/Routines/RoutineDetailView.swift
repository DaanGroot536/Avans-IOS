import SwiftUI

struct RoutineDetailView: View {
    @EnvironmentObject var viewModel: WorkoutRoutinesViewModel
    @State var routine: WorkoutRoutine // Change to @State
    @State private var editMode = EditMode.inactive

    var body: some View {
        List {
            Section(header: Text("Oefeningen")) {
                ForEach(routine.exercises.indices, id: \.self) { index in
                    NavigationLink(
                        destination: ExerciseEditView(exercise: $routine.exercises[index], routine: routine),
                        label: {
                            ExerciseRow(exercise: $routine.exercises[index])
                        }
                    )
                }
                .onDelete(perform: deleteExercises)
            }
        }
        .navigationBarTitle(routine.name)
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $editMode)
    }

    private func deleteExercises(at offsets: IndexSet) {
        viewModel.deleteExercises(at: offsets, fromRoutine: routine)
    }
}

struct ExerciseRow: View {
    @Binding var exercise: Exercise

    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise.name)
                .font(.headline)
            Text("Type: \(exercise.type.rawValue)")
            Text("Sets: \(exercise.sets)")
            Text("Herhalingen: \(exercise.repetitions)")
            if exercise.duration > 0 {
                Text("Duur: \(exercise.duration) minuten")
            }
        }
        .padding(.vertical)
    }
}
