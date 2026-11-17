#!/usr/bin/env bash
set -euo pipefail
cd /mnt/c/Users/paulo/Documents/Projetos/CalculadoraXTool
if [[ ! -d .git ]]; then
  git init -b main
fi
git add -A
if ! git diff --cached --quiet; then
  git -c user.name="ChatGPT Build" -c user.email="chatgpt-build@users.noreply.github.com" \
    commit -m "Criar calculadora iOS e workflow de IPA"
fi
if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin https://github.com/paulo-cesar-x/calculadora-iphone.git
fi
git status --short
git log -1 --format="%h %s"
git remote -v
echo "Repositorio Git preparado localmente. Para publicar: crie primeiro o repositorio privado no GitHub e autentique o git."
