//
//  PatientList.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//
import SwiftUI
import Foundation

@Observable
class PatientList {
    var patients: [Patient] = []
    init(patients: [Patient] = []) {
        self.patients = patients
    }
    var sortedPatients: [Patient] {
        patients.sorted{$0.lastName < $1.lastName}
    }
    func addPatient(_ patient: Patient) {
        patients.append(patient)
    }
}
