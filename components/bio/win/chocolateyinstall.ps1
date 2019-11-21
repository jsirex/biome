$version = '$version$'
$url = "https://packages.chef.io/files/biome/$version/bio-x86_64-windows.zip"
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksum = '$checksum$'

Install-ChocolateyZipPackage "biome" $url $unzipLocation -checksum $checksum -checksumType sha256
