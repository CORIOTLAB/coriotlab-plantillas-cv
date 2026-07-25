# =============================================================
# CORIOTLAB — Script de compilacion XeLaTeX (Hoja de Vida)
# Uso: .\compile.ps1 [tipo]
# Tipos: plantilla | ejemplo | todos
# =============================================================

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("plantilla","ejemplo","todos")]
    [string]$Tipo = "todos"
)

$BASE = Split-Path -Parent $MyInvocation.MyCommand.Path

$DOCUMENTOS = @{
    "plantilla" = "plantilla\plantilla_hoja_de_vida.tex"
    "ejemplo"   = "ejemplos\hoja_de_vida_ejemplo_completa.tex"
}

$TODOS_DOCS = @("plantilla","ejemplo")

$AUX_EXT = @("*.aux","*.log","*.out","*.toc","*.lof","*.lot","*.nav","*.snm",
              "*.vrb","*.synctex.gz","*.fls","*.fdb_latexmk","*.xdv","*.bcf","*.run.xml")

function Compilar-Documento {
    param([string]$NombreTipo, [string]$RutaTex)

    $texPath = Join-Path $BASE $RutaTex
    $texDir  = Split-Path $texPath -Parent
    $texFile = Split-Path $texPath -Leaf
    $pdfName = [System.IO.Path]::GetFileNameWithoutExtension($texFile) + ".pdf"
    $pdfPath = Join-Path $texDir $pdfName

    Write-Host ""
    Write-Host "  Compilando: $NombreTipo" -ForegroundColor Yellow
    Write-Host "  Archivo:    $texPath" -ForegroundColor Gray

    if (-not (Test-Path $texPath)) {
        Write-Host "  ERROR: Archivo no encontrado: $texPath" -ForegroundColor Red
        return
    }

    # Se guarda la fecha de modificacion previa del PDF para detectar si
    # la compilacion realmente actualizo el archivo (dvipdfmx puede fallar
    # en silencio si el PDF esta abierto en un visor bloqueando la escritura).
    $pdfPrevTime = $null
    if (Test-Path $pdfPath) {
        $pdfPrevTime = (Get-Item $pdfPath).LastWriteTime
    }

    $prevLoc = Get-Location
    Set-Location $texDir

    $xeArgs = @("-interaction=nonstopmode", $texFile)

    # Doble pasada obligatoria (referencias cruzadas / hipervinculos)
    & xelatex @xeArgs 2>&1 | Out-Null
    & xelatex @xeArgs 2>&1 | Out-Null

    Set-Location $prevLoc

    $pdfActualizado = (Test-Path $pdfPath) -and
        ((-not $pdfPrevTime) -or ((Get-Item $pdfPath).LastWriteTime -gt $pdfPrevTime))

    if ($pdfActualizado) {
        $size = [math]::Round((Get-Item $pdfPath).Length / 1KB, 1)
        Write-Host "  OK  PDF generado: $RutaTex -> $pdfName  ($size KB)" -ForegroundColor Green
    } elseif (Test-Path $pdfPath) {
        Write-Host "  AVISO: el PDF no se actualizo. Si tienes '$pdfName' abierto" -ForegroundColor Yellow
        Write-Host "         en un visor (ej. PDFgear, Adobe), ciérralo y vuelve a compilar." -ForegroundColor Yellow
    } else {
        Write-Host "  ERROR al compilar $NombreTipo. Revisa el .log en: $texDir" -ForegroundColor Red
    }

    # Limpiar auxiliares
    foreach ($ext in $AUX_EXT) {
        Get-ChildItem -Path $texDir -Filter $ext -ErrorAction SilentlyContinue |
            Remove-Item -Force -ErrorAction SilentlyContinue
    }
}

# -------------------------------------------------------------
Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  CORIOTLAB --- Compilador XeLaTeX (Hoja de Vida)" -ForegroundColor Cyan
Write-Host "  Tipo: $Tipo"                                 -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

if ($Tipo -eq "todos") {
    foreach ($key in $TODOS_DOCS) {
        Compilar-Documento -NombreTipo $key -RutaTex $DOCUMENTOS[$key]
    }
} else {
    Compilar-Documento -NombreTipo $Tipo -RutaTex $DOCUMENTOS[$Tipo]
}

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  Compilacion finalizada."                     -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""
