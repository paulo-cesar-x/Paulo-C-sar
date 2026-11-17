#!/usr/bin/env bash
set -euo pipefail
if [[ -f "$HOME/.local/share/swiftly/env.sh" ]]; then
  source "$HOME/.local/share/swiftly/env.sh"
fi
export PATH="$HOME/.local/bin:$PATH"
export APPIMAGE_EXTRACT_AND_RUN=1
cd /mnt/c/Users/paulo/Documents/Projetos/CalculadoraXTool
xtool dev
