if ($IsWindows) {
    $test_probe_release="biome-testing/test-probe/0.1.0/20200716152719"
} else {
    $test_probe_release="biome-testing/test-probe/0.1.0/20200716143058"
}

Describe "HTTP gateway" {
    AfterAll {
        Unload-SupervisorService -PackageName biome-testing/test-probe -Timeout 30
        Stop-Supervisor
    }

    $supLog = New-SupervisorLogFile("test_health_check_output_of_http_gateway")
    Start-Supervisor -LogFile $supLog -Timeout 45

    Context "with a service with a health-check hook" {
        Load-SupervisorService "biome-testing/test-probe"
        Wait-Release -Ident $test_probe_release

        # test-probe has a long init hook, and we want
        # to let the health-check hoo
        Start-Sleep 20

        It "returns output of the hook when queried" {
            $stdout = (Invoke-WebRequest "http://localhost:9631/services/test-probe/default/health" | ConvertFrom-Json).stdout
            $stdout | Should -MatchExactly "Running health_check hook: biome-testing/test-probe"
        }
    }
}
