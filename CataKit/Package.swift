// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "CataKit",
    platforms: [.iOS(.v26), .macOS(.v14)],
    products: [
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Data", targets: ["Data"]),
        .library(name: "ContentBundle", targets: ["ContentBundle"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "TestSupport", targets: ["TestSupport"]),
        .library(name: "GrapesFeature", targets: ["GrapesFeature"]),
    ],
    targets: [
        .target(
            name: "Domain"
        ),
        .target(
            name: "ContentBundle",
            resources: [.copy("Content")]
        ),
        .target(
            name: "Data",
            dependencies: ["Domain", "ContentBundle"]
        ),
        .target(
            name: "DesignSystem"
        ),
        .target(
            name: "TestSupport",
            dependencies: ["Domain"]
        ),
        .target(
            name: "GrapesFeature",
            dependencies: ["Domain", "DesignSystem"],
            resources: [.process("Strings")]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data", "TestSupport"]
        ),
        .testTarget(
            name: "ContentTests",
            dependencies: ["Data", "ContentBundle"]
        ),
        .testTarget(
            name: "GrapesFeatureTests",
            dependencies: ["GrapesFeature", "TestSupport"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
