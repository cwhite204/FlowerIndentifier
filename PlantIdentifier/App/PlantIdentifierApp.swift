//
//  PlantIdentifierApp.swift
//  PlantIdentifier
//
//  Created by Christopher on 01/05/2021.
//

import SwiftUI

@main
struct PlantIdentifierApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
