import Foundation

struct CalculatorEngine {
    private enum Operation { case add, subtract, multiply, divide }

    private(set) var display = "0"
    private var storedValue: Double?
    private var operation: Operation?
    private var expectsNewNumber = true

    var displayText: String {
        display == "Erro" ? display : display.replacingOccurrences(of: ".", with: ",")
    }

    mutating func press(_ key: String) {
        switch key {
        case "AC": clear()
        case "±": toggleSign()
        case "%": percentage()
        case ",": decimalPoint()
        case "⌫": backspace()
        case "+": choose(.add)
        case "−": choose(.subtract)
        case "×": choose(.multiply)
        case "÷": choose(.divide)
        case "=": equals()
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9": digit(key)
        default: break
        }
    }

    private mutating func clear() {
        display = "0"
        storedValue = nil
        operation = nil
        expectsNewNumber = true
    }

    private mutating func digit(_ value: String) {
        if expectsNewNumber || display == "Erro" {
            display = value
            expectsNewNumber = false
        } else if display == "0" {
            display = value
        } else if display == "-0" {
            display = "-" + value
        } else if display.filter({ $0.isNumber }).count < 12 {
            display += value
        }
    }

    private mutating func decimalPoint() {
        if expectsNewNumber || display == "Erro" {
            display = "0."
            expectsNewNumber = false
        } else if !display.contains(".") {
            display += "."
        }
    }

    private mutating func toggleSign() {
        guard display != "Erro", display != "0" else { return }
        if display.hasPrefix("-") {
            display.removeFirst()
        } else {
            display = "-" + display
        }
    }

    private mutating func percentage() {
        guard let value = Double(display) else { return }
        showResult(value / 100)
    }

    private mutating func backspace() {
        guard !expectsNewNumber, display != "Erro" else {
            display = "0"
            expectsNewNumber = false
            return
        }
        display.removeLast()
        if display.isEmpty || display == "-" { display = "0" }
    }

    private mutating func choose(_ nextOperation: Operation) {
        guard let number = Double(display) else { return }
        if let previous = storedValue, let currentOperation = operation, !expectsNewNumber {
            guard let result = calculate(previous, number, currentOperation) else {
                showError()
                return
            }
            showResult(result)
            storedValue = result
        } else {
            storedValue = number
        }
        operation = nextOperation
        expectsNewNumber = true
    }

    private mutating func equals() {
        guard let previous = storedValue,
              let currentOperation = operation,
              let number = Double(display) else { return }
        guard let result = calculate(previous, number, currentOperation) else {
            showError()
            return
        }
        showResult(result)
        storedValue = nil
        operation = nil
        expectsNewNumber = true
    }

    private func calculate(_ lhs: Double, _ rhs: Double, _ operation: Operation) -> Double? {
        switch operation {
        case .add: return lhs + rhs
        case .subtract: return lhs - rhs
        case .multiply: return lhs * rhs
        case .divide: return rhs == 0 ? nil : lhs / rhs
        }
    }

    private mutating func showError() {
        display = "Erro"
        storedValue = nil
        operation = nil
        expectsNewNumber = true
    }

    private mutating func showResult(_ number: Double) {
        guard number.isFinite else { showError(); return }
        let normalized = abs(number) < 0.000000000001 ? 0.0 : number
        if abs(normalized) >= 1_000_000_000_000 ||
           (abs(normalized) > 0 && abs(normalized) < 0.00000001) {
            display = String(format: "%.6e", normalized)
        } else {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.numberStyle = .decimal
            formatter.usesGroupingSeparator = false
            formatter.maximumFractionDigits = 8
            formatter.minimumFractionDigits = 0
            display = formatter.string(from: NSNumber(value: normalized)) ?? "Erro"
        }
        expectsNewNumber = true
    }
}
