# **PlantUML-Creator**

## *Descripción*

PlantUML-Creator es un script de línea de comandos diseñado para automatizar el proceso de renderizado de diagramas PlantUML. Este script está construido para entornos Windows y te permite generar diagramas .png a partir de archivos .puml de manera eficiente, ya sea procesando todos los archivos o filtrando por prefijos específicos.

## *Características*

- Menú Interactivo: Un menú simple y claro que te guía a través de las opciones de renderizado.

- Validación de Entorno: Comprueba automáticamente la existencia de Java y plantuml.jar. Si no los encuentra, te ofrece enlaces directos de descarga.

- Renderizado Completo: Opción para procesar todos los archivos .puml encontrados en el directorio Codigo.

- Filtrado por Prefijo: Un submenú dedicado para renderizar solo los archivos que coinciden con un prefijo predefinido (ej. sec_, net_, app_).

- Gestión de Archivos Temporales: Crea y elimina un directorio temporal para el proceso de filtrado, asegurando que tu entorno de trabajo se mantenga limpio.

- Manejo Centralizado de Errores: Todos los mensajes de error se gestionan desde una única subrutina para facilitar la depuración y la trazabilidad.

## *Prerrequisitos*

Para que el script funcione correctamente, asegúrate de tener lo siguiente en tu sistema:

Java Runtime Environment (JRE): El comando java debe ser accesible desde la línea de comandos. Esto se logra si Java está instalado y su ruta está incluida en la variable de entorno PATH del sistema.

plantuml.jar: El archivo ejecutable de PlantUML debe estar en el mismo directorio que el script creator.bat.

## *Estructura del Proyecto*

El proyecto sigue una estructura de directorios simple y organizada:

.
├── Codigo/
│   ├── sec_diagrama_seguridad.puml
│   └── net_diagrama_redes.puml
├── output/
│   ├── sec/
│   │   └── sec_diagrama_seguridad.png
│   └── net/
│       └── net_diagrama_redes.png
├── creator.bat
└── plantuml.jar

Codigo/: Directorio donde se almacenan todos los archivos de origen (.puml).

output/: Directorio de salida donde se guardan los diagramas generados (.png).

creator.bat: El script principal del proyecto.

plantuml.jar: El ejecutable de PlantUML.

## *Uso*

Simplemente haz doble clic en el archivo creator.bat o ejecútalo desde la línea de comandos. El script mostrará un menú interactivo.

Para renderizar todos los diagramas:

- Selecciona la opción 1.

El script encontrará todos los archivos .puml y los procesará en el directorio output.

Para renderizar por prefijo:

- Selecciona la opción 2.

Elige el prefijo de la lista.

El script creará un directorio temporal, moverá los archivos relevantes, los renderizará en una subcarpeta en output y luego limpiará el directorio temporal.

## *Historial de Versiones*

v1.0.007

- Refactorización Completa: El código ha sido refactorizado para utilizar subrutinas modulares, mejorando la legibilidad y el mantenimiento.

- Parámetros Dinámicos: La subrutina :RenderizarArchivos ahora acepta parámetros de directorios, haciéndola reutilizable y más flexible.

- Lógica de Filtrado Mejorada: Se ha separado la lógica de filtrado de la de renderizado. El bucle for ahora está en la subrutina :FiltrarMenuEstatico.

- Manejo de Errores Optimizado: Se añadió un manejo de errores más detallado para la creación de directorios y la sanitización de archivos temporales.

## **Autoría y Licencia**

Este script ha sido creado y desarrollado por Diego Benjumea - Redfyr. Se recomienda su uso para la gestión y automatización de diagramas PlantUML en proyectos
