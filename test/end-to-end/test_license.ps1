Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$HOME/.hab/accepted-licenses"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "/hab/accepted-licenses"
$env:HAB_LICENSE = $null

Describe "license" {
    It "version check without license works" {
        bio --version
        $LastExitCode | Should -Be 0

        bio -V
        $LastExitCode | Should -Be 0

        bio svc load --version
        $LastExitCode | Should -Be 0

        bio sup -V
        $LastExitCode | Should -Be 0
    }

    It "help without license works" {
        bio --help
        $LastExitCode | Should -Be 0

        bio -h
        $LastExitCode | Should -Be 0

        bio svc load --help
        $LastExitCode | Should -Be 0

        bio sup -h
        $LastExitCode | Should -Be 0
    }

    It "non-version and non-help commands timeout on license check" {
        $process = Start-Process "bio" -ArgumentList "svc status" -PassThru
        {
            Wait-ProcessExit $process -Timeout 1 -ErrorAction Stop
        } | Should -Throw "Timed out"

        $process | Stop-Process -Force
    }

    It "non-version and non-help commands do no work when denying license" {
        $Env:HAB_LICENSE = "deny"

        bio svc load
        $LastExitCode | Should -Be 1

        bio sup run
        $LastExitCode | Should -Be 1

        bio pkg list --all
        $LastExitCode | Should -Be 1
    }

    It "HAB_LICENSE=accept-no-persist works" {
        $Env:HAB_LICENSE = "accept-no-persist"

        bio pkg list --all
        $LastExitCode | Should -Be 0
    }

    It "all commands work with license" {
        bio license accept

        bio --version
        $LastExitCode | Should -Be 0

        bio svc load --help
        $LastExitCode | Should -Be 0

        bio pkg list --all
        $LastExitCode | Should -Be 0
    }

    It "HAB_LICENSE=deny causes commands to fail even if license was previously accpeted" {
        $Env:HAB_LICENSE = "deny"
        bio license accept

        bio pkg list --all
        $LastExitCode | Should -Be 1
    }
}