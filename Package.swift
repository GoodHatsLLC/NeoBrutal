// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NeoBrutalistUI",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v17),
    .macOS(.v15),
  ],
  products: [
    .library(
      name: "NeoBrutalistUI",
      targets: ["NeoBrutalistUI"]
    ),
    .executable(
      name: "NeoBrutalistDemo",
      targets: ["NeoBrutalistDemo"]
    ),
    .executable(
      name: "NeoBrutalistSnapshots",
      targets: ["NeoBrutalistSnapshots"]
    ),
    .executable(
      name: "NeoBrutalistWindowSnapshots",
      targets: ["NeoBrutalistWindowSnapshots"]
    ),
  ],
  targets: [
    .target(
      name: "NeoBrutalistUI",
      resources: [
        .process("Resources")
      ]
    ),
    .executableTarget(
      name: "NeoBrutalistDemo",
      dependencies: ["NeoBrutalistUI"],
      path: "Examples/NeoBrutalistDemo"
    ),
    .executableTarget(
      name: "NeoBrutalistSnapshots",
      dependencies: ["NeoBrutalistUI"],
      path: "Examples/NeoBrutalistSnapshots",
      exclude: ["README.md"]
    ),
    .executableTarget(
      name: "NeoBrutalistWindowSnapshots",
      dependencies: ["NeoBrutalistUI"],
      path: "Examples/NeoBrutalistWindowSnapshots"
    ),
    .testTarget(
      name: "NeoBrutalistUITests",
      dependencies: ["NeoBrutalistUI"]
    ),
  ]
)
