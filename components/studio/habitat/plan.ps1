$pkg_name="bio-studio"
$pkg_origin="core"
$pkg_version=Get-Content "$PLAN_CONTEXT/../../../VERSION"
$pkg_maintainer="The Biome Maintainers <humans@biome.sh>"
$pkg_license=@("Apache-2.0")
$pkg_build_deps=@(
  "core/powershell/$(Get-Content "$PLAN_CONTEXT/../../../POWERSHELL_VERSION")",
  "biome/bio",
  "biome/bio-plan-build-ps1",
  "core/7zip")
$pkg_bin_dirs=@("bin")

function Invoke-Build {
  Get-Content "$PLAN_CONTEXT/../bin/bio-studio.ps1" | % {
    $_.Replace("@author@", $pkg_maintainer).Replace("@version@", $pkg_version)
  } | Add-Content -Path bio-studio.ps1
}

function Invoke-Install {
  mkdir "$pkg_prefix/bin/powershell" | Out-Null
  mkdir "$pkg_prefix/bin/bio" | Out-Null
  mkdir "$pkg_prefix/bin/7zip" | Out-Null

  Copy-Item bio-studio.ps1 "$pkg_prefix/bin/bio-studio.ps1"
  Copy-Item $PLAN_CONTEXT/../bin/bio-studio.bat "$pkg_prefix/bin/bio-studio.bat"
  Copy-Item $PLAN_CONTEXT/../bin/SupervisorBootstrapper.cs "$pkg_prefix/bin/SupervisorBootstrapper.cs"

  Copy-Item "$(Get-HabPackagePath powershell)/bin/*" "$pkg_prefix/bin/powershell" -Recurse
  Copy-Item "$(Get-HabPackagePath bio)/bin/*" "$pkg_prefix/bin/bio"
  Copy-Item "$(Get-HabPackagePath 7zip)/bin/*" "$pkg_prefix/bin/7zip"
  Copy-Item "$(Get-HabPackagePath bio-plan-build-ps1)/bin/*" "$pkg_prefix/bin"
}
