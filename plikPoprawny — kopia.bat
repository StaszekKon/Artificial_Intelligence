@echo off
setlocal
git remote update > nul 2>&1
set /a behind=%(git rev-list --count HEAD..origin/master)% 2> nul
echo %behind%
endlocal
pause