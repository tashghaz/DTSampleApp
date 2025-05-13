//
//  ChatRepository.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import Foundation
import Combine
import Apollo
import DTSampleAppAPI

enum RepositoryError: Error, LocalizedError {
    case invalidCreateChat
    case invalidSendMessage
    case invalidGetChats

    var errorDescription: String? {
        switch self {
        case .invalidCreateChat: return "Invalid createChat response"
        case .invalidSendMessage: return "Invalid sendMessage response"
        case .invalidGetChats: return "Invalid getChats response"
        }
    }
}

protocol ChatRepositoryProtocol {
    func createChat(name: String) -> AnyPublisher<ChatMessage, Error>
    func sendMessage(chatId: String, text: String) -> AnyPublisher<ChatMessage, Error>
    func getChats(first: Int, offset: Int) -> AnyPublisher<[ChatMessage], Error>
}

final class ChatRepository: ChatRepositoryProtocol {
    private let client = ApolloService.shared.client

    private static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    func createChat(name: String) -> AnyPublisher<ChatMessage, Error> {
        let mutation = CreateChatMutation(name: name)

        return Future<ChatMessage, Error> { promise in
            self.client.perform(mutation: mutation) { result in
                switch result {
                case .success(let graphQLResult):
                    if let chat = graphQLResult.data?.createChat {
                        let message = ChatMessage(
                            text: chat.name,
                            isIncoming: true,
                            timestamp: Self.iso8601Formatter.date(from: chat.createdAt) ?? Date()
                        )
                        promise(.success(message))
                    } else {
                        promise(.failure(RepositoryError.invalidCreateChat))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func sendMessage(chatId: String, text: String) -> AnyPublisher<ChatMessage, Error> {
        let mutation = SendMessageMutation(chatId: chatId, text: text)

        return Future<ChatMessage, Error> { promise in
            self.client.perform(mutation: mutation) { result in
                switch result {
                case .success(let graphQLResult):
                    if let msg = graphQLResult.data?.sendMessage {
                        let message = ChatMessage(
                            text: msg.text,
                            isIncoming: true,
                            timestamp: Self.iso8601Formatter.date(from: msg.createdAt) ?? Date()
                        )
                        promise(.success(message))
                    } else {
                        promise(.failure(RepositoryError.invalidSendMessage))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func getChats(first: Int, offset: Int) -> AnyPublisher<[ChatMessage], Error> {
        let query = GetChatsQuery(first: first, offset: offset)

        return Future<[ChatMessage], Error> { promise in
            self.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { result in
                switch result {
                case .success(let gqlResult):
                    if let chats = gqlResult.data?.getChats {
                        let messages: [ChatMessage] = chats.map { chat in
                            ChatMessage(
                                text: chat.name,
                                isIncoming: true,
                                timestamp: Self.iso8601Formatter.date(from: chat.createdAt) ?? Date()
                            )
                        }
                        promise(.success(messages))
                    } else {
                        promise(.failure(RepositoryError.invalidGetChats))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
