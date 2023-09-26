//
//  TeamFitnessChallengesApp.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/20/23.
//

import SwiftUI

@main
struct TeamFitnessChallengesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
