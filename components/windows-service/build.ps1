function Test-PullRequest {
    ($env:APPVEYOR_REPO_BRANCH -like 'master') -and
        (test-path env:/APPVEYOR_PULL_REQUEST_NUMBER) -and
        (-not [string]::IsNullOrEmpty($env:APPVEYOR_PULL_REQUEST_NUMBER))
}

if(Test-PullRequest) {
    $channel = "unstable"
}
else {
    $channel = "stable"
}

$bootstrapDir = "c:\biome"
$url = "https://api.bintray.com/content/biome/stable/windows/x86_64/bio-$($env:bio_exe_version)-x86_64-windows.zip?bt_package=bio-x86_64-windows"
mkdir $bootstrapDir -Force
Write-Host "Download and install latest release of bio.exe from $url"
Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile bio.zip
Expand-Archive -Path bio.zip -DestinationPath $bootstrapDir -Force
Remove-Item bio.zip -Force
$bioExe = (Get-Item "$bootstrapDir/*/bio.exe").FullName

$env:HAB_ORIGIN="core"
if($env:ORIGIN_KEY) {
    "SIG-SEC-1`ncore-20170318210306`n`n$($env:ORIGIN_KEY)" | & $bioExe origin key import
}
else {
    Write-Host "Generating fake secret origin key for core..."
    & $bioExe origin key generate core
}
if ($LASTEXITCODE -ne 0) {exit $LASTEXITCODE}

& $bioExe pkg build . -w
if ($LASTEXITCODE -ne 0) {exit $LASTEXITCODE}

$hart = (Get-Item "results\*.hart")[-1]
& $bioExe pkg install $hart.FullName
if ($LASTEXITCODE -ne 0) {exit $LASTEXITCODE}

$binPath = (Resolve-Path "/hab/pkgs/core/windows-service/*/*/bin").Path
$pathParts = $binPath.Split("\")
$versionStamp = "$($pathParts[-3])-$($pathParts[-2])"
Update-AppveyorBuild -Version $versionStamp

& $bioExe pkg exec core/windows-service install
if(!(Get-Service Biome -ErrorAction SilentlyContinue)) {
    Throw "The Biome service was not installed!"
}
Start-Service Biome
if((Get-Service Biome).Status -ne "Running") {
    Throw "The Biome service was unable to start!"
}

$retry = 0
while ($retry -lt 10 -and !((Test-NetConnection localhost -Port 9632).TcpTestSucceeded)) {
    Write-Host "Waiting for Supervisor to listen on 9632..."
    Start-Sleep -Seconds 1
    $retry += 1
}

Write-Host "Validating we can talk to a running supervisor"
& $bioExe svc status
if ($LASTEXITCODE -ne 0) {exit $LASTEXITCODE}

if($env:HAB_AUTH_TOKEN) {
    & $bioExe pkg upload $hart --channel $channel
    if ($LASTEXITCODE -ne 0) {exit $LASTEXITCODE}
}
