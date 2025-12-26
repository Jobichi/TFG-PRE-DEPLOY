#!/usr/bin/env bash
set -e

####################################################
# TFG-PRE-DEPLOY
# Preparación de modelos Vosk (es)
####################################################

# ---------- Configuración ----------
PROJECT_DIR="$HOME/TFG-2025-RaspBerry"
BASE_DIR="$PROJECT_DIR/models/es/vosk"

SMALL_MODEL_URL="https://alphacephei.com/vosk/models/vosk-model-small-es-0.42.zip"
FULL_MODEL_URL="https://alphacephei.com/vosk/models/vosk-model-es-0.42.zip"

SMALL_ZIP="vosk-model-small-es-0.42.zip"
FULL_ZIP="vosk-model-es-0.42.zip"

# ---------- Funciones auxiliares ----------
info() {
    echo "[INFO] $1"
}

warn() {
    echo "[WARN] $1"
}

error() {
    echo "[ERROR] $1"
    exit 1
}

# ---------- Comprobación del proyecto ----------
if [[ ! -d "$PROJECT_DIR" ]]; then
    error "No se ha encontrado el directorio '$PROJECT_DIR'. Clone primero el repositorio TFG-2025-RaspBerry."
fi

# ---------- Comprobación de dependencias ----------
info "Comprobando dependencias necesarias..."
for cmd in wget unzip; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        error "El comando '$cmd' no está instalado. Instálelo antes de continuar."
    fi
done

# ---------- Preparación de directorios ----------
info "Preparando estructura de directorios para los modelos Vosk..."
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

# ---------- Modelo SMALL ----------
if [[ -d "vosk-model-small-es-0.42" ]]; then
    warn "El modelo SMALL ya existe. Se omite su descarga."
else
    info "Descargando modelo SMALL..."
    wget -q "$SMALL_MODEL_URL" -O "$SMALL_ZIP"

    info "Descomprimiendo modelo SMALL..."#!/usr/bin/env bash
set -e

####################################################
# TFG-PRE-DEPLOY
# Preparación de modelos Vosk (es)
####################################################

# ---------- Configuración ----------
PROJECT_DIR="$HOME/TFG-2025-RaspBerry"
BASE_DIR="$PROJECT_DIR/models/es/vosk"

SMALL_MODEL_URL="https://alphacephei.com/vosk/models/vosk-model-small-es-0.42.zip"
FULL_MODEL_URL="https://alphacephei.com/vosk/models/vosk-model-es-0.42.zip"

SMALL_ZIP="vosk-model-small-es-0.42.zip"
FULL_ZIP="vosk-model-es-0.42.zip"

# ---------- Funciones auxiliares ----------
info() {
    echo "[INFO] $1"
}

warn() {
    echo "[WARN] $1"
}

error() {
    echo "[ERROR] $1"
    exit 1
}

# ---------- Comprobación del proyecto ----------
if [[ ! -d "$PROJECT_DIR" ]]; then
    error "No se ha encontrado el directorio '$PROJECT_DIR'. Clone primero el repositorio TFG-2025-RaspBerry."
fi

# ---------- Comprobación de dependencias ----------
info "Comprobando dependencias necesarias..."
for cmd in wget unzip; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        error "El comando '$cmd' no está instalado. Instálelo antes de continuar."
    fi
done

# ---------- Preparación de directorios ----------
info "Preparando estructura de directorios para los modelos Vosk..."
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

# ---------- Modelo SMALL ----------
if [[ -d "vosk-model-small-es-0.42" ]]; then
    warn "El modelo SMALL ya existe. Se omite su descarga."
else
    info "Descargando modelo SMALL..."
    wget -q "$SMALL_MODEL_URL" -O "$SMALL_ZIP"

    info "Descomprimiendo modelo SMALL..."
    unzip -q "$SMALL_ZIP"

    info "Eliminando archivo ZIP del modelo SMALL..."
    rm -f "$SMALL_ZIP"
fi

# ---------- Modelo FULL ----------
if [[ -d "vosk-model-es-0.42" ]]; then
    warn "El modelo FULL ya existe. Se omite su descarga."
else
    info "Descargando modelo FULL..."
    wget -q "$FULL_MODEL_URL" -O "$FULL_ZIP"

    info "Descomprimiendo modelo FULL..."
    unzip -q "$FULL_ZIP"

    info "Eliminando archivo ZIP del modelo FULL..."
    rm -f "$FULL_ZIP"
fi

# ---------- Final ----------
echo
info "Modelos Vosk preparados correctamente en:"
info "$BASE_DIR"

    unzip -q "$SMALL_ZIP"

    info "Eliminando archivo ZIP del modelo SMALL..."
    rm -f "$SMALL_ZIP"
fi

# ---------- Modelo FULL ----------
if [[ -d "vosk-model-es-0.42" ]]; then
    warn "El modelo FULL ya existe. Se omite su descarga."
else
    info "Descargando modelo FULL..."
    wget -q "$FULL_MODEL_URL" -O "$FULL_ZIP"

    info "Descomprimiendo modelo FULL..."
    unzip -q "$FULL_ZIP"

    info "Eliminando archivo ZIP del modelo FULL..."
    rm -f "$FULL_ZIP"
fi

# ---------- Final ----------
echo
info "Modelos Vosk preparados correctamente en:"
info "$BASE_DIR"
