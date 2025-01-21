//
//  Assignment2App.swift
//  Assignment2
//
//  Created by Karen Vo on 1/18/25.
//

import SwiftUI

@main
struct Assignment2App: App {
    @State private var list = PatientList()
    var body: some Scene {
        WindowGroup {
            PatientsView(list: list)
        }
    }
}
