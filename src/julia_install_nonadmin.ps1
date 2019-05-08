$InstallDir='C:\ProgramData\chocoportable' ## Change install directory for non-admin users
$env:ChocolateyInstall="$InstallDir"
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) ## Install Chocolatey

## Install Julia
choco install julia --confirm
