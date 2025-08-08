// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "xcode-indexstore-debug",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.2.0"
        ),
        .package(
            url: "https://github.com/kateinoigakukun/swift-indexstore.git",
            from: "0.3.0"
        ),
    ],
    targets: [
        .executableTarget(
            name: "xcode-indexstore-debug",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftIndexStore", package: "swift-indexstore"),
            ]
        ),
        .target(
            name: "XcodeIndexStoreDebugCore",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftIndexStore", package: "swift-indexstore"),
            ]
        ),
    ]
)
