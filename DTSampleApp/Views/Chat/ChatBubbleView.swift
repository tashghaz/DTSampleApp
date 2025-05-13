//
//  ChatBubbleView.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isIncoming {
                Spacer()
            }

            VStack(alignment: .leading, spacing: 6) {
                if message.type == .toolEvent {
                    Label("Tool Event", systemImage: "wrench.and.screwdriver")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding(8)
                        .background(.orange.opacity(0.1))
                        .cornerRadius(8)
                }

                if let image = message.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                        .cornerRadius(10)
                }

                if let text = message.text {
                    Text(text)
                        .padding(15)
                        .background(message.isIncoming ? Color.gray.opacity(0.2) : Color.blue.opacity(0.8))
                        .foregroundStyle(message.isIncoming ? .black : .white)
                        .cornerRadius(10)
                }
            }
            .padding(message.isIncoming ? .leading : .trailing, 15)

            if !message.isIncoming {
                Spacer()
            }
        }
        .padding(.vertical, 5)
        .transition(.move(edge: message.isIncoming ? .leading : .trailing).combined(with: .opacity))
        .animation(.easeInOut, value: message.id)
    }
}
