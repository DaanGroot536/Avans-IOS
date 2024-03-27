//
//  RoutineDetailView.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 27/03/2024.
//

import SwiftUI

struct RoutineDetailView: View {
    var routine: WorkoutRoutine

    var body: some View {
        List {
            Section(header: Text("Oefeningen")) {
                ForEach(routine.exercises) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                        Text("Type: \(exercise.type.rawValue)")
                        Text("Sets: \(exercise.sets)")
                        Text("Herhalingen: \(exercise.repetitions)")
                        // Als de duur van een oefening relevant is, kan deze ook getoond worden:
                        if exercise.duration > 0 {
                            Text("Duur: \(exercise.duration) minuten")
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationBarTitle(routine.name)
    }
}



