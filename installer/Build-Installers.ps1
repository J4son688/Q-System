$ErrorActionPreference = "Stop"

$repositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$releaseRoot = Join-Path $repositoryRoot "release"
$publishRoot = Join-Path $releaseRoot "publish"
$installerRoot = Join-Path $releaseRoot "Installers"

$projects = @(
    @{
        Name = "Admin"
        Path = "desktop\PCDSQueue.Admin\PCDSQueue.Admin\PCDSQueue.Admin.csproj"
    },
    @{
        Name = "Staff"
        Path = "desktop\PCDSQueue.Staff\PCDSQueue.Staff\PCDSQueue.Staff.csproj"
    },
    @{
        Name = "Kiosk"
        Path = "kiosk\PCDSQueue.Kiosk\PCDSQueue.Kiosk\PCDSQueue.Kiosk.csproj"
    },
    @{
        Name = "TVDisplay"
        Path = "tv-display\PCDSQueue.TVDisplay\PCDSQueue.TVDisplay.csproj"
    }
)

New-Item -ItemType Directory -Force -Path $publishRoot, $installerRoot | Out-Null

foreach ($project in $projects) {
    $projectPath = Join-Path $repositoryRoot $project.Path
    $publishPath = Join-Path $publishRoot $project.Name
    Write-Host "Publishing $($project.Name)..."
    & dotnet publish $projectPath `
        --configuration Release `
        --runtime win-x64 `
        --self-contained true `
        --output $publishPath `
        -p:PublishSingleFile=true `
        -p:IncludeNativeLibrariesForSelfExtract=true `
        -p:DebugType=None `
        -p:DebugSymbols=false
    if ($LASTEXITCODE -ne 0) {
        throw "Publishing $($project.Name) failed with exit code $LASTEXITCODE."
    }
}

$compilerCandidates = @(
    (Get-Command ISCC.exe -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -First 1),
    (Join-Path ${env:ProgramFiles(x86)} "Inno Setup 6\ISCC.exe"),
    (Join-Path $env:ProgramFiles "Inno Setup 6\ISCC.exe"),
    (Join-Path $env:LOCALAPPDATA "Programs\Inno Setup 6\ISCC.exe")
) | Where-Object { $_ -and (Test-Path -LiteralPath $_) }

if (-not $compilerCandidates) {
    throw "Inno Setup 6 is required to create installer executables. Install it from https://jrsoftware.org/isinfo.php, then run this script again."
}

$compiler = $compilerCandidates | Select-Object -First 1
$installerScripts = @(
    "PCDSQueue.Admin.iss",
    "PCDSQueue.Staff.iss",
    "PCDSQueue.Kiosk.iss",
    "PCDSQueue.TVDisplay.iss"
)

foreach ($installerScript in $installerScripts) {
    Write-Host "Creating installer for $installerScript..."
    & $compiler (Join-Path $PSScriptRoot $installerScript)
    if ($LASTEXITCODE -ne 0) {
        throw "Compiling $installerScript failed with exit code $LASTEXITCODE."
    }
}

Write-Host ""
Write-Host "Installers created in $installerRoot"
