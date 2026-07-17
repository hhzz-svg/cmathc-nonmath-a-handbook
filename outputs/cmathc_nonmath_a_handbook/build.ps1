$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Source = Join-Path $ProjectRoot "src\main.typ"
$OutputDir = Join-Path $ProjectRoot "output"
$PreviewDir = Join-Path $ProjectRoot "logs\preview"
$Pdf = Join-Path $OutputDir "全国大学生数学竞赛非数学A类备考手册.pdf"

$Typst = Get-Command typst -ErrorAction Stop
$Python = Get-Command python -ErrorAction Stop

New-Item -ItemType Directory -Force -Path $OutputDir, $PreviewDir | Out-Null

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
