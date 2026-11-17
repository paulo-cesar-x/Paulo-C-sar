# Calculadora XTool para iPhone

Aplicativo SwiftUI para iPhone (iOS 17+) criado na DESKTOP-PMVQPDD.

Funcionalidades: quatro operacoes, virgula decimal, porcentagem, inversao do sinal, apagar um digito, limpar e tratamento de divisao por zero.

## Status validado
- Windows 11 e WSL Ubuntu 24.04.
- Swift 6.4.2 corrigido, validado via swift --version.
- xtool 1.24.0 instalado.
- swift package dump-package: valido.
- 10 testes funcionais da calculadora aprovados.
- SDK iOS: NAO instalado.
- IPA: NAO gerado.
- Conta Apple: nao utilizada.

## Gerar localmente, sem login Apple
O SwiftUI precisa de SDK da plataforma iOS, que normalmente se extrai do Xcode.xip.
O xtool nao inclui esse SDK por questoes de licenciamento.
Com um Xcode.xip obtido legitimamente na pasta Downloads, ou um SDK ja preparado,
execute no Windows: Gerar-IPA-iPhone.cmd

O comando tenta instalar o SDK e roda:
xtool dev build --configuration release --ipa

O IPA resultante NAO sera assinado e, por isso, nao sera instalavel diretamente
em iPhone comum. A assinatura posterior exige credenciais/provisionamento Apple.

## Compilacao independente
Rode Testar-Calculadora.cmd para executar os 10 testes offline de logica.
