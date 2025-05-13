//
//  SettingsViewModel.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = true
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    func logout() {
        KeychainService.deleteCredentials()
        hasCompletedOnboarding = false
    }
}
