//
//  Assignment1App.swift
//  Assignment1
//
//  Created by Karen Vo on 1/12/25.
//

import SwiftUI
import Foundation

@main
struct Assignment1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct Medication: Equatable {
    let datePrescribed: Date
    let name: String
    let dose: String
    let route: String
    let frequency: Int
    let duration: Int
    
    var expiration: Date {
        Calendar.current.date(byAdding: .day, value: duration, to: datePrescribed)!
    }
    
    var isActive: Bool {
        Date() <= expiration
    }
}

enum BloodType: String {
    case APlus = "A+"
    case AMinus = "A-"
    case BPlus = "B+"
    case BMinus = "B-"
    case OPlus = "O+"
    case OMinus = "O-"
    case ABPlus = "AB+"
    case ABMinus = "AB-"
}

class Patient {
    let MRN: UUID // unique identifier that is auto generated when creating a patient
    let firstName: String
    let lastName: String
    let DOB: Date
    var height: Double
    var weight: Double
    var bloodType: BloodType?
    private(set) var medications: [Medication]
    
    init(firstName: String, lastName: String, DOB: Date, height: Double, weight: Double, bloodType: BloodType, medications: [Medication]) {
        self.MRN = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
    }
    
    // Patient's Age
    var age: Int {
        let current = Date()
        let calculation = Calendar.current.dateComponents([.year], from: DOB, to: current)
        return calculation.year ?? 0
    }
    
    // Method 1: Return Patient's full name and age
    func fullNameAndAge() -> String {
        "\(lastName), \(firstName) (\(age) years)"
    }
    
    // Method 2: Return a current list of medications the patient is taking
    func activeMedication() -> [Medication] {
        let activeMedication = medications.filter { $0.isActive }
        let sortedActiveMedication = activeMedication.sorted { $0.datePrescribed < $1.datePrescribed }
        return sortedActiveMedication
    }
    
    // Method 3: Prescribe a new Medication to a Patient
    func prescribeNewMedication(newMedication: Medication) throws {
        if medications.contains(where: { $0.name == newMedication.name && $0.isActive}) {
            throw DuplicateError.duplicateMedication
        }
        medications.append(newMedication)
    }
    
    // Error case for duplicated medication
    enum DuplicateError: Error, LocalizedError {
        case duplicateMedication
        var errorDescription: String {
            switch self {
            case .duplicateMedication:
                return "This medication is already prescribed."
            }
        }
    }
}
