@echo off

setlocal
set /p choice=Chcesz zaktualizować lokalne repozytorium? (tak/nie)
if "%choice%"=="tak" (
    set "remote=origin"
    set "branch=master"
    git fetch %remote% %branch%

    for /f "delims=" %%i in ('git log HEAD..%remote%/%branch% --oneline') do (
     set changes=true
    )

    if defined changes (
      git pull %remote% %branch%
    )
) else (
      echo Aktualizacja lokalnego repozytorium została anulowana.
)



endlocal
pause