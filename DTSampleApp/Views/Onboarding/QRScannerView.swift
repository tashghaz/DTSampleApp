//
//  QRScannerView.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import SwiftUI
import AVFoundation

struct QRScannerView: UIViewRepresentable {
    @ObservedObject var scanner: QRScannerViewModel

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = AVCaptureVideoPreviewLayer(session: scanner.session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) { }
}
