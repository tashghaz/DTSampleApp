//
//  ChatMessage.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import Foundation
import SwiftUI

enum MessageType: String, CaseIterable, Codable {
    case regular
    case toolEvent
}

struct ChatMessage: Identifiable {
    let id: UUID
    let text: String?
    let image: UIImage?
    let isIncoming: Bool
    let timestamp: Date
    let type: MessageType

    init(
        id: UUID = UUID(),
        text: String?,
        image: UIImage? = nil,
        isIncoming: Bool,
        timestamp: Date = Date(),
        type: MessageType = .regular
    ) {
        self.id = id
        self.text = text
        self.image = image
        self.isIncoming = isIncoming
        self.timestamp = timestamp
        self.type = type
    }
}

//MARK: - Manual Codable
extension ChatMessage: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case isIncoming
        case timestamp
        case type
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        isIncoming = try container.decode(Bool.self, forKey: .isIncoming)
        timestamp = try container.decode(Date.self, forKey: .timestamp)
        type = try container.decode(MessageType.self, forKey: .type)
        image = nil //UIImage is not codable
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(isIncoming, forKey: .isIncoming)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(type, forKey: .type)
    }
}
