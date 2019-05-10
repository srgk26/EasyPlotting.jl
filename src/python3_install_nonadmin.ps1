Register-PSRepository -Default -InstallationPolicy Trusted
Register-PackageSource -Name Nuget -Location "http://www.nuget.org/api/v2" –ProviderName Nuget -Trusted
find-package gitforwindows | install-package -Scope CurrentUser
find-package python | install-package -Scope CurrentUser
get-package python | % source
[System.Environment]::GetEnvironmentVariable('Path', 'User')
[System.Environment]::SetEnvironmentVariable('Path', $newPathInSingleStringSeparatedByColumn, 'User')
