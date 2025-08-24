@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

rem ======================================================================================
rem CME-MAIN-001: script principal de generación PlantUML con validación previa
rem Archivo: creator.bat
rem Propósito: Llamar a ValidarEntorno y luego generar diagramas
rem Entorno: Windows 11, cmd, Batch v1.0
rem ======================================================================================

rem 1. VALIDAR ENTORNO
call :ValidarEntorno
if ERRORLEVEL 1 (
    call :ManejarError INSTALACION_JAVA
    exit /b 1
)

rem 2. MOSTRAR MENU
call :MostrarMenu
if ERRORLEVEL 1 (
    rem El usuario eligio una opcion que no requiere mas procesamiento
    endlocal
    exit /b 0
)

rem 3. MENSAJE DE ÉXITO
echo [INFO] Proceso de renderizado completado.
endlocal
exit /b 0

rem ======================================================================================
rem SUBRUTINA VALIDAR ENTORNO
rem --------------------------------------------------------------------------------------
rem Ficha CME - SR-001
rem Propósito: Subrutina encargada de validar la existencia de las dependencias del proyecto
rem --------------------------------------------------------------------------------------
:ValidarEntorno
echo Verificando entorno...
set "PLANTUML_JAR=%~dp0plantuml.jar"

:: Verificar Java
java -version >nul 2>&1
if not "%ERRORLEVEL%"=="0" (
    echo [X] Java no detectado. Asegúrate de que esté en el PATH.
    goto :OfrecerInstalacionJava
) else (
    echo [✓] Java detectado correctamente.
)

:: Verificar PlantUML
if not exist "%PLANTUML_JAR%" (
    echo [X] plantuml.jar no encontrado en %PLANTUML_JAR%.
    goto :OfrecerInstalacionPlantUML
) else (
    echo [✓] plantuml.jar encontrado en %PLANTUML_JAR%.
)

echo [✓] Entorno validado correctamente.
goto :EOF

:OfrecerInstalacionJava
echo ¿Deseas instalar Java? (S/N)
set /p INSTALL_JAVA=
if /I "%INSTALL_JAVA%"=="S" (
    start https://www.java.com/es/download/
)
call :ManejarError JAVA_FALTA
goto :EOF

:OfrecerInstalacionPlantUML
echo ¿Deseas descargar PlantUML? (S/N)
set /p INSTALL_PLANTUML=
if /I "%INSTALL_PLANTUML%"=="S" (
    start http://plantuml.com/es/download
)
call :ManejarError PLANTUML_FALTA
goto :EOF

rem ======================================================================================
rem SUBRUTINA MOSTRAR MENU
rem --------------------------------------------------------------------------------------
rem Ficha CME - SR-MENU-001
rem Propósito: Muestra un menú interactivo en la consola para la selección de tareas.
rem --------------------------------------------------------------------------------------
:MostrarMenu
cls
echo =============================================================================================
echo =                 PlantUML - CREATOR - MENU                                               =
echo =============================================================================================
echo.
echo 1. Renderizar todos los diagramas del directorio 'codigo'.
echo 2. Filtrar por prefijo (Tabla de prefijos).
echo 3. Salir
echo.
set /p "OPCION=Elige una opcion y presiona Enter: "

if "%OPCION%"=="1" (
    call :ObtenerArchivos
    if defined archivos_a_procesar (
        call :RenderizarArchivos
    )
) else if "%OPCION%"=="2" (
    call :FiltrarMenuEstatico
) else if "%OPCION%"=="3" (
    goto :EOF
) else (
    echo [ERROR] Opcion invalida. Intentalo de nuevo.
    pause >nul
    goto MostrarMenu
)
goto :EOF

rem ======================================================================================
rem SUBRUTINA OBTENER ARCHIVOS
rem --------------------------------------------------------------------------------------
rem Ficha CME - SR-FIL-001
rem Propósito: Recuperar la lista de archivos *.puml desde el directorio Codigo.
rem --------------------------------------------------------------------------------------
:ObtenerArchivos
set "DIR_CODIGO=%~dp0Codigo"
if not exist "%DIR_CODIGO%" (
    call :ManejarError DIR_CODIGO_FALTA
    goto :EOF
)

