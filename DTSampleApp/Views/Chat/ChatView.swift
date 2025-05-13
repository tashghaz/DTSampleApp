//
//  ChatView.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import SwiftUI
import Speech

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var selectedImage: UIImage? = nil
    @State private var isPickerPresented = false
    @StateObject private var speechRecognizer = SpeechRecognizerService()
    @State private var isRecording = false
    @Namespace private var bottomID

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            ChatBubbleView(message: message)
                        }
                       
                        if !viewModel.streamingText.isEmpty {
                            ChatBubbleView(message: ChatMessage(
                                text: viewModel.streamingText,
                                isIncoming: true,
                                timestamp: Date(),
                                type: .regular
                            ))
                        }
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(height: 1)
                            .id(bottomID)
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) {
                    withAnimation {
                        proxy.scrollTo(bottomID, anchor: .bottom)
                    }
                }
            }

            HStack {
                Button {
                    isPickerPresented = true
                } label: {
                    Image(systemName: "photo")
                        .font(.system(size: 24))
                }

                TextField("Message...", text: $viewModel.inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 44)

                Button {
                        toggleSpeechRecognition()
                    } label: {
                        Image(systemName: isRecording ? "mic.fill" : "mic")
                            .font(.system(size: 24))
                            .foregroundColor(isRecording ? .red : .primary)
                    }

                Button {
                    viewModel.sendMessage(image: selectedImage)
                    selectedImage = nil
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.blue)
                }
                .disabled(viewModel.inputText.isEmpty && selectedImage == nil)
            }
            .padding()
            .sheet(isPresented: $isPickerPresented) {
                ImagePicker(image: $selectedImage)
            }
        }
        .navigationTitle("Chat with Twin")
        .toolbar {
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape")
            }
        }
        .hideKeyboardOnTap()
    }

    private func toggleSpeechRecognition() {
        if isRecording {
            speechRecognizer.stopTranscribing()
        } else {
            SFSpeechRecognizer.requestAuthorization { authStatus in
                if authStatus == .authorized {
                    do {
                        try speechRecognizer.startTranscribing()
                    } catch {
                        print("Failed to start speech recognition:", error)
                    }
                }
            }
        }
        isRecording.toggle()
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
