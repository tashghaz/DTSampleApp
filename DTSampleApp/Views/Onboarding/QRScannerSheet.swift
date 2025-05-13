//
//  QRScannerSheet.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import SwiftUI

struct QRScannerSheet: View {
    @Binding var isPresented: Bool
    let onScanComplete: () -> Void

    @StateObject private var scannerViewModel = QRScannerViewModel()

    var body: some View {
        QRScannerView(scanner: scannerViewModel)
            .edgesIgnoringSafeArea(.all)
            .onChange(of: scannerViewModel.didFinishScanning) {
                if scannerViewModel.didFinishScanning {
                    isPresented = false
                    onScanComplete()
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
                Text("Please grant camera access in Settings to scan the QR code.")
            }
    }
}
