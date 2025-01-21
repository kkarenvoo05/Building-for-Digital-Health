//
//  PatientDetails.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//
import SwiftUI

struct PatientDetailsView: View {
    @Bindable var patient: Patient
    @State private var showingPrescribeMedication = false
    
    var body: some View {
        List {
            Section("Patient Info") {
                LabeledContent("Name", value: patient.fullName)
                LabeledContent("Age", value: "\(patient.age) years old")
                LabeledContent("Height", value: "\(patient.height) cm")
                LabeledContent("Weight", value: "\(patient.weight) kg")
                if let bloodType = patient.bloodType {
                    LabeledContent("Blood Type", value: bloodType.rawValue)
                }
            }
            
            Section {
                if patient.activeMedication.isEmpty {
                    Text("This patient has no active medications.").foregroundStyle(.secondary)
                } else {
                    ForEach(patient.activeMedication) { medication in
                        VStack(alignment: .leading) {
                            Text(medication.name).font(.headline)
                            Text("Frequency: \(medication.frequency) times a day").font(.caption)
                        }
                    }
                }
            } header: {
                Text("Patient's Active Medication")
            }
        }
        .navigationTitle("Patient Details")
        .toolbar {
            Button("Prescribe Medication") {
                showingPrescribeMedication = true
            }
        }
        .sheet(isPresented: $showingPrescribeMedication) {
            PrescribeMedicationView(patient: patient)
        }
    }
}
