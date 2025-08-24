# **PlantUML_Creator**

PlantUML_Creator es un script CLI desarrollado en .bat que automatiza la generación de diagramsa, figuras y tablas utilizando el lenguaje DSL (Domain-Specific-Lenguaje) de PlantUML. Un DSL es un lenguaje diseñado específicamente para describir elementos como dentro de un dominio concreto -en este caso, estructuras visuales
como clases, secuencias, flujos o componentes de software- de forma concisa y expresiva
Este artefacto resuelve la necesidad de renderizar diagramas sin depender de extensiones nativas como las de IntelliJ IDEA, permitiendo una ejecución directa desde consola, con validación de entorno, modularidad y trazabilidad

---

## **Autor:**

Diego Benjumea - Redfyr

## *Fecha:*

2025-08-22

## *Propósito Institucional*

- Formalizar el proceso de generación de diagramas como artefactos auditables
- Facilitar la adopción de PlantUML en entornos donde no se dispone de IDEs con extensiones gráficas
- Promover buenas prácticas defensivas en scripting, control de dependencias y limpieza de temporales
- Alinear el uso del script con marcos normativos NIST, ISO/IEC y NICE.

---

## *Público Objetivo*

- Arquitectos metodológicos que documentan sistemas con trazabilidad
- Desarrolladores fullstack que integran diagramas en pipelines o documentación técnica
- Analistas de ciberseguridad que quieren visualización estructurada de flujos o dependencias
- Instituciones educativas que enseñan modelado con enfoque defensivo y reproducible

---

## *Características principales*

- Renderizador CLI multiplataforma: Ejecuta diagrams desde consola sin dependeer de extensiones gráficas ni IDEs específicos
- Uso de lenguaje DSL:  PlantUML emplea un Domain-Specif Lenguage para describir visualmente estructuras de software de forma concisa
- Validación de entorno: Verifica la presencia de Java y PlantUML antes de ejecutar, evitando errores silenciosos
- Modularidad defensiva: subrutinas independientes para sanitización, limpieza de temporales y control de logs
- Trazabilidad: Cada componente puede formalizarse como artefacto con ficha, propósito y entorno definido
- Exclusión de artefactos generados: .gitignore adaptado para mantener el repositorio limpio y auditable
- Documentación pedagógica: Estructura para facilitar la adopción institucional o educativa

## **Entorno de ejecución**

### *Primario*

- PowerShell 5.0 o superior
- Java Runtime Environment instalado
- plantuml.jar ubicado en el mismo directorio o accesible.

---

### *Aclaración Institucional*

Se evita PowerShell como entorno de ejecución debido a sus restricciones de seguridad (como la política AllSigned)
que dificulta la instalación y distribución del script en equipos externos. El uso de CMD garantiza mayor
compatibilidad y portabilidad sin comprometer la trazabilidad

---

### *gitignore — Exclusión de artefactos generados*

### Propósito CME

Mantener la limpieza del repositorio, excluyendo archivos temporales, binarios y trazas que no forman parte del legado institucional

### Contexto

Proyecto PlantUML_Creator

### Enfoque

Defensivo, trazable y pedagógico

### Ficha CME: Bloque de validación de entorno

- *ID:* CME-ENVVAL-001
- *Nombre*: Validación del entorno en PlantUML_Creator.bat
- *Propósito*: Comprobar que Java está en el en PATH y plantuml.jar existe antes de ejecutar el resto del script para
evitar errores silenciosos
- *Alcance*: Se ejecuta al inicio de PlantUML_Creator.bat para comprobar el entorno y abortar si falta alguna dependencia
- *Audiencia*: Usuarios y mantenedores del script que operan Windows CMD
- *Contexto*: Fragmento de código batch insertado al comienzo del script para garantizar que las precondiciones estén cubiertas
- *Formato*: Código batch (.bat) compatible con cmd.exe
- *Estructura*: Comando Java- version > nul > 2&1 y comprobación de %ERRORLEVEL%; instrucción if not exist "plantuml.jar"
- *Dependencias*: Consola CMD (cmd.exe), Java Runtime Environment accesible desde el PATH, archivo plantuml.jar
- *Entradas*: Estado del entorno - Instalación de Java y existencia de plantuml.jar
- *Salidas*: Mensajes claros de error o éxito, código de salida distintos de cero si faltan dependencias
- *Mantenimiento*: Ajustar rutas o comandos según actualizaciones de Java/PlantUML, versionar junto al script

---

### *Menú de opciones principales*

Se crea un  menú que permite al usuario acceder a las opciones básicas que ofrece el script y escoger entre
las opciones 1 para renderizar todos los activos y la opción 2  para filtrar y renderizar por prefijo o la opción 3 para salir del script.

### *Gestión defensiva de archivos*

Antes de cualquier acción, el script verifica la existencia de los archivos .puml en el directorio 'codigo',
si no encuentra ninguno, muestra un mensaje informativo y finaliza el proceso para evitar errores.

### *Listado de archivos (Opción 1)*

Al elegir la opción 1 (renderizar todo) el script hace un escaneo y muestra una lista detallada de todos los archivos que va a procesar.

### *Renderizado por prefijo (Opción 2)*

Cuando se selecciona la opción 2, el script no procesa todos los archivos de golpe, sino que permite elegir
un grupo específico de diagramas. El proceso es el siguiente:

- Menú prefijos: El script presenta una lista de prefijos predefinidos, cada prefijo corrsponde a un tipo de diagrama como, como sec para seguridad o net para redes.
- Selección y búsqueda: Elección de la opción. El escript toma el prefijo asociado (ej: sec) y luego escanea la carpeta 'codigo'/ para encontrar todos los archivos que comiencen con ese prefijo (ej_sec-001, sec-002)
- Creación de la carpeta de salida: Antes de renderizar, el script es lo suficientemente inteligente para
crear una subcarpeta con el nombre del prefijo dentro del directorio de salida (output/); esto evita que los
diagramas de diferentes categorías se mezclen, manteniendo el proyecto muy organizado (por ejemplo: output/sec, output/net)
- Listado y confirmación: Una vez el script ha encontrado los archivos, te muestra una lista de los que va a procesar, no los renderiza de inmediato, en cambio, pregunta si se desea continuar; esto da el control total para decidir si se quiere seguir adelante o cancelar la operación y volver al menú.
Esta funcionalidad es ideal cuando se quiere actualizar un tipo específico de diagrama sin tener que esperar a que el script renderice todo el proyecto. Es una medida defensiva que ahhorra tiempo y recursos

### *Confirmación del usuario*

En ambas opciones (1 y 2), el script pide una confirmación antes de iniciar el renderizado, lo que da control
total sobre el acceso.

## Instalación (pendiente de desarrollo)
