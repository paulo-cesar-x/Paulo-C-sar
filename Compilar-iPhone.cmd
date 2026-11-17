@echo off
title Calculadora XTool - Compilar e instalar no iPhone
wsl.exe -d Ubuntu -e bash /mnt/c/Users/paulo/Documents/Projetos/CalculadoraXTool/compilar.sh
echo.
echo Confira as mensagens acima. Se faltar autenticacao Apple ou SDK, execute xtool setup no WSL.
pause
