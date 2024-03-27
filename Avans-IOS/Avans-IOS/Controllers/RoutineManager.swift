//
//  RoutineManager.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 27/03/2024.
//

import Foundation

class WorkoutRoutinesViewModel: ObservableObject {
    @Published var routines: [WorkoutRoutine] = []
    
    func addRoutine(routine: WorkoutRoutine) {
        routines.append(routine)
    }
    
    func removeRoutine(at indexSet: IndexSet) {
        routines.remove(atOffsets: indexSet)
    }
    
    func updateRoutine(routine: WorkoutRoutine) {
        if let index = routines.firstIndex(where: { $0.id == routine.id }) {
            routines[index] = routine
        }
    }
}
