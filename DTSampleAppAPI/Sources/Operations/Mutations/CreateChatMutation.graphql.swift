// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateChatMutation: GraphQLMutation {
  public static let operationName: String = "CreateChat"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateChat($name: String!) { createChat(name: $name) { __typename id name createdAt } }"#
    ))

  public var name: String

  public init(name: String) {
    self.name = name
  }

  public var __variables: Variables? { ["name": name] }

  public struct Data: DTSampleAppAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { DTSampleAppAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createChat", CreateChat.self, arguments: ["name": .variable("name")]),
    ] }

    public var createChat: CreateChat { __data["createChat"] }

    /// CreateChat
    ///
    /// Parent Type: `Chat`
    public struct CreateChat: DTSampleAppAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { DTSampleAppAPI.Objects.Chat }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", DTSampleAppAPI.ID.self),
        .field("name", String.self),
        .field("createdAt", DTSampleAppAPI.DateTime.self),
      ] }

      public var id: DTSampleAppAPI.ID { __data["id"] }
      public var name: String { __data["name"] }
      public var createdAt: DTSampleAppAPI.DateTime { __data["createdAt"] }
    }
  }
}
