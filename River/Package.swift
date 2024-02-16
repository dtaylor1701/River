// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "River",
  platforms: [.macOS(.v13)],
  products: [
    .executable(name: "River", targets: ["River"]),
    .library(name: "RiverKit", targets: ["RiverKit"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    .package(url: "https://github.com/dtaylor1701/Twigs.git", branch: "main"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .executableTarget(
      name: "River",
      dependencies: ["RiverKit"],
      path: "CommandLine"),
    .target(
      name: "RiverKit",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "Twigs", package: "Twigs"),
      ],
      path: "Sources",
      resources: [
        .copy("CopyResources")
      ]),
  ]
)
