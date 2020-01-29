[Diagnostics.CodeAnalysis.SuppressMessage("PSUseApprovedVerbs", '', Scope="function")]
param()
function Load-Scaffolding {
    $pkg_deps += @("biome-testing/dummy")
    $pkg_build_deps += @("biome-testing/dummy-bio-user")
}
