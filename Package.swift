// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIPresent",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "SwiftUIPresent",
            targets: ["SwiftUIPresent"]),
    ],
    dependencies: [],
    targets: [.target(
            name: "SwiftUIPresent",
            dependencies: []),
        .testTarget(
            name: "SwiftUIPresentTests",
            dependencies: ["SwiftUIPresent"]),
    ]
)
