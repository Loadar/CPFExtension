// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CPFExtensions",
    products: [
        .library(
            name: "CPFExtensions",
            targets: ["CPFExtensions"]),
        .library(
            name: "CPFExtensions-Dynamic",
            type: .dynamic,
            targets: ["CPFExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Loadar/CPFChain.git", from: Version(stringLiteral: "2.2.3")),
    ],
    targets: [
        .target(
            name: "CPFExtensions",
            dependencies: ["CPFChain"]),
    ]
)
