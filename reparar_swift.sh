#!/usr/bin/env bash
set -euo pipefail
source "$HOME/.local/share/swiftly/env.sh"
echo "Preparando Swift 6.4.1 para validar a toolchain..."
swiftly install 6.4.1 --assume-yes --use
echo "Versao ativa:"
swift --version
echo "Executando testes:"
bash /mnt/c/Users/paulo/Documents/Projetos/CalculadoraXTool/test_engine.sh
