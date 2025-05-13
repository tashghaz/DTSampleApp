//
//  MessageEntity+Extensions.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import Foundation
import CoreData
import UIKit

extension MessageEntity {
    func toChatMessage() -> ChatMessage {
        return ChatMessage(
            id: self.id ?? UUID(),
            text: self.text ?? "",
            image: self.imageData != nil ? UIImage(data: self.imageData!) : nil,
            isIncoming: self.isIncoming,
            timestamp: self.timestamp ?? Date(),
            type: MessageType(rawValue: self.type ?? "") ?? .regular
        )
    }
}
