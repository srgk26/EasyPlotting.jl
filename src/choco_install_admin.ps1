Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Install basic packages
choco install puppet-agent.portable -y
choco install ruby.portable -y
choco install git.commandline -y