set "archivos_a_procesar="
for /r "%DIR_CODIGO%" %%f in (*.puml) do (
    set "archivos_a_procesar=!archivos_a_procesar! "%%f""
)

if not defined archivos_a_procesar (
    echo [INFO] No se encontraron archivos .puml en el directorio 'Codigo'.
    goto :EOF
)
rem --- Mostrar archivos encontrados ---
echo.
echo [INFO] Se encontraron los siguientes archivos para renderizar:
for %%f in (%archivos_a_procesar%) do echo   - %%~nxf

goto :EOF

rem ======================================================================================
rem = SUBRUTINA: RENDERIZAR ARCHIVOS                                                      =
rem --------------------------------------------------------------------------------------
rem Ficha CME - SR-REN-001
rem Propósito: Renderizar los archivos .puml encontrados en el directorio Codigo.
rem --------------------------------------------------------------------------------------
:RenderizarArchivos
set "OUTPUT=%~dp0output"
if not exist "%OUTPUT%" mkdir "%OUTPUT%"
for %%f in (%archivos_a_procesar%) do (
    echo [INFO] Renderizando archivo %%~nxf...
    java -jar "%~dp0plantuml.jar" -o "%OUTPUT%" "%%~f"
    if errorlevel 1 (
        call :ManejarError RENDER_FALLA
    )
)
goto :EOF

rem ======================================================================================
rem = SUBRUTINA: RENDERIZAR SOLO NUEVOS O MODIFICADOS                                    =
rem --------------------------------------------------------------------------------------
rem Ficha CME - SR-REN-002 
rem Propósito: Renderizar solo los archivos .puml que no tienen un .png correspondiente o
rem            que han sido mofificados más recientemente que su .png
rem Dependencias: Subrutina :RenderizarArchivos
rem ======================================================================================
:RenderizarNuevosOModificados
set "DIR_CODIGO=%~dp0Codigo"
set "OUTPUT=%~dp0output"

echo.
echo [INFO] Buscando archivos nuevos o modificados para renderizar...

set "archivos_a_procesar="
for /r "%DIR_CODIGO%" %%f in (*.puml) do (
    set "ARCHIVO_PUML=%%f"
    set "ARCHIVO_PNG=!DIR_SALIDA!\%%%%~nf.png"
    if not exist "!ARVHIVO_PNG!" (
        rem El archivo .png no existe, renderizar.
        set "archivos_a_procesar=!archivos_a_procesar! "!ARCHIVO_PUML!""
    ) else (
        rem El archivo .png ya existe, comparar fechas.
        for /f "tokens=1" %%a in ('wmic datafile where name^="!ARCHIVO_PUML:^=\\!" get LastModified /format:list') do set "fecha_puml=%%a"
        for /f "tokens=1" %%b in ('wmic datafile where name^="!ARCHIVO_PNG:^=\\!" get LastModified /format:list') do set "fecha_png=%%b"
        
        if "!fecha_puml!" GTR "!fecha_png!" (
            rem El archivo .puml es más reciente, renderizar.
            set "archivos_a_procesar=!archivos_a_procesar! "!ARCHIVO_PUML!""
        )
    )
)
if not defined archivos_a_procesar(
    echo [INFO] Todos los diagramas están actualizados. No hay archivos para renderizar
) else (
    echo.
    echo [INFO] Se encontraron los siguientes archivos para renderizar:
    for %%f in (%archivos_a_procesar%) do echo   - %%~nxf
    echo.
    set /p "CONFIRMAR=¿Deseas renderizar estos archivos? (S/N):"
    if /I "%CONFIRMAR%"=="S" (
        call :RenderizarArchivos
    ) else (
        echo [INFO] Operacion cancelada por el usuario.
    )
)
pause >nul
goto MostrarMenu

