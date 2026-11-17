// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CalculadoraXTool",
    platforms: [.iOS(.v17)],
    products: [.library(name: "CalculadoraXTool", targets: ["CalculadoraXTool"])],
    targets: [.target(name: "CalculadoraXTool")]
)
