// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "CataKit",
    platforms: [.iOS(.v26)],
    products: [
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Data", targets: ["Data"]),
        .library(name: "ContentBundle", targets: ["ContentBundle"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "TestSupport", targets: ["TestSupport"]),
    ],
    targets: [
        .target(
            name: "Domain"
        ),
        .target(
            name: "ContentBundle",
            resources: [.copy("Resources")]
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
    ],
    swiftLanguageModes: [.v6]
)
