# DTSampleApp – Digital Twin AI Assistant (iOS)

**DTSampleApp** is a native iOS app that simulates a Digital Twin assistant capable of understanding, chatting, and reacting to the user's context in real time.

## Features

- **QR Code Onboarding**
  - Scan a QR code to connect with the backend and retrieve credentials securely
- **Chat Interface**
  - Send and receive text & image messages
  - Stream assistant responses in real-time
  - Support for tool-event messages
- **Voice Input**
  - Speech-to-text using native iOS Speech framework
- **Core Data Persistence**
  - Chat history is saved locally and is available offline
- **Settings**
  - Toggle Dark/Light mode
  - Secure logout

## Architecture

- **MVVM (Model-View-ViewModel)**
- **Combine** for reactive programming
- **Apollo GraphQL** for networking and codegen
- **SwiftUI** for declarative UI
- **CoreData** for offline persistence
- **Keychain** for secure credential storage

## Setup

1. Clone the repo
2. Open `DTSampleApp.xcodeproj`
3. Ensure GraphQL schema and codegen are in place
4. Run on a real device (QR scanning and microphone require hardware)

