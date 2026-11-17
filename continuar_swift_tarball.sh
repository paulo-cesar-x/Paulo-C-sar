#!/usr/bin/env bash
set -euo pipefail
cd /root/.cache/calculadoraxtool
URL="https://download.swift.org/swift-6.4.2-release/ubuntu2404/swift-6.4.2-RELEASE/swift-6.4.2-RELEASE-ubuntu24.04.tar.gz"
echo "Retomando arquivo oficial Swift com verificação..."
curl --fail --location --continue-at - --retry 5 --retry-delay 2 --connect-timeout 15 --speed-time 20 --speed-limit 1024 --max-time 180 --show-error "$URL" --output swift-6.4.2-ubuntu24.04.tar.gz
echo "Verificando integridade da compactação..."
tar -tzf swift-6.4.2-ubuntu24.04.tar.gz > /tmp/calculadora-swift-tar-list.txt
echo "Restaurando toolchain com tar do sistema..."
tar -xzf swift-6.4.2-ubuntu24.04.tar.gz --strip-components=1 -C /root/.local/share/swiftly/toolchains/6.4.2
/root/.local/share/swiftly/bin/swiftly use 6.4.2
echo "Versao do Swift:"
/root/.local/share/swiftly/bin/swift --version
echo "Testes:"
bash /mnt/c/Users/paulo/Documents/Projetos/CalculadoraXTool/test_engine.sh
