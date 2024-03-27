import SwiftUI

struct AddExerciseView: View {
    @State private var newExerciseName: String = ""
    @State private var newExerciseType: ExerciseType = .strength
    @State private var newExerciseSets: Int = 0
    @State private var newExerciseRepetitions: Int = 0
    @State private var newExerciseDuration: TimeInterval = 0
    
    @Binding var exercises: [Exercise]

    var body: some View {
        VStack {
            TextField("Exercise Name", text: $newExerciseName)
            Picker("Exercise Type", selection: $newExerciseType) {
                ForEach(ExerciseType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            Stepper(value: $newExerciseSets, in: 0...10, label: { Text("Sets: \(newExerciseSets)") })
            Stepper(value: $newExerciseRepetitions, in: 0...100, label: { Text("Repetitions: \(newExerciseRepetitions)") })
            Stepper(value: $newExerciseDuration, in: 0...3600, step: 30, label: { Text("Duration: \(Int(newExerciseDuration)) seconds") })
            
            Button("Add Exercise") {
                let newExercise = Exercise(name: newExerciseName, type: newExerciseType, sets: newExerciseSets, repetitions: newExerciseRepetitions, duration: Int(newExerciseDuration))
                exercises.append(newExercise)
                // Reset temporary variables if needed
                newExerciseName = ""
                newExerciseType = .strength
                newExerciseSets = 0
                newExerciseRepetitions = 0
                newExerciseDuration = 0
            }
        }
        .padding()
    }
}
