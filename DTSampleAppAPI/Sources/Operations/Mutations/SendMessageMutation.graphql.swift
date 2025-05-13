// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendMessageMutation: GraphQLMutation {
  public static let operationName: String = "SendMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendMessage($chatId: ID!, $text: String!) { sendMessage(chatId: $chatId, text: $text) { __typename id text role createdAt } }"#
    ))

  public var chatId: ID
  public var text: String

  public init(
    chatId: ID,
    text: String
  ) {
    self.chatId = chatId
    self.text = text
  }

  public var __variables: Variables? { [
    "chatId": chatId,
    "text": text
  ] }

  public struct Data: DTSampleAppAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { DTSampleAppAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("sendMessage", SendMessage.self, arguments: [
        "chatId": .variable("chatId"),
        "text": .variable("text")
      ]),
    ] }

    public var sendMessage: SendMessage { __data["sendMessage"] }

    /// SendMessage
    ///
    /// Parent Type: `Message`
    public struct SendMessage: DTSampleAppAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { DTSampleAppAPI.Objects.Message }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", DTSampleAppAPI.ID.self),
        .field("text", String?.self),
        .field("role", GraphQLEnum<DTSampleAppAPI.Role>.self),
        .field("createdAt", DTSampleAppAPI.DateTime.self),
      ] }

      public var id: DTSampleAppAPI.ID { __data["id"] }
      public var text: String? { __data["text"] }
      public var role: GraphQLEnum<DTSampleAppAPI.Role> { __data["role"] }
      public var createdAt: DTSampleAppAPI.DateTime { __data["createdAt"] }
    }
  }
}
