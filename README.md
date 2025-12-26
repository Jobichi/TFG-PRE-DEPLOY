# TFG-PRE-DEPLOY

Este repositorio contiene los elementos necesarios para la preparación del entorno de ejecución previo al despliegue del Trabajo Fin de Grado (TFG).

Su objetivo principal es automatizar la instalación, configuración y verificación de las dependencias básicas del sistema, en particular Docker y Docker Compose, garantizando un entorno consistente y reproducible antes de desplegar los servicios del proyecto principal.

## Contenido del repositorio

Actualmente, el repositorio incluye los siguientes scripts:

- **`install-docker.sh`**: script para la instalación automática de Docker y Docker Compose. Incorpora comprobaciones previas del sistema y validaciones posteriores para asegurar su correcto funcionamiento.

- **`vosk-models.sh`**: script para la descarga y preparación automática de los modelos de Vosk necesarios para la transcripción de audio en español. El script gestiona la creación de directorios, la descarga de los modelos y la limpieza de archivos temporales.

- **`permissions.sh`**: script encargado de ajustar los permisos de los directorios asociados a los distintos servicios del sistema, garantizando que los contenedores Docker puedan acceder correctamente a los volúmenes persistentes del sistema anfitrión.

El repositorio ha sido diseñado con un enfoque modular, permitiendo su ampliación futura mediante la incorporación de nuevos scripts de preparación del entorno si fuese necesario.

## Ejecución de los scripts

Para ejecutar cualquiera de los scripts, es necesario otorgarle previamente permisos de ejecución:

```bash
sudo chmod +x <script_name>.sh
```

Una vez asignados los permisos, el script puede ejecutarse mediante:

```bash
sudo ./<script_name>.sh
```

Durante la ejecución, cada script mostrará por consola información sobre el progreso de las operaciones realizadas y notificará cualquier incidencia detectada.