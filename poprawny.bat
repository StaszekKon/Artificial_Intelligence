@echo off

setlocal

set "remote=origin"
set "branch=master"

git fetch %remote% %branch%

for /f "delims=" %%i in ('git log HEAD..%remote%/%branch% --oneline') do (
    set changes=true
)

if defined changes (
    git pull %remote% %branch%
)

endlocal
pause