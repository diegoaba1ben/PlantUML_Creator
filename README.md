# PlantUML_Creator

PlantUML_Creator es un script CLI desarrollado en PowerShell que automatiza la generación de diagramsa, figuras y tablas utilizando el lenguaje DSL (Domain-Specific-Lenguaje) de PlantUML. Un DSL es un lenguaje diseñado específicamente para describir elementos como dentro de un dominio concreto -en este caso, estructuras visuales
como clases, secuencias, flujos o componentes de software- de forma concisa y expresiva
Este artefacto resuelve la necesidad de renderizar diagramas sin depender de extensiones nativas como las de IntelliJ IDEA, permitiendo una ejecución directa desde consola, con validación de entorno, modularidad y trazabilidad

## Propósito Institucional

- Formalizar el proceso de generación de diagramas como artefactos auditables
- Facilitar la adopción de PlantUML en entornos donde no se dispone de IDEs con extensiones gráficas
- Promover buenas prácticas defensivas en scripting, control de dependencias y limpieza de temporales
- Alinear el uso del script con marcos normativos NIST, ISO/IEC y NICE.

## Público Objetivo

- Arquitectos metodológicos que documentan sistemas con trazabilidad
- Desarrolladores fullstack que integran diagramas en pipelines o documentación técnica
- Analistas de ciberseguridad que quieren visualización estructurada de flujos o dependencias
- Instituciones educativas que enseñan modelado con enfoque defensivo y reproducible

## Características principales

- Renderizador CLI multiplataforma: Ejecuta diagrams desde consola sin dependeer de extensiones gráficas ni IDEs específicos
- Uso de lenguaje DSL:  PlantUML emplea un Domain-Specif Lenguage para describir visualmente estructuras de software de forma concisa
- Validación de entorno: Verifica la presencia de Java y PlantUML antes de ejecutar, evitando errores silenciosos
- Modularidad defensiva: subrutinas independientes para sanitización, limpieza de temporales y control de logs
- Trazabilidad: Cada componente puede formalizarse como artefacto con ficha, propósito y entorno definido
- Exclusión de artefactos generados: .gitignore adaptado para mantener el repositorio limpio y auditable
- Documentación pedagógica: Estructura para facilitar la adopción institucional o educativa

## Instalación (pendiente de desarrollo)