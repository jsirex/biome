$version = '$version$'
$url = "https://bintray.com/biome/stable/download_file?file_path=windows%2Fx86_64%2Fbio-$version-x86_64-windows.zip"
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksum = '$checksum$'

Install-ChocolateyZipPackage "biome" $url $unzipLocation -checksum $checksum -checksumType sha256
