// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Codeglyphs",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Codeglyphs",
            targets: ["Codeglyphs"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Codeglyphs",
            dependencies: [],
            path: "Sources/Codeglyphs"
        ),
        .testTarget(
            name: "CodeglyphsTests",
            dependencies: ["Codeglyphs"],
            path: "Tests/CodeglyphsTests"
        ),
    ]
)
