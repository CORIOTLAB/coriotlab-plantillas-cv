# =============================================================
# CORIOTLAB — Setup de fuentes y verificacion de XeLaTeX (Hoja de Vida)
# Uso: .\setup_coriotlab.ps1
# Instala las fuentes desde el Kit de Marca ya incluido en este proyecto
# (no requiere conexion a internet).
# =============================================================

$ErrorActionPreference = "Stop"

$BASE = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  CORIOTLAB --- Configuracion del sistema"     -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# -------------------------------------------------------------
# 1. Verificar XeLaTeX
# -------------------------------------------------------------
Write-Host "[1/3] Verificando XeLaTeX..." -ForegroundColor Yellow

$xelatex = Get-Command xelatex -ErrorAction SilentlyContinue
if ($xelatex) {
    Write-Host "  OK  xelatex encontrado en: $($xelatex.Source)" -ForegroundColor Green
} else {
    Write-Host "  AVISO: xelatex no encontrado en el PATH." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Para instalar MiKTeX (incluye xelatex):" -ForegroundColor White
    Write-Host "  1. Descarga el instalador desde:" -ForegroundColor White
    Write-Host "        https://miktex.org/download" -ForegroundColor Cyan
    Write-Host "  2. Ejecuta el instalador y selecciona 'Install missing" -ForegroundColor White
    Write-Host "        packages on-the-fly' = Yes" -ForegroundColor White
    Write-Host "  3. Reinicia PowerShell y vuelve a ejecutar este script." -ForegroundColor White
    Write-Host ""
    Write-Host "  Continuando con la instalacion de fuentes..." -ForegroundColor Yellow
}

# -------------------------------------------------------------
# 2. Instalar fuentes desde el Kit de Marca (local, sin internet)
# -------------------------------------------------------------
Write-Host ""
Write-Host "[2/3] Instalando fuentes Inter, MuseoModerno y Space Mono..." -ForegroundColor Yellow

# La carpeta del kit de marca tiene espacios/tildes en el nombre; se ubica
# por coincidencia de prefijo en vez de escribir la ruta literal, para
# evitar problemas de codificacion en distintas terminales.
$kitMarca = Get-ChildItem -LiteralPath $BASE -Directory |
    Where-Object { $_.Name -like "*Kit de Marca*" } |
    Select-Object -First 1

