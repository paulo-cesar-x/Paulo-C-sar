#!/usr/bin/env bash
set -euo pipefail
echo "Instalando dependencias do Swift..."
apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq unzip zip gnupg2 libc6-dev libcurl4-openssl-dev libgcc-13-dev libpython3-dev libstdc++-13-dev libxml2-dev libncurses-dev libz3-dev pkg-config zlib1g-dev > /tmp/calculadora-deps.log 2>&1 || { tail -60 /tmp/calculadora-deps.log; exit 1; }
echo "Obtendo Swift oficial do swift.org..."
mkdir -p /root/.cache/calculadoraxtool
cd /root/.cache/calculadoraxtool
URL="https://download.swift.org/swift-6.4.2-release/ubuntu2404/swift-6.4.2-RELEASE/swift-6.4.2-RELEASE-ubuntu24.04.tar.gz"
curl --fail --location --retry 3 --continue-at - --silent --show-error "$URL" --output swift-6.4.2-ubuntu24.04.tar.gz
echo "Arquivo obtido. Testando a integridade do pacote..."
tar -tzf swift-6.4.2-ubuntu24.04.tar.gz > /tmp/calculadora-swift-tar-list.txt
echo "Extraindo com GNU tar (reparo da toolchain 6.4.2)..."
mkdir -p /root/.local/share/swiftly/toolchains/6.4.2
tar -xzf swift-6.4.2-ubuntu24.04.tar.gz --strip-components=1 -C /root/.local/share/swiftly/toolchains/6.4.2
echo "Corrigindo ferramenta ativa..."
/root/.local/share/swiftly/bin/swiftly use 6.4.2
echo "SWIFT VERSION:"
/root/.local/share/swiftly/bin/swift --version
echo "TESTES DO PROJETO:"
bash /mnt/c/Users/paulo/Documents/Projetos/CalculadoraXTool/test_engine.sh
