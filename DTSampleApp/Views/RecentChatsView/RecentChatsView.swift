//
//  RecentChatsView.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import SwiftUI

struct RecentChatsView: View {
    @StateObject private var viewModel = ChatListViewModel()

    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView("Loading...")
            }

            ForEach(viewModel.chatSummaries) { summary in
                NavigationLink(destination: ChatView()) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(summary.name)
                            .font(.headline)

                        if let last = summary.lastMessage {
                            Text(last)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }

                        Text(summary.timestamp, style: .time)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }

            if let error = viewModel.errorMessage {
                Text("Error: \(error)").foregroundColor(.red)
            }
        }
        .navigationTitle("Recent Chats")
    }
}
