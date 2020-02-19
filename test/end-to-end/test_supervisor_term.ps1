$env:HAB_INTERNAL_BLDR_CHANNEL = "dev"
$env:HAB_BLDR_CHANNEL = "dev"
$tempFile = Join-Path ([System.IO.Path]::GetTempPath()) "testpkgstophook.out"
$launcherProc = Start-Supervisor -Timeout 45

Describe "bio sup term" {
    BeforeAll {
        bio origin key generate $env:HAB_ORIGIN
        Invoke-BuildAndInstall testpkgstophook
        Load-SupervisorService "$env:HAB_ORIGIN/testpkgstophook"
        bio sup term
        $supProc = Get-Process "bio-sup"
        $supProc.WaitForExit(5000)
        $launcherProc.WaitForExit(10000)
    }

    It "should terminate launcher" {
        $launcherProc.HasExited | Should -Be $true
    }
    It "should gracefully terminate service run hook" {
        $tempFile | Should -FileContentMatch "run hook is terminating"
    }
    It "should fire stop hook" {
        $tempFile | Should -FileContentMatch "post-stop hook has fired"
    }
}
