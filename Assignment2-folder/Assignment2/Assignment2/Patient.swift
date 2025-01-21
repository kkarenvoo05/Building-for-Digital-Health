//
//  Patient.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//
import Foundation
import SwiftUI

@Observable
class Patient: Identifiable {
    let MRN: UUID
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    let height: Int
    let weight: Int
    var bloodType: BloodType?
    private(set) var medications: [Medication] = []
    // I prompted ChatGPT to understand the methods of Calendar and the importance of the different parameters.
    var age: Int {
        let calculation = Calendar.current.dateComponents([.year], from: dateOfBirth, to: .now)
        return calculation.year ?? 0
    }
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    var fullNameAndAge: String {
            "\(lastName), \(firstName) (\(age) years)"
        }
    var activeMedication: [Medication] {
            let activeMedication = medications.filter { $0.isActive }
            let sortedActiveMedication = activeMedication.sorted { $0.datePrescribed < $1.datePrescribed }
            return sortedActiveMedication
        }
    func prescribeNewMedication(_ medication: Medication) throws {
            guard !medications.contains(where: { $0.name == medication.name && $0.isActive}) else {
                throw MedicationError.duplicateMedication
            }
            medications.append(medication)
        }
    init(firstName: String, lastName: String, dateOfBirth: Date, height: Int, weight: Int, bloodType: BloodType? = nil, medications: [Medication]) {
        self.MRN = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
    }
}
