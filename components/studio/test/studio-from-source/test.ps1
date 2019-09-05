$ErrorActionPreference = "Stop"

$env:HAB_LICENSE = "accept-no-persist"

$env:studio_command = "bin/bio-studio.ps1"

bio pkg install core/powershell
bio pkg install core/7zip
bio pkg install biome/bio 
bio pkg install biome/bio-plan-build-ps1 

mkdir "bin/powershell" | Out-Null
mkdir "bin/bio" | Out-Null
mkdir "bin/7zip" | Out-Null

Copy-Item "$(bio pkg path core/powershell)/bin/*" "bin/powershell" -Recurse
Copy-Item "$(bio pkg path biome/bio)/bin/*" "bin/bio"
Copy-Item "$(bio pkg path core/7zip)/bin/*" "bin/7zip"
Copy-Item "$(bio pkg path biome/bio-plan-build-ps1)/bin/*" "bin/"

try {
    & test/shared/test-all.ps1 -studio_command "bin/bio-studio.ps1"
    $exit_code = $LASTEXITCODE
} finally {
    # The tests can exit before the Studio or Await have closed all open 
    # handles to the following files/directories. This sleep gives those 
    # processes a chance to finish.  
    sleep 5
    Remove-Item "bin/7zip" -Recurse
    Remove-Item "bin/powershell" -Recurse
    Remove-Item "bin/bio" -Recurse
    Remove-Item "bin/*"
}
exit $exit_code
