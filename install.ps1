$ErrorActionPreference = "Stop"

$Repo = "azeezabass2005/treeln"
$Bin = "$env:LOCALAPPDATA\treeln\treeln.exe"

$Arch = if ([Environment]::Is64BitOperatingSystem) { "x86_64" } else { "x86" }

$Release = (Invoke-RestMethod "https://api.github.com/repos/$Repo/releases/latest")
$Url = $Release.assets | Where-Object { $_.name -like "*windows-$Arch*" } | Select-Object -First 1 -ExpandProperty browser_download_url

New-Item -ItemType Directory -Path (Split-Path $Bin) -Force | Out-Null
Invoke-WebRequest $Url -OutFile $Bin
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$(Split-Path $Bin)", "User")

Write-Host "treeln installed"
