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
            name: "CPFExtension-Dynamic",
            type: .dynamic,
            targets: ["CPFExtension"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Loadar/CPFChain.git", from: Version(stringLiteral: "2.2.5")),
    ],
    targets: [
        .target(
            name: "CPFExtension",
            dependencies: ["CPFChain"],
            path: "Sources",
            resources: [.copy("PrivacyInfo.xcprivacy")]
        ),
    ]
)
