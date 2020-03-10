# This is a simple "happy path" test of a rolling update.
# We will load services on two nodes to achieve quorum and
# then promote an update and expect the new release to show
# up after waiting 15 seconds. Note: we set HAB_UPDATE_STRATEGY_FREQUENCY_MS
# to 3000 in the docker-compose.override.yml.

$testChannel = "rolling-$([DateTime]::Now.Ticks)"

Describe "Rolling Update and Rollback" {
    $initialRelease="biome-testing/nginx/1.17.4/20191115184838"
    $updatedRelease="biome-testing/nginx/1.17.4/20191115185517"
    bio pkg promote $initialRelease $testChannel
    Load-SupervisorService "biome-testing/nginx" -Remote "alpha.biome.dev" -Topology leader -Strategy rolling -UpdateCondition "track-channel" -Channel $testChannel
    Load-SupervisorService "biome-testing/nginx" -Remote "beta.biome.dev" -Topology leader -Strategy rolling -UpdateCondition "track-channel" -Channel $testChannel

    @("alpha", "beta") | ForEach-Object {
        It "loads initial release on $_" {
            Wait-Release -Ident $initialRelease -Remote $_
        }
    }

    Context "promote update" {
        bio pkg promote $updatedRelease $testChannel

        @("alpha", "beta") | ForEach-Object {
            It "updates release on $_" {
                Wait-Release -Ident $updatedRelease -Remote $_
            }
        }
    }

    Context "demote update" {
        bio pkg demote $updatedRelease $testChannel

        @("alpha", "beta") | ForEach-Object {
            It "rollback release on $_" {
                Wait-Release -Ident $initalRelease -Remote $_
            }
        }
    }

    AfterAll {
        bio bldr channel destroy $testChannel --origin biome-testing
    }
}
