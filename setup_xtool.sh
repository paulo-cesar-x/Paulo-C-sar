#!/usr/bin/env bash
set -euo pipefail
ARCH="$(uname -m)"
if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
  echo "Arquitetura nao suportada: $ARCH"
  exit 1
fi
mkdir -p "$HOME/.local/bin"
echo "Baixando xtool para $ARCH..."
curl --fail --location --retry 2 \
  "https://github.com/xtool-org/xtool/releases/latest/download/xtool-$ARCH.AppImage" \
  --output "$HOME/.local/bin/xtool"
chmod +x "$HOME/.local/bin/xtool"
echo "xtool salvo em $HOME/.local/bin/xtool"
echo "Adicione ao PATH: export PATH=\$HOME/.local/bin:\$PATH"
echo "Validando a ferramenta..."
APPIMAGE_EXTRACT_AND_RUN=1 "$HOME/.local/bin/xtool" --help | head -25
if command -v swift >/dev/null 2>&1; then
  swift --version
else
  echo "Swift ainda nao esta instalado. Consulte https://www.swift.org/install/linux/"
fi
echo "A configuracao Apple (xtool setup) e o SDK iOS permanecem interativos."
