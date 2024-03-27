//
//  EditExerciseView.swift
//  Avans-IOS
//
//  Created by Robin Pijnappels on 27/03/2024.
//

import SwiftUI

struct EditExerciseView: View {
    @Binding var exercise: Exercise
    var saveAction: () -> Void

    var body: some View {
        Form {
            TextField("Oefening Naam", text: $exercise.name)
            Picker("Type", selection: $exercise.type) {
                ForEach(ExerciseType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            Stepper("Sets: \(exercise.sets)", value: $exercise.sets, in: 1...10)
            Stepper("Herhalingen: \(exercise.repetitions)", value: $exercise.repetitions, in: 1...100)
            // Voeg eventueel meer velden toe zoals duration
            
            Button("Opslaan") {
                saveAction()
            }
        }
        .navigationBarTitle("Bewerk Oefening", displayMode: .inline)
    }
}

