// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Prelude",
    products: [
        .library(
            name: "Prelude",
            targets: ["Prelude"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Prelude",
            dependencies: []),
        .testTarget(
            name: "PreludeTests",
            dependencies: ["Prelude"]),
    ]
)
