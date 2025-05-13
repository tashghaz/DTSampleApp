//
//  ChatListViewModel.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import Foundation
import Combine

@MainActor
final class ChatListViewModel: ObservableObject {
    @Published var chatSummaries: [ChatSummary] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: RecentChatsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(repository: RecentChatsRepositoryProtocol = RecentChatsRepository()) {
        self.repository = repository
        loadChats()
    }

    func loadChats() {
        isLoading = true
        errorMessage = nil

        repository.fetchRecentChats(first: 20, offset: 0)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] chats in
                self?.chatSummaries = chats
            }
            .store(in: &cancellables)
    }
}
