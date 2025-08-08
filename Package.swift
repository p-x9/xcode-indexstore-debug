// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "xcode-indexstore-debug",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    targets: [
        .executableTarget(
            name: "XcodeIndexStoreDebug",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
    ]
)
