$InstallDir='C:\ProgramData\chocoportable' ## Change install directory for non-admin users
$env:ChocolateyInstall="$InstallDir"
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Install Python3
choco upgrade python3 --confirm
