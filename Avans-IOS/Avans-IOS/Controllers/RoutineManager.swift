import Foundation

struct WorkoutRoutinesData: Codable {
    var routines: [WorkoutRoutine]
}

class WorkoutRoutinesViewModel: ObservableObject {
    @Published var routines: [WorkoutRoutine] = []

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
