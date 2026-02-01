// swift-tools-version:5.7
import PackageDescription

let package = Package(
	name: "tmignore",
	platforms: [
		.macOS(.v10_13)
	],
	products: [
		.executable(name: "tmignore", targets: ["tmignore"])
	],
	dependencies: [
		.package(url: "https://github.com/jakeheis/SwiftCLI", from: "6.0.1"),
		.package(url: "https://github.com/apple/swift-log", from: "1.5.0"),
	],
	targets: [
		.executableTarget(
			name: "tmignore",
			dependencies: [
				.product(name: "SwiftCLI", package: "SwiftCLI"),
				.product(name: "Logging", package: "swift-log"),
			],
			path: "tmignore"
		),
	]
)
