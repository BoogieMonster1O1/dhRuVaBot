// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "dhRuVaBot",
    platforms: [
        .macOS(.v12),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftcordApp/DiscordKit", branch: "main"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "dhRuVaBot",
            dependencies: [
                .product(name: "DiscordKitBot", package: "DiscordKit"),
                .product(name: "Alamofire", package: "Alamofire")
            ]
        )
    ]
)
