#!/bin/bash
# setup.sh
# Clona los repositorios de backend y frontend (rama develop) dentro
# de este repo de infraestructura. Ejecutar una sola vez después de
# clonar walking-dictionary-infra, o cada vez que se necesite un
# clon limpio de ambos repos.

set -e  # detener el script si algún comando falla

BACKEND_REPO="https://github.com/wsernam/A-Walking-Dictionary-NovaCode-Back-end.git"
FRONTEND_REPO="https://github.com/knnsand/A-Walking-Dictionary-NovaCode-Front-end.git"
BACKEND_DIR="A-Walking-Dictionary-NovaCode-Back-end"
FRONTEND_DIR="A-Walking-Dictionary-NovaCode-Front-end"
BRANCH="develop"

echo "==> Clonando backend (rama $BRANCH)..."
if [ -d "$BACKEND_DIR" ]; then
  echo "La carpeta '$BACKEND_DIR/' ya existe. Actualizando en vez de clonar..."
  git -C "$BACKEND_DIR" fetch origin "$BRANCH"
  git -C "$BACKEND_DIR" checkout "$BRANCH"
  git -C "$BACKEND_DIR" pull origin "$BRANCH"
else
  git clone -b "$BRANCH" "$BACKEND_REPO" "$BACKEND_DIR"
fi

echo "==> Clonando frontend (rama $BRANCH)..."
if [ -d "$FRONTEND_DIR" ]; then
  echo "La carpeta '$FRONTEND_DIR/' ya existe. Actualizando en vez de clonar..."
  git -C "$FRONTEND_DIR" fetch origin "$BRANCH"
  git -C "$FRONTEND_DIR" checkout "$BRANCH"
  git -C "$FRONTEND_DIR" pull origin "$BRANCH"
else
  git clone -b "$BRANCH" "$FRONTEND_REPO" "$FRONTEND_DIR"
fi

echo ""
echo "==> Listo. Estructura actual:"
ls -1

echo ""
echo "Nota: el codigo real del backend queda en"
echo "      '$BACKEND_DIR/backend/' (el repo lo trae anidado asi)."
echo "      El frontend queda directo en '$FRONTEND_DIR/'."
echo "      El docker-compose.yml ya apunta a esas rutas como build context."
echo ""
echo "Siguiente paso:"
echo "  1) cp .env.example .env   (y completar los valores)"
echo "  2) docker compose up --build"
