@echo on

git remote update > nul 2>&1

git rev-list --count HEAD..origin/master > test.txt
set cos=< test.txt

pause