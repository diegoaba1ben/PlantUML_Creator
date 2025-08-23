# **PlantUML_Creator**

PlantUML_Creator es un script CLI desarrollado en PowerShell que automatiza la generación de diagramsa, figuras y tablas utilizando el lenguaje DSL (Domain-Specific-Lenguaje) de PlantUML. Un DSL es un lenguaje diseñado específicamente para describir elementos como dentro de un dominio concreto -en este caso, estructuras visuales
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

## Instalación (pendiente de desarrollo)
