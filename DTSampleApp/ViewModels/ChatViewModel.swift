//
//  ChatViewModel.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import Foundation
import Combine
import SwiftUI
import CoreData

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputText: String = ""
    @Published var streamingText: String = ""

    private let context = PersistenceController.shared.container.viewContext
    private let repository: ChatRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private let speechService = SpeechRecognizerService()

    init(repository: ChatRepositoryProtocol = ChatRepository()) {
        self.repository = repository
        loadMessages()
        setupSpeechBinding()
        NotificationCenter.default.addObserver(
            forName: .transcriptionCompleted,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                self.sendTranscribedMessage()
            }
        }
    }

    private func setupSpeechBinding() {
        speechService.$transcript
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.inputText = text
            }
            .store(in: &cancellables)
    }

    func toggleSpeechRecognition() {
        if speechService.isRecording {
            speechService.stopTranscribing()
        } else {
            try? speechService.startTranscribing()
        }
    }

    func sendTranscribedMessage() {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        sendMessage()
    }

    func loadMessages() {
        let request: NSFetchRequest<MessageEntity> = MessageEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        if let results = try? context.fetch(request) {
            self.messages = results.compactMap { $0.toChatMessage() }
        }
    }

    func sendMessage(image: UIImage? = nil) {
        let textToSend = inputText
        inputText = ""

        let localMessage = ChatMessage(
            text: textToSend,
            image: image,
            isIncoming: false
        )
        messages.append(localMessage)
        saveToCoreData(messages: localMessage)

        repository.sendMessage(chatId: "demo-chat-id", text: textToSend)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Send failed:", error)
                }
            } receiveValue: { [weak self] response in
                self?.messages.append(response)
                self?.saveToCoreData(messages: response)
            }
            .store(in: &cancellables)
    }

    func saveToCoreData(messages: ChatMessage) {
        let entity = MessageEntity(context: context)
        entity.id = messages.id
        entity.text = messages.text
        entity.isIncoming = messages.isIncoming
        entity.timestamp = messages.timestamp
        entity.imageData = messages.image?.jpegData(compressionQuality: 0.8)

        try? context.save()
    }
}
