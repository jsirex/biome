$ErrorActionPreference = "Stop"

$env:HAB_LICENSE = "accept-no-persist"

bio studio rm

& test/shared/test-all.ps1 -studio_command "bio studio"

exit $LASTEXITCODE
