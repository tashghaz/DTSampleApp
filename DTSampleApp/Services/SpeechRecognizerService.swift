//
//  SpeechRecognizerService.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import Foundation
import Speech
import AVFoundation
import Combine

final class SpeechRecognizerService: NSObject, ObservableObject {
    @Published var transcript: String = ""
    @Published var isRecording: Bool = false

    private let recognizer = SFSpeechRecognizer()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    func startTranscribing() throws {
        DispatchQueue.main.async { [weak self] in self?.transcript = "" }
        DispatchQueue.main.async { [weak self] in self?.isRecording = true }

        let request = SFSpeechAudioBufferRecognitionRequest()

        guard let recognizer = recognizer, recognizer.isAvailable else {
            throw NSError(domain: "SpeechRecognizer", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Speech recognizer unavailable"
            ])
        }

        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.removeTap(onBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()

        recognitionTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self?.transcript = result.bestTranscription.formattedString
                }

                if result.isFinal {
                    DispatchQueue.main.async {
                        self?.stopTranscribing()
                        NotificationCenter.default.post(name: .transcriptionCompleted, object: nil)
                    }
                }
            }

            if let error = error {
                print("Speech recognition error: \(error.localizedDescription)")
            }
        }
    }

    func stopTranscribing() {
        recognitionTask?.cancel()
        recognitionTask = nil

        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)

        DispatchQueue.main.async { [weak self] in self?.isRecording = false }
    }
}

extension Notification.Name {
    static let transcriptionCompleted = Notification.Name("transcriptionCompleted")
}
