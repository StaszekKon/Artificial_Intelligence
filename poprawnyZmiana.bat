@echo off

setlocal
set "remote=origin"
set "branch=master"
set /p choice=Chcesz zaktualizowac lokalne repozytorium? (y/n)
if "%choice%"=="y" (
    
    git fetch %remote% %branch%

    for /f "delims=" %%i in ('git log HEAD..%remote%/%branch% --oneline') do (
      set changes=true
    )

    if defined changes (
      git pull %remote% %branch%
    )
) else (
      echo Aktualizacja lokalnego repozytorium zostala anulowana.
)



endlocal
pause