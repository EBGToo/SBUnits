// swift-tools-version:5.5
//
//  Package.swift
//  SBUnits
//
//  Created by Ed Gamble on 12/3/15.
//  Copyright © 2015 Edward B. Gamble Jr.  All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//  See the CONTRIBUTORS file at the project root for a list of contributors.
//
import PackageDescription

let package = Package(
    name: "SBUnits",
    platforms: [
        .macOS("11.1")
    ],

    products: [
        .library(
            name: "SBUnits",
            targets: ["SBUnits"]),
    ],

    dependencies: [
    ],

    targets: [
        .target(
            name: "SBUnits",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SBUnitsTests",
            dependencies: ["SBUnits"],
            path: "Tests"
        ),
    ]
)
