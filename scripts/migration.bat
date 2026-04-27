@echo off
setlocal

set "PROJECT=%~dp0..\src\Schuly.Infrastructure"
set "STARTUP=%~dp0..\src\Schuly.API"
set "COMMAND=%~1"

if "%COMMAND%"=="" goto :usage

if /i "%COMMAND%"=="add" (
    if "%~2"=="" (
        echo Error: migration name required.
        echo Example: migration add InitialCreate
        exit /b 1
    )
    dotnet ef migrations add %~2 --project %PROJECT% --startup-project %STARTUP%
    exit /b %errorlevel%
)

if /i "%COMMAND%"=="remove" (
    dotnet ef migrations remove --project %PROJECT% --startup-project %STARTUP%
    exit /b %errorlevel%
)

if /i "%COMMAND%"=="list" (
    dotnet ef migrations list --project %PROJECT% --startup-project %STARTUP%
    exit /b %errorlevel%
)

if /i "%COMMAND%"=="update" (
    if "%~2"=="" (
        dotnet ef database update --project %PROJECT% --startup-project %STARTUP%
    ) else (
        dotnet ef database update %~2 --project %PROJECT% --startup-project %STARTUP%
    )
    exit /b %errorlevel%
)

if /i "%COMMAND%"=="drop" (
    dotnet ef database drop --project %PROJECT% --startup-project %STARTUP%
    exit /b %errorlevel%
)

:usage
echo Usage:
echo   migration add ^<Name^>    Add a new migration
echo   migration remove        Remove the last migration
echo   migration list          List all migrations
echo   migration update [Name] Apply migrations
echo   migration drop          Drop the database
exit /b 1
