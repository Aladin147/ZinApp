@echo off
echo Starting JSON Server...
REM Start json-server watching db.json, listening on localhost (127.0.0.1) and port 3000
json-server --watch data/db.json --host 127.0.0.1 --port 3000
echo JSON Server stopped.
pause
