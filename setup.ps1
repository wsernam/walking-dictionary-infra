# setup.ps1
# Clona los repositorios de backend y frontend (rama develop) dentro
# de este repo de infraestructura. Ejecutar una sola vez despues de
# clonar walking-dictionary-infra, o cada vez que se necesite
# actualizar ambos repos.

$ErrorActionPreference = "Stop"

$BackendRepo  = "https://github.com/wsernam/A-Walking-Dictionary-NovaCode-Back-end.git"
$FrontendRepo = "https://github.com/knnsand/A-Walking-Dictionary-NovaCode-Front-end.git"
$BackendDir  = "A-Walking-Dictionary-NovaCode-Back-end"
$FrontendDir = "A-Walking-Dictionary-NovaCode-Front-end"
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
Clone-OrUpdate -RepoUrl $BackendRepo -FolderName $BackendDir

Write-Host "==> Clonando frontend (rama $Branch)..."
Clone-OrUpdate -RepoUrl $FrontendRepo -FolderName $FrontendDir

Write-Host ""
Write-Host "==> Listo. Estructura actual:"
Get-ChildItem -Name

Write-Host ""
Write-Host "Nota: el codigo real del backend queda en"
Write-Host "      '$BackendDir\backend\' (el repo lo trae anidado asi)."
Write-Host "      El frontend queda directo en '$FrontendDir\'."
Write-Host "      El docker-compose.yml ya apunta a esas rutas como build context."
Write-Host ""
Write-Host "Siguiente paso:"
Write-Host "  1) Copy-Item .env.example .env   (y completar los valores)"
Write-Host "  2) docker compose up --build"
