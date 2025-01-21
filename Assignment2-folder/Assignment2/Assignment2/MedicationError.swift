//
//  MedicationError.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//
import SwiftUI

enum MedicationError: LocalizedError {
    case invalidDosage
    case duplicateMedication
    
    var description: String? {
        switch self {
        case .duplicateMedication:
            return "This medication has been prescribed already."
        case .invalidDosage:
            return "This is an invalid dosage value."
        }
    }
}
