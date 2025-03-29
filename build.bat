@echo off
setlocal enabledelayedexpansion

if "%1"=="" (
    echo Usage: build.bat [firmware^|nestang^|snestang^|gbatang^|mdtang^|all^|package]
    exit /b 1
)

set "ERROR_COUNT=0"
set "BUILD_ROOT=%~dp0"
cd %BUILD_ROOT%

:build_firmware
if /i "%1"=="firmware" (
    call :do_firmware
) else if /i "%1"=="nestang" (
    call :do_nestang
) else if /i "%1"=="snestang" (
    call :do_snestang
) else if /i "%1"=="gbatang" (
    call :do_gbatang
) else if /i "%1"=="mdtang" (
    call :do_mdtang
) else if /i "%1"=="smstang" (
    call :do_smstang
) else if /i "%1"=="monitor" (
    call :do_monitor
) else if /i "%1"=="all" (
    call :do_firmware
    call :do_nestang
    call :do_snestang
    call :do_gbatang
    call :do_mdtang
) else if /i "%1"=="package" (
    call :do_package
) else (
    echo Invalid command: %1
    echo Valid commands are: firmware, nestang, snestang, gbatang, mdtang, all, package
    exit /b 1
)

if !ERROR_COUNT! GTR 0 (
    echo Build completed with !ERROR_COUNT! errors.
    exit /b 1
) else (
    echo Build completed successfully.
    exit /b 0
)

:do_firmware
echo Building firmware...
cd firmware-bl616
call buildall.bat
if errorlevel 1 (
    echo Error building firmware
    set /a ERROR_COUNT+=1
)
cd %BUILD_ROOT%
exit /b

:do_nestang
echo Building NESTang...
cd nestang
call buildall.bat
if errorlevel 1 (
    echo Error building NESTang
    set /a ERROR_COUNT+=1
)
cd %BUILD_ROOT%
exit /b

:do_snestang
echo Building SNESTang...
cd snestang
call buildall.bat
if errorlevel 1 (
    echo Error building SNESTang
    set /a ERROR_COUNT+=1
)
cd %BUILD_ROOT%
exit /b

:do_gbatang
echo Building GBATang...
cd gbatang
call buildall.bat
if errorlevel 1 (
    echo Error building GBATang
    set /a ERROR_COUNT+=1
)
cd %BUILD_ROOT%
exit /b

:do_mdtang
echo Building MDTang...
cd mdtang
call buildall.bat
if errorlevel 1 (
    echo Error building MDTang
    set /a ERROR_COUNT+=1
)
cd %BUILD_ROOT%
exit /b

:do_smstang
echo Building SMSTang...
cd smstang
call buildall.bat
if errorlevel 1 (
    echo Error building SMSTang
    set /a ERROR_COUNT+=1
)
cd %BUILD_ROOT%
exit /b

:do_monitor
echo Building monitor...
cd monitor
call buildall.bat
if errorlevel 1 (
    echo Error building monitor
    set /a ERROR_COUNT+=1
)
cd %BUILD_ROOT%
exit /b

:do_package
echo Packaging artifacts...
if not exist "build" mkdir build
if not exist "build\firmware-bl616" mkdir build\firmware-bl616
if not exist "build\cores" mkdir build\cores
if not exist "build\cores\primer25k" mkdir build\cores\primer25k
if not exist "build\cores\mega60k" mkdir build\cores\mega60k
if not exist "build\cores\mega138k" mkdir build\cores\mega138k
if not exist "build\cores\console60k" mkdir build\cores\console60k
if not exist "build\cores\console138k" mkdir build\cores\console138k

echo Copy firmware files
xcopy /y /s "firmware-bl616\buildall\*" "build\firmware-bl616\" >nul 2>&1
if errorlevel 1 (
    echo Warning: Some firmware files could not be copied
    set /a ERROR_COUNT+=1
)

