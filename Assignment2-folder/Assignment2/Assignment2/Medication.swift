//
//  Medication.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//
import Foundation

struct Medication: Equatable, Identifiable {
    let id: UUID
    let name: String
    let datePrescribed: Date
    let dose: Dosage
    let route: String
    let frequency: Int
    let duration: Int
    
    var expiration: Date {
        Calendar.current.date(byAdding: .day, value: duration, to: datePrescribed) ?? .now
    }
    
    var isActive: Bool {
        Date.now <= expiration
    }
    
    init(id: UUID = UUID(), name: String, datePrescribed: Date, dose: Dosage, route: String, frequency: Int, duration: Int) {
        self.id = id
        self.name = name
        self.datePrescribed = datePrescribed
        self.dose = dose
        self.route = route
        self.frequency = frequency
        self.duration = duration
    }
}
