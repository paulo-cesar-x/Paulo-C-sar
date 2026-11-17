import SwiftUI

struct ContentView: View {
    @State private var calculator = CalculatorEngine()
    private let keys = [
        "AC", "±", "%", "÷",
        "7", "8", "9", "×",
        "4", "5", "6", "−",
        "1", "2", "3", "+",
        "⌫", "0", ",", "="
    ]
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)
    private let background = Color(red: 0.065, green: 0.075, blue: 0.10)
    private let accent = Color(red: 0.97, green: 0.58, blue: 0.19)

    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            VStack(alignment: .trailing, spacing: 18) {
                HStack(spacing: 8) {
                    Image(systemName: "plus.forwardslash.minus")
                        .foregroundStyle(accent)
                    Text("CALCULADORA")
                        .tracking(2.2)
                        .foregroundStyle(.white.opacity(0.65))
                }
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 12)
                Spacer(minLength: 12)
                Text(calculator.displayText)
                    .font(.system(size: 66, weight: .light, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.35)
                    .frame(maxWidth: .infinity, minHeight: 90, alignment: .trailing)
                    .accessibilityIdentifier("resultado")
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(keys, id: \.self) { key in
                        Button {
                            calculator.press(key)
                        } label: {
                            Text(key)
                                .font(.system(size: key == "AC" ? 24 : 31,
                                              weight: .medium,
                                              design: .rounded))
                                .foregroundStyle(foreground(for: key))
                                .frame(maxWidth: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .background(
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .fill(fill(for: key))
                                )
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(accessibilityText(for: key))
                    }
                }
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: 480)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func fill(for key: String) -> Color {
        if key == "=" { return accent }
        if ["÷", "×", "−", "+"].contains(key) {
            return Color(red: 0.19, green: 0.22, blue: 0.28)
        }
        if ["AC", "±", "%", "⌫"].contains(key) {
            return Color(red: 0.28, green: 0.30, blue: 0.35)
        }
        return Color(red: 0.14, green: 0.16, blue: 0.20)
    }

    private func foreground(for key: String) -> Color {
        if key == "=" { return .black }
        if ["÷", "×", "−", "+"].contains(key) { return accent }
        return .white
    }

    private func accessibilityText(for key: String) -> String {
        switch key {
        case "AC": return "Limpar"
        case "±": return "Alterar sinal"
        case "%": return "Porcentagem"
        case "⌫": return "Apagar último dígito"
        case "÷": return "Dividir"
        case "×": return "Multiplicar"
        case "−": return "Subtrair"
        case "+": return "Somar"
        case "=": return "Igual"
        case ",": return "Vírgula decimal"
        default: return key
        }
    }
}
