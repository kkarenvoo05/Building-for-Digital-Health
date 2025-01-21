//
//  PrescribeMedicationView.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//
import SwiftUI

struct PrescribeMedicationView: View {
    @Environment(\.dismiss) private var dismiss
    var patient: Patient
    
    @State private var name = ""
    @State private var dosageValue = ""
    @State private var dosageUnit = DosageUnit.mg
    @State private var route = ""
    @State private var frequency = ""
    @State private var duration = ""
    @State private var error: MedicationError?
    @State private var showError = false
    
    var isSubmissionValid: Bool {
        !name.isEmpty &&
        !dosageValue.isEmpty &&
        Int(dosageValue) != nil &&
        !frequency.isEmpty &&
        Int(frequency) != nil &&
        !duration.isEmpty &&
        Int(duration) != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Medication Details") {
                    TextField("Name", text: $name)
                    HStack {
                        TextField("Dosage", text: $dosageValue).keyboardType(.numberPad)
                        Picker("Unit", selection: $dosageUnit) {
                            ForEach(DosageUnit.allCases, id: \.self) { unit in
                                Text(unit.rawValue).tag(unit)
                            }
                        }
                    }
                    TextField("Frequency", text: $frequency).keyboardType(.numberPad)
                    TextField("Duration (days)", text: $duration).keyboardType(.numberPad)
                }
            }
            .navigationTitle("Prescribe Medication")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Exit") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveMedication()
                    }
                    .disabled(!isSubmissionValid)
                }
            }
            .alert("Error", isPresented: $showError) { // I prompted ChatGPT to understand the '.alert' and its parameters.
                Button("Ok", role: .cancel) { }
            } message: {
                Text(error?.localizedDescription ?? "Error unknown.")
            }
        }
    }
    
    private func saveMedication () {
        guard let dosageValueInt = Int(dosageValue),
              let frequencyInt = Int(frequency),
              let durationInt = Int(duration) else {
            error = .invalidDosage
            showError = true
            return
        }
        let medication = Medication(
            id: UUID(),
            name: name,
            datePrescribed: .now,
            dose: Dosage(value: dosageValueInt, units: dosageUnit),
            route: route,
            frequency: frequencyInt,
            duration: durationInt
        )
        do {
            try patient.prescribeNewMedication(medication)
            dismiss()
        } catch {
            self.error = error as? MedicationError
            showError = true
        }
    }
}
