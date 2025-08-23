@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ======================================================================================
rem CME-MAIN-001: script principal de generación PlantUML con validación previa
rem Archivo: creator.bat
rem Propósito: Llamar a ValidarEntorno y luego generar diagramas
rem Entorno: Windows 11, cmd, Batch v1.0
rem Uso: creator.bat <archivo.puml>
rem ======================================================================================

rem 1. VALIDAR ENTORNO
call :ValidarEntorno
if ERRORLEVEL 1 (
    call :ManejarError INSTALACION_JAVA
)

rem --- CME-FIX-02: Validar que se pase un archivo .puml como argumento ---
if ""%~1=="" (
    call :ManejarError ARG_FALTA
)

rem 2. PARÁMETROS Y RUTAS
set "INPUT=%~1"
set "OUTPUT=%~dp0output"
if not exist "%OUTPUT%" mkdir "%OUTPUT%"


rem 3. EJECUTAR PLANT UML
java -jar "%~dp0plantuml.jar" -o "%OUTPUT%" "%INPUT%"
if errorlevel 1 (
    call :ManejarError RENDER_FALLA
)

rem 4. MENSAJE DE ÉXITO
echo [INFO] Diagrama generado en "%OUTPUT%".
endlocal
exit /b 0

rem ===========================================================================================
rem SUBRUTINA VALIDAR ENTORNO
rem --------------------------------------------------------------------------------------------
rem Ficha CME - SR-001
rem Propósito: Subrutina encargada de validar la existencia de las dependencias del proyecto
rem            especialmente la presencia de Java dentro del PATH y el ejecutable plantpuml.jar
rem Entorno Windows cmd, ejecución local
rem Dependencias: java.exe, plantuml.jar
rem Trazabilidad: Invocable desde scripts pedagógicos o productivos
rem Autor: Diego Benjumea - Redfyr
rem Fecha: 2025-08-22
rem: Para su uso solicito respetar la autoría como parte del reconocimiento técnico de desarrollo
rem==============================================================================================

:: Variables
set "PLANTUML_JAR=%~dp0plantuml.jar"

:ValidarEntorno
echo Verificando entorno...
rem --- CME-FIX-03 (CME-05): Resolver ruta local a plantuml.jar dentro de la subrutina
set "PLANTUML_JAR=%~dp0plantuml.jar"

:: Verificar Java
java -version >nul 2>&1
set "JAVA_OK=%ERRORLEVEL%"
if %JAVA_OK% neq 0 (
    echo [X] Java no detectado. Asegúrate de que esté en el PATH.
    goto :OfrecerInstalacionJava
) else (
    echo [✓] Java detectado correctamente.
)

:: Verificar PlantUML
if exist "%PLANTUML_JAR%" (
    set "PLANTUML_OK=0"
    echo [✓] plantuml.jar encontrado en %PLANTUML_JAR%.
) else (
    set "PLANTUML_OK=1"
    echo [X] plantuml.jar no encontrado en %PLANTUML_JAR%.
    goto :OfrecerInstalacionPlantUML
)

:: Validación final
if %JAVA_OK%==0 if %PLANTUML_OK%==0 (
    echo [✓] Entorno validado correctamente.
    goto :EOF
)

:OfrecerInstalacionJava
echo ¿Deseas instalar Java? (S/N)
set /p INSTALL_JAVA=
if /I "%INSTALL_JAVA%"=="S" (
    echo Abriendo página oficial de Java...
    start https://www.java.com/es/download/
)
call :ManejarError JAVA_FALTA

:OfrecerInstalacionPlantUML
echo ¿Deseas descargar PlantUML? (S/N)
set /p INSTALL_PLANTUML=
if /I "%INSTALL_PLANTUML%"=="S" (
    echo Abriendo página de descarga de PlantUML...
    start http://plantuml.com/es/download
)
call :ManejarError PLANTUML_FALTA

rem ===========================================================================================
rem SUBRUTINA DE MANEJO DE ERRORES
rem --------------------------------------------------------------------------------------------
rem Ficha CME - SR-ERR-001
rem Propósito: Centralizar el manejo de errores del script para facilitar la trazabilidad y mantenimiento.
rem Entorno: Windows cmd, ejecución local
rem Dependencias: Ninguna. Se invoca desde el script principal.
rem Trazabilidad: Registra mensajes de error en la consola, facilitando la auditoría de la ejecución.
rem Autor: Diego Benjumea - Redfyr
rem Fecha: 2025-08-23
rem: Para su uso solicito respetar la autoría como parte del reconocimiento técnico de desarrollo.
rem ==============================================================================================
rem                               DEFINICIONES
rem Código de error: ARG_FALTA -> No se ha pasado un archivo .puml como argumento.
rem Código de error: RENDER_FALLA -> Fallo en la generación del diagrama.
rem Código de error: JAVA_FALTA -> Java no está en el PATH.
rem Código de error: PLANTUML_FALTA -> plantuml.jar no fue encontrado.
rem Código de error: INSTALACION_JAVA -> Error en la instalación de Java.
rem Código de error: INSTALACION_PLANTUML -> Error en la descarga de plantuml.jar.

:: Subrutina de manejo de errores
:ManejarError
if "%~1"=="ARG_FALTA" (
    echo [ERROR] Debes indicar un archivo .puml como argumento.
    echo Uso: %~nx0 <archivo.puml>
    endlocal
    exit /b 1
) else if "%~1"=="RENDER_FALLA" (
    echo [ERROR] Falló la generación del diagrama.
    endlocal
    exit /b 1
) else if "%~1"=="JAVA_FALTA" (
    echo [X] Java no detectado. Asegúrate de que esté en el PATH.
    endlocal
    exit /b 1
) else if "%~1"=="PLANTUML_FALTA" (
    echo [X] plantuml.jar no encontrado.
    endlocal
    exit /b 1
) else if "%~1"=="INSTALACION_JAVA" (
    echo [ERROR] Dependencias faltantes. Abortando ejecución ...
    endlocal
    exit /b 1
) else if "%~1"=="INSTALACION_PLANTUML" (
    echo [ERROR] Dependencias faltantes. Abortando ejecución ...
    endlocal
    exit /b 1
)
goto :EOF