# DTSampleApp – Digital Twin AI Assistant (iOS)

**DTSampleApp** is a native iOS app that simulates a Digital Twin assistant capable of understanding, chatting, and reacting to the user's context in real time.

## Features

- **QR Code Onboarding**
  - Scan a QR code to securely connect with the backend and retrieve credentials
- **Chat Interface**
  - Send and receive text & image messages
  - Stream assistant responses in real-time
  - Support for tool-event messages
- **Voice Input**
  - Speech-to-text using native iOS Speech framework
- **Core Data Persistence**
  - Chat history saved locally and available offline
- **Settings**
  - Toggle Dark/Light mode
  - Secure logout
- **Unit Tests**
  - 80%+ test coverage including mock repository and view model tests

## Architecture

- **MVVM (Model-View-ViewModel)**
- **Combine** for reactive programming
- **Apollo GraphQL** for networking and codegen
- **SwiftUI** for declarative UI
- **CoreData** for offline persistence
- **Keychain** for secure credential storage

## Folder Structure
├── Models
├── ViewModels
├── Views
├── Services
│   ├── ApolloService
│   ├── KeychainService
│   ├── SpeechRecognizerService
├── graphql/
│   └── Operations/

## Setup

1. Clone the repo
2. Open `DTSampleApp.xcodeproj`
3. Ensure GraphQL schema and codegen are in place
4. Run on a real device (QR scanning and microphone require hardware)

