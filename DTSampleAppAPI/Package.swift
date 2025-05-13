// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "DTSampleAppAPI",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "DTSampleAppAPI", targets: ["DTSampleAppAPI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios", exact: "1.21.0"),
  ],
  targets: [
    .target(
      name: "DTSampleAppAPI",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
  ]
)
