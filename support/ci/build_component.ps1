#!/usr/bin/env powershell

#Requires -Version 5

param (
    # The name of the component to be built. Defaults to none
    [string]$Component
)

. $PSScriptRoot\shared.ps1
Install-Biome

# Since we are only verifying we don't have build failures, make everything
# temp!
$env:HAB_ORIGIN="throwaway"
# let's make a selfcontained tempdir for this job
$job_temp_root = mkdir (Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName()))
$env:HAB_CACHE_KEY_PATH="$job_temp_root/keys"

Write-Host "--- :key: Generating fake origin key"
bio origin key generate
Write-Host "--- :bio: Running bio pkg build for $Component"

bio studio build components/$Component -R

exit $LASTEXITCODE
