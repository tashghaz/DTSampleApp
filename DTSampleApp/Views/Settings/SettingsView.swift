//
//  SettingsView.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.colorScheme) private var scheme
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: $viewModel.isDarkMode)

            Button("Logout") {
                viewModel.logout()
            }
            .foregroundColor(.red)
        }
        .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
        .navigationTitle("Settings")
    }
}
