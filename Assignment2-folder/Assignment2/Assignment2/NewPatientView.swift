//
//  NewPatientView.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//
import Foundation
import SwiftUI

struct NewPatientView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var list: PatientList
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date.now
    @State private var height = ""
    @State private var weight = ""
    @State private var bloodType: BloodType?
    @State private var showError = false
    
    var isSubmissionValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        Int(height) != nil &&
        Int(weight) != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Required Info") {
                    TextField("First Name", text: $firstName).accessibilityIdentifier("First Name")
                    TextField("Last Name", text: $lastName)
                    DatePicker("Date of Birth", selection: $dateOfBirth).accessibilityIdentifier("Last Name")
                    TextField("Height (in cm)", text: $height).keyboardType(.numberPad).accessibilityIdentifier("Height")
                    TextField("Weight (in kg)", text: $weight).keyboardType(.numberPad).accessibilityIdentifier("Weight")
                }
                Section("Optional Info") {
                    Picker("Blood Type", selection: $bloodType) {
                        ForEach(BloodType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("New Patient")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Exit") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        savePatient()
                    }
                    .accessibilityIdentifier("Save")
                    .disabled(!isSubmissionValid)
                }
            }
            .alert("Invalid", isPresented: $showError) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text("Please fill out all the required fields.")
            }
        }
    }
    
    private func savePatient() {
        guard let height = Int(height),
              let weight = Int(weight) else {
            showError = true
            return
        }
        
        let patient = Patient(
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            height: height,
            weight: weight,
            bloodType: bloodType,
            medications: []
        )
        
        list.addPatient(patient)
        dismiss()
    }
}
