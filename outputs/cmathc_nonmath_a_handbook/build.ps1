$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Source = Join-Path $ProjectRoot "src\main.typ"
$OutputDir = Join-Path $ProjectRoot "output"
$LogDir = Join-Path $ProjectRoot "logs"
$PreviewDir = Join-Path $ProjectRoot "logs\preview"
$PdfName = -join ([char]20840, [char]22269, [char]22823, [char]23398, [char]29983, [char]25968, [char]23398, [char]31454, [char]36187, [char]38750, [char]25968, [char]23398, [char]65, [char]31867, [char]22791, [char]32771, [char]25163, [char]20876, ".pdf")
$Pdf = Join-Path $OutputDir $PdfName

$Typst = Get-Command typst -ErrorAction Stop
$Python = Get-Command python -ErrorAction Stop

Set-Location $ProjectRoot
New-Item -ItemType Directory -Force -Path $OutputDir, $LogDir, $PreviewDir | Out-Null

function Invoke-Checked {
    param(
        [Parameter(Mandatory = $true)]
        [scriptblock]$Command,
        [Parameter(Mandatory = $true)]
        [string]$Description
    )

    & $Command
    if ($LASTEXITCODE -ne 0) {
        throw "$Description failed with exit code $LASTEXITCODE"
    }
}

Invoke-Checked -Description "Typst compile" -Command {
    & $Typst.Source compile --root $ProjectRoot $Source $Pdf
}
Invoke-Checked -Description "Page-count check" -Command {
    & $Python.Source (Join-Path $ProjectRoot "scripts\check_page_count.py") $Pdf
}
Invoke-Checked -Description "Content check" -Command {
    & $Python.Source (Join-Path $ProjectRoot "scripts\check_content.py") $ProjectRoot
}
Invoke-Checked -Description "PDF preview render" -Command {
    & $Python.Source (Join-Path $ProjectRoot "scripts\render_preview.py") $Pdf $PreviewDir --dpi 144
}

Write-Host "BUILD_OUTPUT=$Pdf"
