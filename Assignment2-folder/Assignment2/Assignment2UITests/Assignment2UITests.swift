//
//  Assignment2UITests.swift
//  Assignment2UITests
//
//  Created by Karen Vo on 1/18/25.
//

import XCTest

final class Assignment2UITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    @MainActor
    // I prompted ChatGPT on how to handle wait times because my test would fail due to longer wait times, which helped me develop this function.
    func elementExists(_ element: XCUIElement) async -> Bool {
        element.waitForExistence(timeout: 5)
    }
    
    func testAddPatient() async throws {
        let app = await XCUIApplication()
        await app.launch()
        
        // Verify the button exists
        let initialPatientNum = await app.cells.count
        let addButton = await app.buttons["Add Patient"]
        
        // Verify elements exist before proceeding
        let addButtonExists = await elementExists(addButton)
        XCTAssertTrue(addButtonExists, "Add Patient button should be visible")
        
        if addButtonExists {
            await addButton.tap()
            
            // Fill in the patient form
            let firstNameSection = await app.textFields["First Name"]
            let lastNameSection = await app.textFields["Last Name"]
            let heightSection = await app.textFields["Height"]
            let weightSection = await app.textFields["Weight"]
            
            // Check existence before proceeding
            let firstExists = await elementExists(firstNameSection)
            let lastExists = await elementExists(lastNameSection)
            let heightExists = await elementExists(heightSection)
            let weightExists = await elementExists(weightSection)
            
            XCTAssertTrue(firstExists, "First name section should be visible")
            XCTAssertTrue(lastExists, "Last name section should be visible")
            XCTAssertTrue(heightExists, "Height section should be visible")
            XCTAssertTrue(weightExists, "Weight section should be visible")
            
            if firstExists && lastExists && heightExists && weightExists {
                // Enter the patient information
                await firstNameSection.tap()
                await firstNameSection.typeText("Karen")
                
                await lastNameSection.tap()
                await lastNameSection.typeText("Vo")
                
                await heightSection.tap()
                await heightSection.typeText("150")
                
                await weightSection.tap()
                await weightSection.typeText("60")
                
                let saveButton = await app.buttons["Save"]
                let saveExists = await elementExists(saveButton)
                XCTAssertTrue(saveExists, "Save button should exist")
                
                if saveExists {
                    await saveButton.tap()
                    
                    try await Task.sleep(nanoseconds: 2_000_000_000) 
                    let newPatientNum = await app.cells.count
                    XCTAssertEqual(newPatientNum, initialPatientNum + 1, "The list should have one more patient")
                }
            }
        }
    }
}
