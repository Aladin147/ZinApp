@echo off
REM Get the local IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /r /c:"IPv4 Address"') do (
    set IP=%%a
    goto :found
)
:found
REM Remove leading space
set IP=%IP:~1%

echo Starting JSON Server on IP: %IP%
json-server --watch data/db.json --host localhost --port 3000