rem ======================================================================================
rem = SUBRUTINA: MANEJO DE ERRORES                                                    =
rem --------------------------------------------------------------------------------------
rem Ficha CME - SR-ERR-001
rem Propósito: Centralizar el manejo de errores del script para facilitar la trazabilidad.
rem --------------------------------------------------------------------------------------
:ManejarError
if "%~1"=="ARG_FALTA" (
    echo [ERROR] Debes indicar un archivo .puml como argumento.
    echo Uso: %~nx0 <archivo.puml>
) else if "%~1"=="RENDER_FALLA" (
    echo [ERROR] Falló la generación del diagrama.
) else if "%~1"=="JAVA_FALTA" (
    echo [X] Java no detectado. Asegúrate de que esté en el PATH.
) else if "%~1"=="PLANTUML_FALTA" (
    echo [X] plantuml.jar no encontrado.
) else if "%~1"=="INSTALACION_JAVA" (
    echo [ERROR] Dependencias faltantes. Abortando ejecucion ...
) else if "%~1"=="INSTALACION_PLANTUML" (
    echo [ERROR] Dependencias faltantes. Abortando ejecucion ...
) else if "%~1"=="DIR_CODIGO_FALTA" (
    echo [ERROR] No se encontro el directorio 'Codigo'.
)
endlocal
exit /b 1

rem ======================================================================================
rem SUBRUTINA FILTRAR POR PREFIJO (SUBMENU ESTÁTICO)
rem --------------------------------------------------------------------------------------
rem Ficha CME - SR-FIL-002
rem Propósito: Muestra un submenú interactivo basado en una tabla de prefijos estática,
rem            permitiendo al usuario seleccionar y renderizar solo los archivos con el
rem            prefijo elegido.
rem Entorno: Windows cmd, ejecución local.
rem Dependencias: Subrutinas :RenderizarArchivos, :ManejarError.
rem Autor: Diego Benjumea - Redfyr
rem Fecha: 2025-08-23
rem ======================================================================================
:FiltrarMenuEstatico
cls
echo ====================================================================================
echo =                 SUBMENU - FILTRAR POR PREFIJO                                  =
echo ====================================================================================
echo.
echo [INFO] Listado de prefijos para filtrar:
echo.
echo 1. sec  ^| Seguridad/Ciberseguridad
echo 2. net  ^| Redes/infraestructura
echo 3. app  ^| Aplicaciones/desarrollo
echo 4. aq   ^| Arquitectura MVVC
echo 5. aqt  ^| Arquitectura MVVC
echo 6. cu   ^| Casos de uso
echo 7. co   ^| Clases y objetos
echo 8. er   ^| Entidad-Relacion (Base de datos)
echo 9. seq  ^| Secuencia/interaccion
echo 10. cmp ^| Componentes/Modulos
echo 11. cfg ^| Configuracion/Infra
echo.

set /p "OPCION=Elige una opcion y presiona Enter: "

if "%OPCION%"=="1" (set "SEL_PREF=sec")
if "%OPCION%"=="2" (set "SEL_PREF=net")
if "%OPCION%"=="3" (set "SEL_PREF=app")
if "%OPCION%"=="4" (set "SEL_PREF=aq")
if "%OPCION%"=="5" (set "SEL_PREF=aqt")
if "%OPCION%"=="6" (set "SEL_PREF=cu")
if "%OPCION%"=="7" (set "SEL_PREF=co")
if "%OPCION%"=="8" (set "SEL_PREF=er")
if "%OPCION%"=="9" (set "SEL_PREF=seq")
if "%OPCION%"=="10" (set "SEL_PREF=cmp")
if "%OPCION%"=="11" (set "SEL_PREF=cfg")

if not defined SEL_PREF (
    echo [ERROR] Opcion invalida. Intentalo de nuevo.
    pause >nul
    goto FiltrarMenuEstatico
)


rem --- Creación del subdirectorio de salida con el nombre del prefijo ---
set "OUTPUT_SUBDIR=%~dp0output\!SEL_PREF!"
if not exist "%OUTPUT_SUBDIR%" mkdir "%OUTPUT_SUBDIR%"

set "archivos_a_procesar="
for /r "%~dp0Codigo" %%f in (!SEL_PREF!_*.puml) do (
    set "archivos_a_procesar=!archivos_a_procesar! "%%f""
)

if defined archivos_a_procesar (
    echo.
    echo [INFO] Se encontraron los siguientes archivos:
    for %%f in (%archivos_a_procesar%) do echo   - %%~nxf
    echo.
    call :RenderizarArchivos
) else (
    echo.
    echo [INFO] No se encontraron archivos para el prefijo seleccionado.
)

pause >nul
goto MostrarMenu