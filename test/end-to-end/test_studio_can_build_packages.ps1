# `build` is a built-in helper function that maps to `bio pkg exec biome/bio-plan-build`
# rather than `bio pkg build` to avoid 'studio-in-studio' situations. Verify that the
# command functions. We assume that if the build succeeds (exits 0) we've passed this
# test, and leave more detailed testing to the build output to e2e tests for bio-plan-build
bio origin key generate $env:HAB_ORIGIN

Describe "Studio build" {
    foreach($plan in @(
            "plan-in-root",
            "plan-in-biome",
            "plan-in-target",
            "plan-in-biome-target"
        )) {
        It "builds $plan" {
            bio pkg build test/fixtures/$plan
            $LASTEXITCODE | Should -Be 0
        }
    }

    It "does not build plan-in-root-and-biome" {
        bio pkg build test/fixtures/plan-in-root-and-biome
        $LASTEXITCODE | Should -Not -Be 0
    }

    It "does not build plan-in-none" {
        bio pkg build test/fixtures/plan-in-none
        $LASTEXITCODE | Should -Not -Be 0
    }

    It "builds plan in target if also in root" {
        bio pkg build test/fixtures/plan-in-root-and-target
        if($IsLinux) {
            # This changes the format of last_build from `var=value` to `$var='value'`
            # so that powershell can parse and source the script
            Get-Content "results/last_build.env" | ForEach-Object { Add-Content "results/last_build.ps1" -Value "`$$($_.Replace("=", '="'))`"" }
        }
        . ./results/last_build.ps1

        $pkg_name | Should -Be "target_plan"
    }
}

Describe "working after success callback" {
    $result = bio pkg build test/fixtures/after-success-plan
    $exit = $LASTEXITCODE
    It "exits 0" {
        $exit | Should -Be 0
    }

    It "fires after success callback" {
        $result | Should -Contain "I am a success"
    }

    It "does not fire after failure callback" {
        $result | Should -Not -Contain "I am a failure"
    }
}

Describe "failing after success callback" {
    $result = bio pkg build test/fixtures/broken-after-success-plan
    $exit = $LASTEXITCODE
    It "exits 0" {
        $exit | Should -Be 0
    }

    It "outputs success callback error" {
        ($result | Out-String) | Should -BeLike "*success' callback failed*"
    }

    It "does not fire after failure callback" {
        $result | Should -Not -Contain "I am a failure"
    }
}

Describe "working after failure callback" {
    $result = bio pkg build test/fixtures/after-failure-plan
    $exit = $LASTEXITCODE
    It "exits 1" {
        $exit | Should -Be 1
    }

    It "fires after failure callback" {
        $result | Should -Contain "I am a failure"
    }

    It "does not fire after success callback" {
        $result | Should -Not -Contain "I am a success"
    }
}

Describe "failing after failure callback" {
    $result = bio pkg build test/fixtures/broken-after-failure-plan
    $exit = $LASTEXITCODE
    It "exits 1" {
        $exit | Should -Be 1
    }

    It "outputs failure callback error" {
        ($result | Out-String) | Should -BeLike "*failure' callback failed*"
    }

    It "does not fire after success callback" {
        $result | Should -Not -Contain "I am a success"
    }
}
