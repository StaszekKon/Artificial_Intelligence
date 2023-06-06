@@echo off

where /q git.exe

IF ERRORLEVEL 1 (
	ECHO Warning!!! No git.exe in Path 
) ELSE (
	git status oo.txt

	if not errorlevel 1 (
		echo !!!!
		echo Warning !!! oo.txt jest przestarzały!
		echo !!!
		choice /m " ---------------Czy chcesz zaktualizowac lokalba kopie? ------"
		if errorlevel 1 (
			git pull origin
		)
	)
)