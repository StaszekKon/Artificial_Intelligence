@@echo off

setlocal
set "remote=origin"
set "branch=master"
set /p choice=Chcesz zaktualizowac lokalne repozytorium? (y/n)
if "%choice%"=="y" (
    
    git fetch %remote% %branch%
    echo The local repository is up to date 
    for /f "delims=" %%i in ('git log HEAD..%remote%/%branch% --oneline') do (
      set changes=true
    )

    if defined changes (
      git pull %remote% %branch%
      echo The local repository has been updated
    )
) else (
      echo The local repository update canceled.
)

endlocal
pause