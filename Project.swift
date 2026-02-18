import ProjectDescription

let project = Project(
    name: "Codeglyphs",
    targets: [
        .target(
            name: "Codeglyphs",
            destinations: .iOS,
            product: .framework,
            bundleId: "rodolfo.Codeglyphs",
            infoPlist: .default,
            sources: ["Sources/Codeglyphs/**"],
            dependencies: []
        ),
        .target(
            name: "CodeglyphsDemo",
            destinations: .iOS,
            product: .app,
            bundleId: "rodolfo.CodeglyphsDemo",
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": "",
                ],
            ]),
            sources: ["Sources/CodeglyphsDemo/**"],
            resources: ["Resources/**"],
            dependencies: [
                .target(name: "Codeglyphs")
            ]
        ),
        .target(
            name: "CodeglyphsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "rodolfo.CodeglyphsTests",
            infoPlist: .default,
            sources: ["Tests/CodeglyphsTests/**"],
            dependencies: [
                .target(name: "Codeglyphs")
            ]
        ),
    ],
    schemes: [
        .scheme(
            name: "CodeglyphsDemo",
            shared: true,
            buildAction: .buildAction(targets: ["CodeglyphsDemo"]),
            runAction: .runAction(executable: "CodeglyphsDemo")
        )
    ]
)
