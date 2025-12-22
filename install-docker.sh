#!/usr/bin/env bash
set -e

#############################################
# TFG-PRE-DEPLOY
# Script de instalación y verificación
# Docker + Docker Compose
#############################################

# ---------- Configuración ----------
DOCKER_COMPOSE_VERSION="v2.29.7"

# ---------- Colores ----------
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# ---------- Funciones auxiliares ----------
info() {
    echo -e "${GREEN}[INFO]${RESET} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${RESET} $1"
}

error() {
    echo -e "${RED}[ERROR]${RESET} $1"
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ---------- Comprobaciones iniciales ----------
info "Comprobando privilegios de ejecución..."
if [[ "$EUID" -ne 0 ]]; then
    error "Este script debe ejecutarse con privilegios de administrador (sudo)."
fi

info "Comprobando sistema operativo..."
if [[ ! -f /etc/os-release ]]; then
    error "No se puede identificar el sistema operativo."
fi

source /etc/os-release
if [[ "$ID" != "debian" && "$ID_LIKE" != *"debian"* ]]; then
    error "Sistema no basado en Debian. Sistema detectado: $PRETTY_NAME"
fi

info "Sistema operativo compatible detectado: $PRETTY_NAME"

info "Comprobando arquitectura..."
ARCH=$(uname -m)
if [[ "$ARCH" != "aarch64" && "$ARCH" != "armv7l" ]]; then
    warn "Arquitectura no ARM detectada ($ARCH). El script puede no funcionar correctamente."
else
    info "Arquitectura compatible detectada: $ARCH"
fi

# ---------- Actualización del sistema ----------
info "Actualizando índice de paquetes..."
apt update -y

# ---------- Instalación de dependencias ----------
info "Instalando dependencias necesarias..."
apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# ---------- Instalación de Docker ----------
if command_exists docker; then
    info "Docker ya está instalado. Se omite la instalación."
else
    info "Instalando Docker..."
    curl -fsSL https://get.docker.com | sh
    info "Docker instalado correctamente."
fi

# ---------- Habilitación del servicio ----------
info "Habilitando y arrancando el servicio Docker..."
systemctl enable docker
systemctl start docker

# ---------- Grupo docker ----------
TARGET_USER="${SUDO_USER:-root}"

if id -nG "$TARGET_USER" | grep -qw docker; then
    info "El usuario '$TARGET_USER' ya pertenece al grupo docker."
else
    info "Añadiendo el usuario '$TARGET_USER' al grupo docker..."
    usermod -aG docker "$TARGET_USER"
    warn "Será necesario cerrar sesión o reiniciar para aplicar los permisos."
fi

# ---------- Instalación de Docker Compose ----------
if docker compose version >/dev/null 2>&1; then
    info "Docker Compose ya está disponible."
else
    info "Instalando Docker Compose (${DOCKER_COMPOSE_VERSION})..."
    mkdir -p /usr/local/lib/docker/cli-plugins
    curl -SL \
        "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${ARCH}" \
        -o /usr/local/lib/docker/cli-plugins/docker-compose
    chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
    info "Docker Compose instalado correctamente."
fi

# ---------- Verificaciones finales ----------
info "Verificando instalación..."

docker --version || error "Docker no responde correctamente."
docker compose version || error "Docker Compose no responde correctamente."

info "Ejecutando contenedor de prueba..."
docker run --rm hello-world >/dev/null 2>&1 \
    && info "Docker funciona correctamente." \
    || error "Error al ejecutar contenedor de prueba."

# ---------- Final ----------
echo
info "Instalación finalizada correctamente."
warn "Si se ha añadido el usuario al grupo docker, reinicie la sesión o el sistema antes de continuar."