if (-not $kitMarca) {
    Write-Host "  ERROR: No se encontro la carpeta del Kit de Marca en $BASE" -ForegroundColor Red
    Write-Host "  Instala las fuentes manualmente (ver README.md)." -ForegroundColor Yellow
} else {
    $tipografias = Get-ChildItem -LiteralPath $kitMarca.FullName -Directory |
        Where-Object { $_.Name -like "4*" } |
        Select-Object -First 1

    if (-not $tipografias) {
        Write-Host "  ERROR: No se encontro la subcarpeta de Tipografias." -ForegroundColor Red
    } else {
        $userFonts = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"
        New-Item -ItemType Directory -Force -Path $userFonts | Out-Null

        # Mapeo EXPLICITO origen -> nombre simple de destino. Es deliberado no
        # usar comodines/recursividad amplia aqui: el Kit de Marca incluye,
        # ademas de los 4 pesos estaticos que necesita la plantilla, variantes
        # "VariableFont" y opticas (18pt/24pt/28pt) que registran la MISMA
        # familia ("Inter") con metadatos distintos. Instalar ambas a la vez
        # crea un conflicto de familia que XeLaTeX/dvipdfmx no resuelve bien
        # (error "Invalid font" al generar el PDF). Por eso se elige UNA sola
        # variante por peso y se copia con un nombre de archivo simple y fijo.
        $mapeo = @(
            @{ Origen = "Inter\static\Inter_18pt-Regular.ttf";        Destino = "Inter-Regular.ttf" }
            @{ Origen = "Inter\static\Inter_18pt-Bold.ttf";           Destino = "Inter-Bold.ttf" }
            @{ Origen = "Inter\static\Inter_18pt-Italic.ttf";         Destino = "Inter-Italic.ttf" }
            @{ Origen = "Inter\static\Inter_18pt-BoldItalic.ttf";     Destino = "Inter-BoldItalic.ttf" }
            @{ Origen = "MuseoModerno\static\MuseoModerno-Regular.ttf";     Destino = "MuseoModerno-Regular.ttf" }
            @{ Origen = "MuseoModerno\static\MuseoModerno-Bold.ttf";        Destino = "MuseoModerno-Bold.ttf" }
            @{ Origen = "Space_Mono\SpaceMono-Regular.ttf";     Destino = "SpaceMono-Regular.ttf" }
            @{ Origen = "Space_Mono\SpaceMono-Bold.ttf";        Destino = "SpaceMono-Bold.ttf" }
            @{ Origen = "Space_Mono\SpaceMono-Italic.ttf";      Destino = "SpaceMono-Italic.ttf" }
            @{ Origen = "Space_Mono\SpaceMono-BoldItalic.ttf";  Destino = "SpaceMono-BoldItalic.ttf" }
        )

        $instaladas = 0
        $yaInstaladas = 0
        foreach ($item in $mapeo) {
            $origen  = Join-Path $tipografias.FullName $item.Origen
            $destino = Join-Path $userFonts $item.Destino
            if (Test-Path $destino) {
                $yaInstaladas++
                continue
            }
            if (-not (Test-Path $origen)) {
                Write-Host "  AVISO: no se encontro $($item.Origen) en el Kit de Marca." -ForegroundColor Yellow
                continue
            }
            Copy-Item $origen $destino -Force
            # Registrar la fuente para el perfil actual de Windows
            $shell = New-Object -ComObject Shell.Application
            $fontsFolder = $shell.Namespace(0x14)
            $fontsFolder.CopyHere($destino, 0x10)
            $instaladas++
        }

        if ($instaladas -gt 0) {
            Write-Host "  OK  $instaladas archivo(s) de fuente instalados en el perfil de Windows." -ForegroundColor Green
        }
        if ($yaInstaladas -gt 0) {
            Write-Host "  OK  $yaInstaladas archivo(s) ya estaban instalados (sin cambios)." -ForegroundColor Green
        }
        Write-Host "      (Inter, MuseoModerno, Space Mono)" -ForegroundColor Gray
    }
}

# -------------------------------------------------------------
# 3. Verificar estructura de carpetas
# -------------------------------------------------------------
Write-Host ""
Write-Host "[3/3] Verificando estructura de carpetas..." -ForegroundColor Yellow

$carpetas = @("plantilla", "ejemplos", "docs")

$ok = $true
foreach ($c in $carpetas) {
    $ruta = Join-Path $BASE $c
    if (Test-Path $ruta) {
        Write-Host "  OK  $c" -ForegroundColor Green
    } else {
        Write-Host "  ERROR: falta la carpeta '$c'" -ForegroundColor Red
        $ok = $false
    }
}

$tieneKit = [bool](Get-ChildItem -LiteralPath $BASE -Directory | Where-Object { $_.Name -like "*Kit de Marca*" })
$tieneMembretes = [bool](Get-ChildItem -LiteralPath $BASE -Directory | Where-Object { $_.Name -like "*embretes*" })

if ($tieneKit) { Write-Host "  OK  Kit de Marca" -ForegroundColor Green }
else { Write-Host "  ERROR: falta la carpeta del Kit de Marca" -ForegroundColor Red; $ok = $false }

if ($tieneMembretes) { Write-Host "  OK  Membretes" -ForegroundColor Green }
else { Write-Host "  ERROR: falta la carpeta de Membretes" -ForegroundColor Red; $ok = $false }

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
if ($ok) {
    Write-Host "  Sistema listo. Puedes compilar con:"      -ForegroundColor Green
    Write-Host "  .\compile.ps1 plantilla"                  -ForegroundColor White
    Write-Host "  .\compile.ps1 todos"                       -ForegroundColor White
} else {
    Write-Host "  Setup completado con advertencias."       -ForegroundColor Yellow
    Write-Host "  Revisa los mensajes anteriores."           -ForegroundColor Yellow
}
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""
