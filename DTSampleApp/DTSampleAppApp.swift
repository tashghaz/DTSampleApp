//
//  DTSampleAppApp.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/11/25.
//

import SwiftUI

@main
struct DTSampleApp: App {
    let persistenceController = PersistenceController.shared

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
