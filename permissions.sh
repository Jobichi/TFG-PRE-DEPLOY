#!/usr/bin/env bash
set -e

####################################################
# TFG-PRE-DEPLOY
# Ajuste de permisos para servicios dockerizados
####################################################

# ---------- Funciones auxiliares ----------
info()  { echo "[INFO] $1"; }
warn()  { echo "[WARN] $1"; }
error() { echo "[ERROR] $1"; exit 1; }

# ---------- Comprobación de privilegios ----------
if [[ "$EUID" -ne 0 ]]; then
    error "Este script debe ejecutarse con privilegios de administrador (sudo)."
fi

# ---------- Resolución del HOME real ----------
REAL_USER_HOME=$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)
PROJECT_DIR="$REAL_USER_HOME/TFG-2025-RaspBerry"

if [[ ! -d "$PROJECT_DIR" ]]; then
    error "No se ha encontrado el directorio '$PROJECT_DIR'. Clone primero el repositorio principal."
fi

# ==================================================
# Asterisk
# ==================================================
ASTERISK_UID=1000
ASTERISK_GID=999
ASTERISK_DIR="$PROJECT_DIR/asterisk"

if [[ -d "$ASTERISK_DIR" ]]; then
    info "Ajustando permisos para Asterisk (UID:GID = $ASTERISK_UID:$ASTERISK_GID)..."
    chown -R "$ASTERISK_UID:$ASTERISK_GID" "$ASTERISK_DIR"
    chmod -R u+rwX "$ASTERISK_DIR"
else
    warn "Directorio de Asterisk no encontrado. Se omite."
fi

# ==================================================
# Mosquitto
# ==================================================
MOSQUITTO_UID=1883
MOSQUITTO_GID=1883
MOSQUITTO_DIR="$PROJECT_DIR/mosquitto"

if [[ -d "$MOSQUITTO_DIR" ]]; then
    info "Ajustando permisos para Mosquitto (UID:GID = $MOSQUITTO_UID:$MOSQUITTO_GID)..."
    chown -R "$MOSQUITTO_UID:$MOSQUITTO_GID" "$MOSQUITTO_DIR"
    chmod -R u+rwX "$MOSQUITTO_DIR"
else
    warn "Directorio de Mosquitto no encontrado. Se omite."
fi

# ---------- Final ----------
echo
info "Ajuste de permisos completado correctamente."
