//
//  PatientsView.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//
import SwiftUI

struct PatientsView: View {
    @Bindable var list: PatientList
    @State private var searchText = ""
    @State private var showingAddPatient = false
    
    var filterPatients: [Patient] {
        if searchText.isEmpty {
            return list.sortedPatients
        }
        return list.sortedPatients.filter {
            // I prompted ChatGPT to find the proper method to sort by the patient's last name.
            $0.lastName.localizedCaseInsensitiveContains(searchText)
        }
    }
    private func patientRow(_ patient: Patient) -> some View {
            VStack(alignment: .leading) {
                Text(patient.fullNameAndAge)
                    .font(.headline)
                Text("MRN: \(patient.MRN)")
                    .font(.caption)
            }
        }
    private var patientListView: some View {
            List(filterPatients) { patient in
                NavigationLink {
                    PatientDetailsView(patient: patient)
                } label: {
                    patientRow(patient)
                }
            }
        }
        
        private var toolbarContent: some View {
            Button("Add Patient") {
                showingAddPatient = true
            }
            .accessibilityIdentifier("Add Patient")
        }
        
        var body: some View {
            NavigationStack {
                patientListView
                    .navigationTitle("Patients")
                    .searchable(text: $searchText, prompt: "Search by patient's last name")
                    .toolbar {
                        toolbarContent
                    }
                    .sheet(isPresented: $showingAddPatient) {
                        NewPatientView(list: list)
                    }
            }
        }
}
