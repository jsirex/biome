#!/usr/bin/env powershell

#Requires -Version 5

class HabShared {
  static [String]install_base_biome_binary([String]$Version, [String]$Channel) {

      if($Version.Equals("latest")) {
          # Get the latest version available from bintray
          $current_protocols = [Net.ServicePointManager]::SecurityProtocol
          $latestVersionURI = ""
          $downloadUrl = ""
          try {
              [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
              $response = Invoke-WebRequest "https://bintray.com/biome/$Channel/bio-x86_64-windows/_latestVersion" -UseBasicParsing -ErrorAction Stop
              $latestVersionURI = ($response).BaseResponse.ResponseUri.AbsoluteUri
          }
          finally {
              [Net.ServicePointManager]::SecurityProtocol = $current_protocols
          }
          
          $uriArray = $latestVersionURI.Split("/")
          $targetVersion = $uriArray[$uriArray.Length-1]
          Write-Host "--- Latest version is $targetVersion"
          $downloadUrl = "https://api.bintray.com/content/biome/$Channel/windows/x86_64/bio-$targetVersion-x86_64-windows.zip?bt_package=bio-x86_64-windows"
      }
      else {
        # This line of code is silly.
        $targetVersion = $Version.Replace("/", "-").Replace("\", "-")
        Write-Host "--- Targeting version $targetVersion"
        $downloadUrl = "http://biome.bintray.com/$Channel/windows/x86_64/bio-$targetVersion-x86_64-windows.zip"
      }
      
      $bootstrapDir = "C:\bio-" + "$targetVersion"

      # download a bio binary to build bio from source in a studio
      Write-Host "--- Downloading from $downloadUrl"
      $current_protocols = [Net.ServicePointManager]::SecurityProtocol
      try {
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          Invoke-WebRequest -UseBasicParsing -Uri "$downloadUrl" -OutFile bio.zip -ErrorAction Stop
      }
      finally {
          [Net.ServicePointManager]::SecurityProtocol = $current_protocols
      }
      Write-Host "--- Extracting to $bootstrapDir"
      New-Item -ItemType directory -Path $bootstrapDir -Force -ErrorAction Stop
      Expand-Archive -Path bio.zip -DestinationPath $bootstrapDir -ErrorAction Stop
      Remove-Item bio.zip -Force
      $baseHabExe = (Get-Item "$bootstrapDir\bio-$targetVersion-x86_64-windows\bio.exe").FullName

      return $baseHabExe
  }

  static [void]import_keys([String]$HabExe) {
    Write-Host "--- :key: Downloading 'core' public keys from Builder"
    Invoke-Expression "$HabExe origin key download core" -ErrorAction Stop
    $bio_auth_token = (Get-ChildItem Env:HAB_AUTH_TOKEN).Value
    Write-Host "--- :closed_lock_with_key: Downloading latest 'core' secret key from Builder"
    Invoke-Expression "$HabExe origin key download core --auth $bio_auth_token --secret" -ErrorAction Stop
    $Env:HAB_CACHE_KEY_PATH = "C:\hab\cache\keys"
    $Env:HAB_ORIGIN = "core"
  }
}
