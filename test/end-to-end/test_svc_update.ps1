# For *some reason* this incoming environment variable has quotes,
# which throws everything off, but apparently only on Windows.
$env:HAB_AUTH_TOKEN = $env:PIPELINE_HAB_AUTH_TOKEN.Replace("`"", "")

$testChannelOne="dynamic-update-one-$([DateTime]::Now.Ticks)"
$testChannelTwo="dynamic-update-two-$([DateTime]::Now.Ticks)"
$nginx_pkg="biome-testing/nginx"
if ($IsWindows) {
    $nginx_release="biome-testing/nginx/1.18.0/20200626143933"
} else {
    $nginx_release="biome-testing/nginx/1.18.0/20200626184200"
}
if ($IsWindows) {
    $test_probe_release="biome-testing/test-probe/0.1.0/20200716152719"
} else {
    $test_probe_release="biome-testing/test-probe/0.1.0/20200716143058"
}

Describe "bio svc update" {
    AfterAll {
        bio bldr channel destroy $testChannelOne --origin biome-testing
        bio bldr channel destroy $testChannelTwo --origin biome-testing
        Unload-SupervisorService -PackageName $nginx_pkg -Timeout 20
        Stop-Supervisor
    }

    $supLog = New-SupervisorLogFile("test_svc_update")
    Start-Supervisor -LogFile $supLog -Timeout 45
    Load-SupervisorService $nginx_release
    Wait-Release -Ident $nginx_release

    Context "with a bound service" {
        Load-SupervisorService biome-testing/test-probe -Bind "thing_with_a_port:nginx.default"
        Wait-Release -Ident $test_probe_release
        Start-Sleep 15 # test-probe has a long init hook

        It "starts test-probe bound to nginx" {
            '/hab/sup/default/specs/test-probe.spec' | Should -FileContentMatchExactly 'binds = \["thing_with_a_port:nginx.default"\]'
        }

        AfterEach {
            Unload-SupervisorService -PackageName biome-testing/test-probe -Timeout 30
        }
    }

    Context "removing binds via bio svc update" {
        Load-SupervisorService biome-testing/test-probe -Bind "thing_with_a_port:nginx.default"
        Wait-Release -Ident $test_probe_release
        Start-Sleep 15 # test-probe has a long init hook

        $proc = Get-Process "test-probe"

        # This is the same as saying "remove binds"... we might
        # find a better way to express this, though.
        bio svc update biome-testing/test-probe --bind

        # Currently, test-probe has some long-running post-stop
        # and init hooks. They should be done within 30 seconds,
        # but we'll give *plenty* of extra time for the full
        # restart, just in case gremlins appear.
        Start-Sleep -Seconds 45

        It "has the new binds in the spec file" {
            '/hab/sup/default/specs/test-probe.spec' | Should -FileContentMatchExactly 'binds = \[\]'
        }

        It "DOES restart the service process" {
            $currentProc = Get-Process "test-probe"
            $proc.Id | Should -Not -Be $currentProc.Id
        }

        #AfterAll {
        Unload-SupervisorService -PackageName biome-testing/test-probe -Timeout 30
        #}
    }

    Context "updating another field does not wipe out existing binds" {
        Load-SupervisorService biome-testing/test-probe -Bind "thing_with_a_port:nginx.default"
        Wait-Release -Ident $test_probe_release
        Start-Sleep 15 # test-probe has a long init hook

        $proc = Get-Process test-probe

        bio svc update biome-testing/test-probe --strategy=at-once

        # This shouldn't take too long to register, and shouldn't
        # trigger a restart, but to catch potential regressions
        # that *do* restart the service, we'll wait for the long
        # post-stop and init hooks to run, as before.
        Start-Sleep -Seconds 45

        It "leaves the existing binds alone" {
            '/hab/sup/default/specs/test-probe.spec' | Should -FileContentMatchExactly 'binds = \["thing_with_a_port:nginx.default"\]'
        }

        It "updates the update strategy" {
            '/hab/sup/default/specs/test-probe.spec' | Should -FileContentMatchExactly 'update_strategy = "at-once"'
        }

        It "does not restart the service process" {
            $currentProc = Get-Process test-probe
            $proc.Id | Should -Be $currentProc.Id
        }

        #AfterAll {
        Unload-SupervisorService -PackageName biome-testing/test-probe -Timeout 30
        #}
    }

    # This is an imperfect test, but useful nevertheless.
    #
    # There are some aspects of a Biome service's runtime configuration
    # (from the Supervisor's perspective) that can be changed without
    # requiring a service restart. At the time of writing, this is limited
    # to details of how a service is updated (e.g., what channel updates
    # are coming from).
    #
    # Testing this can be a little tricky, because changing how a service
    # is updated can actually cause the service to restart *for a new
    # update*. There aren't currently great ways to probe the Supervisor
    # to ask details about the update process for a service (e.g., by
    # using a `bio` command, which would be pretty nice, actually).
    #
    # Instead, what we'll do here is set up two channels with the same
    # package in each. We'll start the service set to update from the one
    # channel, then switch it to the other. We'll confirm the PID of the
    # process has not changed, while looking at the contents of the
    # service's spec file, which should have changed.
    #
    # It's not great, in that it's not a positive confirmation (e.g.,
    # breaking the process of discovering a change to the spec file on
    # disk would yield the same result), but it's better than nothing.
    Context "an updating service" {
        bio pkg promote $nginx_release $testChannelOne
        bio pkg promote $nginx_release $testChannelTwo

        Load-SupervisorService $nginx_pkg -Force -Strategy "at-once" -Channel $testChannelOne
        Start-Sleep 10

        $proc = Get-Process "nginx"

        It "starts updating from the first channel" {
            '/hab/sup/default/specs/nginx.spec' | Should -FileContentMatchExactly "channel = `"$testChannelOne`""
        }

        bio svc update $nginx_pkg --channel $testChannelTwo

        # Give *plenty* of time to pick up the new spec (as well as
        # time for a service to restart, if things are broken and
        # that's a thing that could happen).
        Start-Sleep -Seconds 10

        It "has the new channel in the spec file" {
            '/hab/sup/default/specs/nginx.spec' | Should -FileContentMatchExactly "channel = `"$testChannelTwo`""
            '/hab/sup/default/specs/nginx.spec' | Should -FileContentMatchExactly 'update_strategy = "at-once"'
        }

        It "does not restart the service process" {
            $currentProc = Get-Process "nginx"
            $proc.Id | Should -Be $currentProc.Id
        }
    }
}
