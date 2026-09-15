# setup.ps1
# Clona los repositorios de backend y frontend (rama develop) dentro
# de este repo de infraestructura. Ejecutar una sola vez despues de
# clonar walking-dictionary-infra, o cada vez que se necesite
# actualizar ambos repos.

$ErrorActionPreference = "Stop"

$BackendRepo  = "https://github.com/wsernam/A-Walking-Dictionary-NovaCode-Back-end.git"
$FrontendRepo = "https://github.com/knnsand/A-Walking-Dictionary-NovaCode-Front-end.git"
$Branch = "develop"

function Clone-OrUpdate {
    param(
        [string]$RepoUrl,
        [string]$FolderName
    )

    if (Test-Path $FolderName) {
        Write-Host "La carpeta '$FolderName/' ya existe. Actualizando en vez de clonar..."
        git -C $FolderName fetch origin $Branch
        git -C $FolderName checkout $Branch
        git -C $FolderName pull origin $Branch
    } else {
        git clone -b $Branch $RepoUrl $FolderName
    }
}

Write-Host "==> Clonando backend (rama $Branch)..."
Clone-OrUpdate -RepoUrl $BackendRepo -FolderName "repo-backend"

Write-Host "==> Clonando frontend (rama $Branch)..."
Clone-OrUpdate -RepoUrl $FrontendRepo -FolderName "repo-frontend"

Write-Host ""
Write-Host "==> Listo. Estructura actual:"
Get-ChildItem -Name

Write-Host ""
Write-Host "Nota: el codigo real del backend queda en 'repo-backend\backend\'"
Write-Host "      (el repo lo trae anidado asi). El frontend queda directo"
Write-Host "      en 'repo-frontend\'. El docker-compose.yml ya apunta a"
Write-Host "      esas rutas como build context."
Write-Host ""
Write-Host "Siguiente paso:"
Write-Host "  1) Copy-Item .env.example .env   (y completar los valores)"
Write-Host "  2) docker compose up --build"
