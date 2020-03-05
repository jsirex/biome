# Test the at-once service update strategy

$env:HAB_AUTH_TOKEN = $env:PIPELINE_HAB_AUTH_TOKEN

$supLog = New-TemporaryFile
Start-Supervisor -LogFile $supLog -Timeout 45 | Out-Null
$testChannel="at-once-$([DateTime]::Now.Ticks)"
$pkg="biome-testing/nginx"
$initialRelease="biome-testing/nginx/1.17.4/20191115184838"
$updatedRelease="biome-testing/nginx/1.17.4/20191115185517"

Describe "at-once update" {
    bio pkg promote $initialRelease $testChannel
    Load-SupervisorService $pkg -Strategy "at-once" -Channel $testChannel

    It "loads initial release" {
        Wait-Release -Ident $initialRelease
    }

    Context "promote update" {
        bio pkg promote $updatedRelease $testChannel

        It "updates release" {
            Wait-Release -Ident $updatedRelease
        }
    }

    AfterAll {
        bio bldr channel destroy $testChannel --origin biome-testing
        Unload-SupervisorService -PackageName $pkg -Timeout 20
        Stop-Supervisor
    }
}
