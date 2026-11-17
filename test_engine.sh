#!/usr/bin/env bash
set -euo pipefail
cd /mnt/c/Users/paulo/Documents/Projetos/CalculadoraXTool
if [[ -f "$HOME/.local/share/swiftly/env.sh" ]]; then
  source "$HOME/.local/share/swiftly/env.sh"
fi
swiftc Sources/CalculadoraXTool/CalculatorEngine.swift \
  Tests/EngineSmokeTests.swift -o /tmp/calculadora-xtool-tests
/tmp/calculadora-xtool-tests
