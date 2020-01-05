// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TLS",
    products: [
        .library(name: "TLS", targets: ["TLS"])
    ],
    dependencies: [
        .package(path: "../Platform"),
        .package(path: "../Crypto"),
        .package(path: "../Stream"),
        .package(path: "../Test")
    ],
    targets: [
        .target(name: "TLS", dependencies: ["Platform", "Crypto", "Stream"]),
        .testTarget(name: "TLSTests", dependencies: ["TLS", "Test"])
    ]
)
