@echo off

git remote update > nul 2>&1
set /a behind=%(git rev-list --count HEAD..origin/master)%

if %behind%==0 (
    echo Nie ma zmian do pobrania.
) else (
    git pull
    echo Zaktualizowano lokalne repozytorium.
)
pause