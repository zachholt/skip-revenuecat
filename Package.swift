// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription

let package = Package(
    name: "skip-revenuecat",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "SkipRevenueCat",
            targets: [
                "SkipRevenueCat",
                "SkipRevenueCatLibrary",
            ])
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.6.8"),
        .package(url: "https://source.skip.tools/skip-foundation.git", from: "1.3.8"),
        .package(url: "https://github.com/RevenueCat/purchases-hybrid-common.git", from: "15.0.0"),
    ],
    targets: [
        .target(
            name: "SkipRevenueCat",
            dependencies: [
                .product(name: "SkipFoundation", package: "skip-foundation"),
                .product(name: "PurchasesHybridCommon", package: "purchases-hybrid-common"),
                .product(name: "PurchasesHybridCommonUI", package: "purchases-hybrid-common"),
                "SkipRevenueCatLibrary",
            ],
            exclude: [
                "../../skip-revenuecat-library/",
                "../../skip-revenuecat-app/",
            ],
            resources: [],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        //  .binaryTarget(
        //      name: "SkipRevenueCatLibrary",
        //      path: "./skip-revenuecat-library/skip-revenuecat-library/build/XCFrameworks/release/SkipRevenueCatLibrary.xcframework"
        //  ),
        .binaryTarget(
            name: "SkipRevenueCatLibrary",
            url:
                "https://github.com/aduryagin/skip-revenuecat/releases/download/0.0.14/SkipRevenueCatLibrary.xcframework.zip",
            checksum: "4573ad749415f6422031b3320495f691753fd6f6c0903c52fc79d1a792ff9680"
        ),
        .testTarget(
            name: "SkipRevenueCatTests",
            dependencies: [
                "SkipRevenueCat",
                .product(name: "SkipTest", package: "skip"),
            ],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
    ]
)
