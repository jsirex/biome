# A simple test assertion that running `bio sup --help` will not
# attempt to install `biome/bio-sup` if that pkg is not present.

$env:TESTING_FS_ROOT = (Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName()))
$env:HAB_SUP_BINARY = $null

Describe "bio sup --help" {
  bio sup --help | Out-null

  It "runs successfully" {
    $LASTEXITCODE | Should -Be 0
  }
  It "does not install the supervisor package" {
    "$env:TESTING_FS_ROOT/hab/pkgs/biome/bio-sup" | Should -Not -Exist
  }
}
