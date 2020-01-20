$pkg_name="dummy-scaffolding"
$pkg_origin="biome-testing"
$pkg_version="0.1.0"

function Invoke-Install {
  Copy-Item "$PLAN_CONTEXT/lib" $pkg_prefix -Recurse -Force
}
