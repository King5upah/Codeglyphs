// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Codeglyphs",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "Codeglyphs",
            targets: ["Codeglyphs"]),
    ],
    dependencies: [
        // AI-ready syntax highlighting often benefits from Splash or SwiftSyntax
    ],
    targets: [
        .target(
            name: "Codeglyphs",
            dependencies: []),
        .testTarget(
            name: "CodeglyphsTests",
            dependencies: ["Codeglyphs"]),
    ]
)
