//
//  OnboardingView.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var scannerViewModel = QRScannerViewModel()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        ZStack {
            QRScannerView(scanner: scannerViewModel)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                Text("Place the QR code inside the area\nScanning will start automatically")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding()
            }
        }
        .onChange(of: scannerViewModel.didFinishScanning) {
            if scannerViewModel.didFinishScanning {
                hasCompletedOnboarding = true
            }
        }
        .alert("Camera Access Needed",
               isPresented: $scannerViewModel.showPermissionAlert) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enable camera access in Settings.")
        }
    }
}
