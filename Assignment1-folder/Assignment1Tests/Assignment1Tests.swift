//
//  Assignment1Tests.swift
//  Assignment1Tests
//
//  Created by Karen Vo on 1/12/25.
//

import XCTest
@testable import Assignment1

final class Assignment1Tests: XCTestCase {
    var patient: Patient!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dob = dateFormatter.date(from: "1980-10-21") {
            patient = Patient(
                firstName: "Kim",
                lastName: "Kardashian",
                DOB: dob,
                height: 62.0,
                weight: 130.0,
                bloodType: .APlus,
                medications: []
            )
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        patient = nil
    }

    func testFullNameAndAge() throws {
        let result = patient.fullNameAndAge()
        XCTAssertEqual(result, "Kardashian, Kim (44 years)")
    }
    
    func testActiveMedication() throws {
        let medication1 = Medication(
            datePrescribed: Date().addingTimeInterval(4 * 24 * -3600),
            name: "Ibuprofen",
            dose: "100mg",
            route: "Oral",
            frequency: 2,
            duration: 6
        )
        let medication2 = Medication(
            datePrescribed: Date().addingTimeInterval(9 * 24 * -3600),
            name: "Aspirin",
            dose: "200mg",
            route: "Oral",
            frequency: 1,
            duration: 5
        )
        let medication3 = Medication(
            datePrescribed: Date(),
            name: "Vitamin A",
            dose: "300mg",
            route: "Oral",
            frequency: 2,
            duration: 10
        )
        
        try patient.prescribeNewMedication(newMedication: medication1)
        try patient.prescribeNewMedication(newMedication: medication2)
        try patient.prescribeNewMedication(newMedication: medication3)
        
        let activeMedication = patient.activeMedication()
        XCTAssertEqual(activeMedication.count, 2)
        XCTAssertTrue(activeMedication.contains(medication1), "Ibuprofen is active on the list.")
        XCTAssertTrue(activeMedication.contains(medication3), "Vitamin A is active on the list.")
    }
    
    func testNewMedication() throws {
        let medication1 = Medication(
            datePrescribed: Date(),
            name: "Ibuprofen",
            dose: "100mg",
            route: "Oral",
            frequency: 2,
            duration: 6
        )
        let medication2 = Medication(
            datePrescribed: Date(),
            name: "Ibuprofen",
            dose: "100mg",
            route: "Oral",
            frequency: 2,
            duration: 6
        )
        try patient.prescribeNewMedication(newMedication: medication1)
        try patient.prescribeNewMedication(newMedication: medication2)
        
        XCTAssertEqual(patient.medications.count, 1, "Duplicate medication was added.")
    }
}
