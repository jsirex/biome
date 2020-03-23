# Test the at-once service update strategy
# The timing of this test assumes the following environment variables are set:
# HAB_UPDATE_STRATEGY_FREQUENCY_MS=3000
# HAB_UPDATE_STRATEGY_FREQUENCY_BYPASS_CHECK=1

$env:HAB_AUTH_TOKEN = $env:PIPELINE_HAB_AUTH_TOKEN

$supLog = New-TemporaryFile
Start-Supervisor -LogFile $supLog -Timeout 45 | Out-Null
$testChannel="at-once-$([DateTime]::Now.Ticks)"
$pkg="biome-testing/nginx"
$initialRelease="biome-testing/nginx/1.17.4/20191115184838"
$updatedRelease="biome-testing/nginx/1.17.4/20191115185517"

Describe "at-once update and rollback" {
    bio pkg promote $initialRelease $testChannel
    Load-SupervisorService $pkg -Strategy "at-once" -UpdateCondition "track-channel" -Channel $testChannel

    It "loads initial release" {
        Wait-Release -Ident $initialRelease
    }

    Context "promote update" {
        bio pkg promote $updatedRelease $testChannel

        It "updates release" {
            Wait-Release -Ident $updatedRelease
        }
    }

    Context "demote update" {
        bio pkg demote $updatedRelease $testChannel

        It "rollback release" {
            Wait-Release -Ident $initialRelease
        }
    }

    AfterAll {
        bio bldr channel destroy $testChannel --origin biome-testing
        Unload-SupervisorService -PackageName $pkg -Timeout 20
        Stop-Supervisor
    }
}