echo Copy NESTang files
copy /y "nestang\impl\pnr\nestang_primer25k_ds2.bin" "build\cores\primer25k\nestang.bin"
copy /y "nestang\impl\pnr\nestang_mega60k_ds2.bin" "build\cores\mega60k\nestang.bin"
copy /y "nestang\impl\pnr\nestang_mega138k_ds2.bin" "build\cores\mega138k\nestang.bin"
copy /y "nestang\impl\pnr\nestang_console60k_ds2.bin" "build\cores\console60k\nestang.bin"
copy /y "nestang\impl\pnr\nestang_console138k_ds2.bin" "build\cores\console138k\nestang.bin"
if errorlevel 1 (
    echo Warning: Some NESTang files could not be copied
    set /a ERROR_COUNT+=1
)

echo Copy SNESTang files
copy /y "snestang\impl\pnr\snestang_primer25k_ds2.bin" "build\cores\primer25k\snestang.bin"
copy /y "snestang\impl\pnr\snestang_mega60k_ds2.bin" "build\cores\mega60k\snestang.bin"
copy /y "snestang\impl\pnr\snestang_mega138k_ds2.bin" "build\cores\mega138k\snestang.bin"
copy /y "snestang\impl\pnr\snestang_console60k_ds2.bin" "build\cores\console60k\snestang.bin"
copy /y "snestang\impl\pnr\snestang_console138k_ds2.bin" "build\cores\console138k\snestang.bin"
if errorlevel 1 (
    echo Warning: Some SNESTang files could not be copied
    set /a ERROR_COUNT+=1
)

echo Copy GBATang files
copy /y "gbatang\impl\pnr\gbatang_mega60k.bin" "build\cores\mega60k\gbatang.bin"
copy /y "gbatang\impl\pnr\gbatang_mega138k.bin" "build\cores\mega138k\gbatang.bin"
copy /y "gbatang\impl\pnr\gbatang_console60k.bin" "build\cores\console60k\gbatang.bin"
copy /y "gbatang\impl\pnr\gbatang_console138k.bin" "build\cores\console138k\gbatang.bin"
if errorlevel 1 (
    echo Warning: Some GBATang files could not be copied
    set /a ERROR_COUNT+=1
)

echo Copy MDTang files
copy /y "mdtang\impl\pnr\mdtang_mega60k.bin" "build\cores\mega60k\mdtang.bin"
copy /y "mdtang\impl\pnr\mdtang_mega138k.bin" "build\cores\mega138k\mdtang.bin"
copy /y "mdtang\impl\pnr\mdtang_console60k.bin" "build\cores\console60k\mdtang.bin"
copy /y "mdtang\impl\pnr\mdtang_console138k.bin" "build\cores\console138k\mdtang.bin"
if errorlevel 1 (
    echo Warning: Some MDTang files could not be copied
    set /a ERROR_COUNT+=1
)

echo Copy SMSTang files
copy /y "smstang\impl\pnr\smstang_console60k.bin" "build\cores\console60k\smstang.bin"
copy /y "smstang\impl\pnr\smstang_console138k.bin" "build\cores\console138k\smstang.bin"
if errorlevel 1 (
    echo Warning: Some SMSTang files could not be copied
    set /a ERROR_COUNT+=1
)

echo Copy monitor files
copy /y "monitor\impl\pnr\monitor_primer25k.bin" "build\cores\primer25k\monitor.bin"
copy /y "monitor\impl\pnr\monitor_mega60k.bin" "build\cores\mega60k\monitor.bin"
copy /y "monitor\impl\pnr\monitor_mega138k.bin" "build\cores\mega138k\monitor.bin"
copy /y "monitor\impl\pnr\monitor_console60k.bin" "build\cores\console60k\monitor.bin"
copy /y "monitor\impl\pnr\monitor_console138k.bin" "build\cores\console138k\monitor.bin"
if errorlevel 1 (
    echo Warning: Some monitor files could not be copied
    set /a ERROR_COUNT+=1
)

echo Package created in build directory
exit /b 