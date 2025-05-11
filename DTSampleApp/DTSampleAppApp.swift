//
//  DTSampleAppApp.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/11/25.
//

import SwiftUI

@main
struct DTSampleAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
