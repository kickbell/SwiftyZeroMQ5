// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyZeroMQ5",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_11),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "SwiftyZeroMQ5",
            targets: ["SwiftyZeroMQ5"]
        ),
    ],
    targets: [
        .target(
            name: "CZeroMQ",
            path: "Sources/CZeroMQ",
            sources: ["CZeroMQ.c"],
            publicHeadersPath: "include",
            linkerSettings: [
                .linkedLibrary("c++")
            ]
        ),
        .target(
            name: "SwiftyZeroMQ5",
            dependencies: ["CZeroMQ", "libzmq"],
            path: "Sources",
            exclude: ["Info.plist", "CZeroMQ", "zmq.h", "SwiftyZeroMQ.h"],
            sources: [
                "Context.swift",
                "Poller.swift",
                "Socket.swift",
                "SocketEvents.swift",
                "SocketSendRecvOption.swift",
                "SocketType.swift",
                "SwiftyZeroMQ.swift",
                "ZeroMQError.swift"
            ],
            linkerSettings: [
                .linkedLibrary("sodium")
            ]
        ),
        .binaryTarget(
            name: "libzmq",
            path: "Libraries/libzmq.xcframework"
        ),
        .testTarget(
            name: "SwiftyZeroMQ5Tests",
            dependencies: ["SwiftyZeroMQ5"],
            path: "Tests",
            exclude: ["Info.plist"]
        )
    ]
)