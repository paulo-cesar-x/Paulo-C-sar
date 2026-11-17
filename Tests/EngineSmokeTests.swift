import Foundation

@main
enum EngineSmokeTests {
    static func main() {
        verify("Soma", ["2", "+", "3", "="], "5")
        verify("Subtração", ["1", "2", "−", "7", "="], "5")
        verify("Multiplicação", ["7", "×", "9", "="], "63")
        verify("Divisão", ["8", "÷", "2", "="], "4")
        verify("Vírgula", ["1", ",", "5", "+", "2", ",", "3", "="], "3,8")
        verify("Porcentagem", ["5", "0", "%"], "0,5")
        verify("Troca de sinal", ["5", "±"], "-5")
        verify("Apagar dígito", ["1", "2", "⌫"], "1")
        verify("Divisão por zero", ["5", "÷", "0", "="], "Erro")
        verify("Limpar", ["5", "+", "2", "AC"], "0")
        print("10 testes de calculadora concluídos com sucesso.")
    }

    static func verify(_ name: String, _ keys: [String], _ expected: String) {
        var engine = CalculatorEngine()
        keys.forEach { engine.press($0) }
        guard engine.displayText == expected else {
            fatalError("\(name): esperado \(expected), obtido \(engine.displayText)")
        }
        print("OK: \(name)")
    }
}
