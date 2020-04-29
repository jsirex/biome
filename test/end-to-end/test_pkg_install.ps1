Describe "pkg install" {
    BeforeAll {
        bio origin key generate $env:HAB_ORIGIN

        Invoke-BuildAndInstall dep-pkg-1
        Invoke-BuildAndInstall dep-pkg-2
        Invoke-BuildAndInstall dep-pkg-3

        bio pkg uninstall $env:HAB_ORIGIN/dep-pkg-3
    }

    It "installs all dependencies and executes all install hooks" {
        $cached = Get-Item "/hab/cache/artifacts/$env:HAB_ORIGIN-dep-pkg-3*"
        bio pkg install $cached.FullName
        $LASTEXITCODE | Should -Be 0
        Get-Content "$(bio pkg path $env:HAB_ORIGIN/dep-pkg-1)/INSTALL_HOOK_STATUS" | Should -Be "0"
        Get-Content "$(bio pkg path $env:HAB_ORIGIN/dep-pkg-2)/INSTALL_HOOK_STATUS" | Should -Be "0"
        Get-Content "$(bio pkg path $env:HAB_ORIGIN/dep-pkg-3)/INSTALL_HOOK_STATUS" | Should -Be "0"
    }
}
