# `build` is a built-in helper function that maps to `bio pkg exec biome/bio-plan-build`
# rather than `bio pkg build` to avoid 'studio-in-studio' situations. Verify that the
# command functions. We assume that if the build succeeds (exits 0) we've passed this
# test, and leave more detailed testing to the build output to e2e tests for bio-plan-build
bio origin key generate $env:HAB_ORIGIN

Describe "Studio build" {
    foreach($plan in @(
            "plan-in-root",
            "plan-in-habitat",
            "plan-in-target",
            "plan-in-biome-target"
        )) {
        It "builds $plan" {
            bio pkg build test/fixtures/$plan
            $LASTEXITCODE | Should -Be 0
        }
    }

    It "does not build plan-in-root-and-habitat" {
        bio pkg build test/fixtures/plan-in-root-and-habitat
        $LASTEXITCODE | Should -Not -Be 0
    }

    It "does not build plan-in-none" {
        bio pkg build test/fixtures/plan-in-none
        $LASTEXITCODE | Should -Not -Be 0
    }

    It "builds plan in target if also in root" {
        Invoke-Build plan-in-root-and-target
        . ./results/last_build.ps1

        $pkg_name | Should -Be "target_plan"
    }

    It "saves hart in linked artifact cache" {
        Invoke-Build minimal-package
        . ./results/last_build.ps1

        "/hab/cache/artifacts/$pkg_artifact" | Should -Exist
    }

    if($IsWindows) {
        It "builds plan in non system drive" {
            subst x: $env:USERPROFILE
            $cd = Get-Location
            $dir = Split-Path -Leaf $cd.Path
            Push-Location x:\
            New-Item -Name $dir -ItemType Junction -target $cd.Path
            Set-Location $dir
            bio pkg build test/fixtures/minimal-package
            $exitCode = $LASTEXITCODE
            Pop-Location

            $exitCode | Should -Be 0
        }
    }

    It "strips hook extension" {
        Invoke-BuildAndInstall hook-extension-plan
        . ./results/last_build.ps1

        "/hab/pkgs/$pkg_ident/hooks/install" | Should -Exist
    }

    It "fails when there are multiple extensions" {
        bio pkg build test/fixtures/bad-hook-extension-plan
        $LASTEXITCODE | Should -Not -Be 0
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

Describe "Consuming runtime variables of build dependency" {
    It "correctly sets up the environment" {
        bio pkg build test/fixtures/runtime-env-plan
        $env:SOME_VAR = $null
        bio pkg build test/fixtures/runtime-env-consumer-plan -R
        $LASTEXITCODE | Should -Be 0
    }
}