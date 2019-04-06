// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TLS",
    products: [
        .library(name: "TLS", targets: ["TLS"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tris-code/platform.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/crypto.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/stream.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/test.git",
            .branch("master"))
    ],
    targets: [
        .target(name: "TLS", dependencies: ["Platform", "Crypto", "Stream"]),
        .testTarget(name: "TLSTests", dependencies: ["TLS", "Test"])
    ]
)
