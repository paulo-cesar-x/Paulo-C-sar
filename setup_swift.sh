#!/usr/bin/env bash
set -euo pipefail
ARCH="$(uname -m)"
WORK="$HOME/.cache/calculadoraxtool"
mkdir -p "$WORK"
cd "$WORK"
echo "Instalando Swiftly para $ARCH..."
curl --fail --location --retry 2 \
  "https://download.swift.org/swiftly/linux/swiftly-$ARCH.tar.gz" \
  --output "swiftly-$ARCH.tar.gz"
tar zxf "swiftly-$ARCH.tar.gz"
./swiftly init --assume-yes --quiet-shell-followup --skip-install
source "$HOME/.local/share/swiftly/env.sh"
swiftly install 6.4.2 --assume-yes --use
swift --version
