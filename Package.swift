// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftMVC",
    platforms: [
        .iOS("13.4"),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftMVC",
            targets: ["MVC","FileIO"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "MVC",
            dependencies: [.product(name: "Logging", package: "swift-log"), .byName(name: "FileIO")]),
        .target(
            name: "FileIO",
            dependencies: [.product(name: "Logging", package: "swift-log")]),
        .testTarget(
            name: "SwiftMVCTests",
            dependencies: ["MVC"]),
    ]
)
