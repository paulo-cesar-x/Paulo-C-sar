#!/usr/bin/env bash
set -euo pipefail
source "$HOME/.local/share/swiftly/env.sh"
export PATH="$HOME/.local/bin:$PATH"
export APPIMAGE_EXTRACT_AND_RUN=1
PROJECT="/mnt/c/Users/paulo/Documents/Projetos/CalculadoraXTool"
echo "Preparando compilacao local iOS, sem login Apple..."
if xtool sdk status | grep -qi '^Not installed'; then
  XCODE="$(find /mnt/c/Users/paulo/Downloads /mnt/d -maxdepth 2 -type f -iname 'Xcode*.xip' -print -quit 2>/dev/null || true)"
  PREBUILT="$(find /mnt/c/Users/paulo/Downloads /mnt/d -maxdepth 2 -type f -iname '*.xtoolsdk' -print -quit 2>/dev/null || true)"
  if [[ -n "$XCODE" ]]; then
    echo "SDK iOS: instalando a partir do Xcode local..."
    xtool sdk install "$XCODE" --slim
  elif [[ -n "$PREBUILT" ]]; then
    echo "SDK iOS: instalando pacote local..."
    xtool sdk install "$PREBUILT"
  else
    echo "BLOQUEADO: SDK iOS nao disponivel."
    echo "Sem SDK, xtool nao consegue compilar SwiftUI para iPhone."
    echo "Instale um SDK extraido de Xcode obtido legitimamente."
    exit 2
  fi
fi
cd "$PROJECT"
swift --version
echo "Compilando calculadora para iOS, sem assinar..."
xtool dev build --configuration release --ipa
echo "Arquivos IPA gerados:"
find "$PROJECT" -name '*.ipa' -type f -print
echo "Nota: IPA sem assinatura nao pode ser instalado diretamente em um iPhone comum."
