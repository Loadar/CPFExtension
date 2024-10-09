// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CPFExtension",
    products: [
        .library(
            name: "CPFExtension",
            targets: ["CPFExtension"]),
        .library(
            name: "CPFExtensionDynamic",
            type: .dynamic,
            targets: ["CPFExtension"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Loadar/CPFChain.git", from: Version(stringLiteral: "2.2.7")),
    ],
    targets: [
        .target(
            name: "CPFExtension",
            dependencies: [.product(name: "CPFChainDynamic", package: "CPFChain")],
            path: "Sources"
        ),
    ]
)
