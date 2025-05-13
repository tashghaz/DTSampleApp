// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetChatsQuery: GraphQLQuery {
  public static let operationName: String = "GetChats"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetChats($first: Int!, $offset: Int!) { getChats(first: $first, offset: $offset) { __typename id name createdAt messages { __typename text createdAt } } }"#
    ))

  public var first: Int
  public var offset: Int

  public init(
    first: Int,
    offset: Int
  ) {
    self.first = first
    self.offset = offset
  }

  public var __variables: Variables? { [
    "first": first,
    "offset": offset
  ] }

  public struct Data: DTSampleAppAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { DTSampleAppAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getChats", [GetChat].self, arguments: [
        "first": .variable("first"),
        "offset": .variable("offset")
      ]),
    ] }

    public var getChats: [GetChat] { __data["getChats"] }

    /// GetChat
    ///
    /// Parent Type: `Chat`
    public struct GetChat: DTSampleAppAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { DTSampleAppAPI.Objects.Chat }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", DTSampleAppAPI.ID.self),
        .field("name", String.self),
        .field("createdAt", DTSampleAppAPI.DateTime.self),
        .field("messages", [Message].self),
      ] }

      public var id: DTSampleAppAPI.ID { __data["id"] }
      public var name: String { __data["name"] }
      public var createdAt: DTSampleAppAPI.DateTime { __data["createdAt"] }
      public var messages: [Message] { __data["messages"] }

      /// GetChat.Message
      ///
      /// Parent Type: `Message`
      public struct Message: DTSampleAppAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { DTSampleAppAPI.Objects.Message }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("text", String?.self),
          .field("createdAt", DTSampleAppAPI.DateTime.self),
        ] }

        public var text: String? { __data["text"] }
        public var createdAt: DTSampleAppAPI.DateTime { __data["createdAt"] }
      }
    }
  }
}
