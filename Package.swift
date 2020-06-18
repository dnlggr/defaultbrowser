// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "DefaultBrowser",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.1.0"))
    ],
    targets: [
        .target(name: "DefaultBrowser", dependencies: [
            "DefaultBrowserCore",
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
        .target(name: "DefaultBrowserCore")
    ]
)
