# TFG-PRE-DEPLOY

Este repositorio contiene los elementos necesarios para la preparación del entorno de ejecución previo al despliegue del Trabajo Fin de Grado (TFG).

Su objetivo principal es automatizar la instalación y verificación de las dependencias básicas del sistema, en particular Docker y Docker Compose, garantizando un entorno consistente y reproducible antes de desplegar los servicios del proyecto.

## Contenido del repositorio

Actualmente, el repositorio incluye:

- `install-docker.sh`: script de instalación automática de Docker y Docker Compose, que incorpora comprobaciones previas del sistema y validaciones posteriores para asegurar su correcto funcionamiento.

El repositorio ha sido diseñado para poder ampliarse en el futuro con nuevos scripts de preparación del entorno si fuese necesario.

## Ejecución del script

Para ejecutar el script de instalación, es necesario otorgarle previamente permisos de ejecución:

```bash
sudo chmod +x install-docker.sh
```

Una vez asignados los permisos, el script puede ejecutarse mediante:

```bash
sudo ./install-docker.sh
```

Durante la ejecución, el script mostrará por consola el progreso de la instalación y notificará cualquier incidencia detectada.