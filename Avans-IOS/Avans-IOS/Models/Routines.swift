//
//  Routines.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 27/03/2024.
//

import Foundation

struct Exercise: Identifiable, Codable, Equatable  {
    var id: UUID = UUID()
    var name: String
    var type: ExerciseType
    var sets: Int
    var repetitions: Int
    var duration: Int // Duur in minuten
}

enum ExerciseType: String, Codable, CaseIterable, Identifiable {
    case strength = "Kracht"
    case cardio = "Cardio"
    var id: String { self.rawValue }
}

struct WorkoutRoutine: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var exercises: [Exercise]
}
