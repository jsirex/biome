Describe "gossiping new config" {
    Load-SupervisorService "core/redis" -Remote "alpha.biome.dev"
    Load-SupervisorService "biome-testing/test-probe" -Bind "thing_with_a_port:redis.default" -Remote "beta.biome.dev"

    It "probe service should bind to redis 6379" {
        $current_port = (Invoke-WebRequest "http://beta.biome.dev:8000/context" | ConvertFrom-Json).bind.thing_with_a_port.first.cfg.port
        $current_port | Should -Be 6379
    }

    Context "Apply config change" {
        $new_port=1234
        Set-Content redis_config.toml -Value "port = $new_port`nprotected-mode = `"no`""
        bio config apply `
            redis.default `
        ([DateTime]::Now.Ticks) `
            redis_config.toml `
            --remote-sup=bastion.biome.dev
        Start-Sleep 40 # Long, because test-probe has long init and post-stop hooks
        It "probe service should bind to changed redis port" {
            $current_port = (Invoke-WebRequest "http://beta.biome.dev:8000/context" | ConvertFrom-Json).bind.thing_with_a_port.first.cfg.port
            $current_port | Should -Be $new_port
        }
    }
}
