@ECHO OFF
forfiles -p "C:\Users\hacker\Desktop" /s /m * /D -1 /C "cmd /c del /Q @path && rmdir /S /Q @path"
REM forfiles -p "C:\Users\hacker\Downloads" /s /m * /D -1 /C "cmd /c del @path"
REM forfiles -p "C:\Users\hacker\Documents" /s /m * /D -1 /C "cmd /c del @path"
