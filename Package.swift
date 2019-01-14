// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "TLS",
    products: [
        .library(name: "TLS", targets: ["TLS"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tris-foundation/platform.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/crypto.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/stream.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/test.git",
            .branch("master"))
    ],
    targets: [
        .target(name: "TLS", dependencies: ["Platform", "Crypto", "Stream"]),
        .testTarget(name: "TLSTests", dependencies: ["TLS", "Test"])
    ]
)
