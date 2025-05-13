//
//  ChatSummary.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/12/25.
//

import Foundation

struct ChatSummary: Identifiable, Equatable {
    let id: String        // Chat ID
    let name: String      // Chat name or title
    let lastMessage: String?
    let timestamp: Date
}
