//
//  Dosage.swift
//  Assignment2
//
//  Created by Karen Vo on 1/19/25.
//

enum DosageUnit: String, CaseIterable {
    case ml = "ml"
    case mg = "mg"
    case mcg = "mcg"
}

struct Dosage: Equatable {
    let value: Int
    let units: DosageUnit
    var fullDescription: String {
        "\(value) \(units.rawValue)"
    }
}

