//
//  RecentChatsRepository.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import Foundation
import Combine
import Apollo
import DTSampleAppAPI

protocol RecentChatsRepositoryProtocol {
    func fetchRecentChats(first: Int, offset: Int) -> AnyPublisher<[ChatSummary], Error>
}

final class RecentChatsRepository: RecentChatsRepositoryProtocol {
    private let client = ApolloService.shared.client
    private static let formatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()

    func fetchRecentChats(first: Int, offset: Int) -> AnyPublisher<[ChatSummary], Error> {
        let query = GetChatsQuery(first: first, offset: offset)

        return Future<[ChatSummary], Error> { promise in
            self.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { result in
                switch result {
                case .success(let gqlResult):
                    let summaries = gqlResult.data?.getChats.compactMap { chat -> ChatSummary? in
                        guard let last = chat.messages.last else { return nil }
                        let date = Self.formatter.date(from: last.createdAt) ?? Date()
                        return ChatSummary(
                            id: chat.id,
                            name: chat.name,
                            lastMessage: last.text,
                            timestamp: date
                        )
                    } ?? []
                    promise(.success(summaries))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
