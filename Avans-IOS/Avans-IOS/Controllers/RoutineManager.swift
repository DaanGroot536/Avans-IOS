import Foundation

struct WorkoutRoutinesData: Codable {
    var routines: [WorkoutRoutine]
}

class WorkoutRoutinesViewModel: ObservableObject {
    @Published var routines: [WorkoutRoutine] = []
    
    // State variables to control presentation of the edit exercise view
    @Published var isEditExerciseViewPresented = false
    @Published var selectedExercise: Exercise?

    func showEditExerciseView(for exercise: Exercise) {
        // Set the selected exercise and present the edit exercise view
        self.selectedExercise = exercise
        self.isEditExerciseViewPresented = true
    }
    
    func updateExercise(_ exercise: Exercise, inRoutine routine: WorkoutRoutine) {
        guard let index = routines.firstIndex(where: { $0.id == routine.id }) else {
            return // Routine not found
        }

        guard let exerciseIndex = routines[index].exercises.firstIndex(where: { $0.id == exercise.id }) else {
            return // Exercise not found
        }

        routines[index].exercises[exerciseIndex] = exercise
    }
    
    func deleteExercise(at index: Int, fromRoutine routine: inout WorkoutRoutine) {
        guard index >= 0 && index < routine.exercises.count else {
            return // Index out of bounds
        }
        // Make a mutable copy of the routine
        var mutableRoutine = routine
        // Remove the exercise at the specified index from the routine's exercises array
        mutableRoutine.exercises.remove(at: index)
        // Assign the modified routine back to the original routine
        routine = mutableRoutine
    }
    
    func deleteExercises(at offsets: IndexSet, fromRoutine routine: WorkoutRoutine) {
        guard let index = routines.firstIndex(where: { $0.id == routine.id }) else {
            return // Routine not found
        }

        routines[index].exercises.remove(atOffsets: offsets)
    }


    // File URL for saving and loading routines
    private var fileURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent("routines.json")
    }

    // Load routines from JSON file
    func loadRoutines() {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let routinesData = try decoder.decode(WorkoutRoutinesData.self, from: data)
            self.routines = routinesData.routines
        } catch {
            print("Error loading routines: \(error.localizedDescription)")
        }
    }

    // Save routines to JSON file
    func saveRoutines() {
        do {
            let encoder = JSONEncoder()
            let routinesData = WorkoutRoutinesData(routines: self.routines)
            let data = try encoder.encode(routinesData)
            try data.write(to: fileURL)
        } catch {
            print("Error saving routines: \(error.localizedDescription)")
        }
    }

    func addRoutine(routine: WorkoutRoutine) {
        routines.append(routine)
        saveRoutines() // Save routines after adding a new one
    }
    
    func removeRoutine(at indexSet: IndexSet) {
        routines.remove(atOffsets: indexSet)
        saveRoutines() // Save routines after removing one
    }
    
    func updateRoutine(routine: WorkoutRoutine) {
        if let index = routines.firstIndex(where: { $0.id == routine.id }) {
            routines[index] = routine
            saveRoutines() // Save routines after updating one
        }
    }
}
