# This tests that removing the leader from a functioning 2 node leader topology
# service group will continue to perform a succesful rolling update after a new
# member is added to the group and quorum is reestablished.
#
# We will load services on two nodes and perform a rolling update. Next we stop
# the supervisor on the leader node and then load an older version of the service
# on a new node reestablishing quorum. Next we perform an update and expect all
# nodes to update. Prior to https://github.com/habitat-sh/habitat/pull/7167, if
# the newly added node is elected the leader, the follower which has a newer
# version of the service will end up in a state where it is continually updating
# to the older version of the leader, restarting the service and loading the newer
# service, then updating to the older leader version and so on until the end of
# its precious life. Now followers should never consider an older version a
# candidate for updating.

$testChannel = "rolling-$([DateTime]::Now.Ticks)"

Describe "Rolling Update after a follower is removed and quorum is not lost" {
    $release1="biome-testing/nginx/1.17.4/20191115184838"
    $release2="biome-testing/nginx/1.17.4/20191115185517"
    $release3="biome-testing/nginx/1.17.4/20191115185900"
    bio pkg promote $release1 $testChannel
    Load-SupervisorService "biome-testing/nginx" -Remote "alpha.biome.dev" -Topology leader -Strategy rolling -Channel $testChannel
    Load-SupervisorService "biome-testing/nginx" -Remote "beta.biome.dev" -Topology leader -Strategy rolling -Channel $testChannel

    @("alpha", "beta") | ForEach-Object {
        It "loads initial release on $_" {
            Wait-Release -Ident $release1 -Remote $_
        }
    }

    Context "promote $release2" {
        bio pkg promote $release2 $testChannel

        @("alpha", "beta") | ForEach-Object {
            It "updates to $release2 on $_" {
                Wait-Release -Ident $release2 -Remote $_
            }
        }

        Context "Stop leader and reestablish quorum with an older release on gamma then promote $release3" {
            $leader = Get-Leader "bastion" "nginx.default"
            Stop-ComposeSupervisor $leader.Name
            docker exec "${env:COMPOSE_PROJECT_NAME}_gamma_1" bio pkg install $release1
            Start-Sleep 10
            Load-SupervisorService "biome-testing/nginx" -Remote "gamma.biome.dev" -Topology leader -Strategy rolling -Channel $testChannel
            bio pkg promote $release3 $testChannel

            @("alpha", "beta", "gamma") | Where-Object { $_ -ne $leader.Name } | ForEach-Object {
                It "updates to $release3 on $_" {
                    Wait-Release -Ident $release3 -Remote $_
                }
            }
        }
    }

    AfterAll {
        bio bldr channel destroy $testChannel --origin biome-testing
    }
}
