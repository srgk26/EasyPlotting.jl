$InstallDir='C:\ProgramData\chocoportable' ## Change install directory for non-admin users
$env:ChocolateyInstall="$InstallDir"
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) ## Install Chocolatey

## Install basic packages
choco install puppet-agent.portable -y
choco install ruby.portable -y
choco install git.commandline -y
