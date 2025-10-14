// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NeoBrutal",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v17),
    .macOS(.v15),
  ],
  products: [
    .library(
      name: "NeoBrutal",
      targets: ["NeoBrutal"]
    ),
    .executable(
      name: "NeoBrutalDemo",
      targets: ["NeoBrutalDemo"]
    ),
    .executable(
      name: "NeoBrutalSnapshots",
      targets: ["NeoBrutalSnapshots"]
    ),
  ],
  targets: [
    .target(
      name: "NeoBrutal",
      resources: [
        .process("Resources")
      ]
    ),
    .executableTarget(
      name: "NeoBrutalDemo",
      dependencies: ["NeoBrutal"],
      path: "Sources/NeoBrutalDemo"
    ),
    .executableTarget(
      name: "NeoBrutalSnapshots",
      dependencies: ["NeoBrutal"],
      path: "Sources/NeoBrutalSnapshots",
      exclude: ["README.md"]
    ),
  ]
)
