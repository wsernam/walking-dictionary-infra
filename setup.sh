#!/bin/bash
# setup.sh
# Clona los repositorios de backend y frontend (rama develop) dentro
# de este repo de infraestructura. Ejecutar una sola vez después de
# clonar walking-dictionary-infra, o cada vez que se necesite un
# clon limpio de ambos repos.

set -e  # detener el script si algún comando falla

BACKEND_REPO="https://github.com/wsernam/A-Walking-Dictionary-NovaCode-Back-end.git"
FRONTEND_REPO="https://github.com/knnsand/A-Walking-Dictionary-NovaCode-Front-end.git"
BRANCH="develop"

echo "==> Clonando backend (rama $BRANCH)..."
if [ -d "repo-backend" ]; then
  echo "La carpeta 'repo-backend/' ya existe. Actualizando en vez de clonar..."
  git -C repo-backend fetch origin "$BRANCH"
  git -C repo-backend checkout "$BRANCH"
  git -C repo-backend pull origin "$BRANCH"
else
  git clone -b "$BRANCH" "$BACKEND_REPO" repo-backend
fi

echo "==> Clonando frontend (rama $BRANCH)..."
if [ -d "repo-frontend" ]; then
  echo "La carpeta 'repo-frontend/' ya existe. Actualizando en vez de clonar..."
  git -C repo-frontend fetch origin "$BRANCH"
  git -C repo-frontend checkout "$BRANCH"
  git -C repo-frontend pull origin "$BRANCH"
else
  git clone -b "$BRANCH" "$FRONTEND_REPO" repo-frontend
fi

echo ""
echo "==> Listo. Estructura actual:"
ls -1

echo ""
echo "Nota: el codigo real del backend queda en 'repo-backend/backend/'"
echo "      (el repo lo trae anidado asi). El frontend queda directo"
echo "      en 'repo-frontend/'. El docker-compose.yml ya apunta a"
echo "      esas rutas como build context."
echo ""
echo "Siguiente paso:"
echo "  1) cp .env.example .env   (y completar los valores)"
echo "  2) docker compose up --build"
