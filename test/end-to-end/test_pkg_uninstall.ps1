$pkg = "core/redis"
$pkgs = @(
    "$pkg/3.2.3/20161102201135",
    "$pkg/3.2.4/20161104175435",
    "$pkg/3.2.4/20161210004233",
    "$pkg/3.2.4/20161215055911",
    "$pkg/3.2.4/20170103160441",
    "$pkg/3.2.4/20170106011058",
    "$pkg/4.0.10/20180801003001",
    "$pkg/4.0.10/20190116005049",
    "$pkg/4.0.14/20200319184753",
    "$pkg/4.0.14/20200319200053"
)
$env:HAB_NOCOLORING="true"

Describe "pkg uninstall" {
    It "installs core/redis" {
        foreach ($p in $pkgs) {
            bio pkg install "$p"
        }
        bio pkg list "$pkg" | Should -BeExactly $pkgs
    }

    It "uninstall a single package" {
        bio pkg uninstall "$pkg"
        bio pkg list "$pkg" | Should -BeExactly $pkgs[0..8]
    }

    It "uninstall all but the two latest of version 3.2.4" {
        bio pkg uninstall --keep-latest=2 "$pkg/3.2.4"
        bio pkg list "$pkg" | Should -BeExactly $pkgs[,0+4..8]
    }

    It "dry run should do nothing" {
        bio pkg uninstall -d "$pkg"
        bio pkg uninstall -d --keep-latest=1 "$pkg"
        bio pkg list "$pkg" | Should -BeExactly $pkgs[,0+4..8]
    }

    It "uninstall with a fully qualified ident" {
        bio pkg uninstall --keep-latest=3 "$pkg/3.2.3/20161102201135" | Should -Contain "… Skipping Only 1 packages installed"
        bio pkg uninstall --keep-latest=0 "$pkg/3.2.3/20161102201135"
        bio pkg list "$pkg" | Should -BeExactly $pkgs[4..8]
    }

    It "uninstall all but the three latest" {
        bio pkg uninstall --keep-latest=3 "$pkg"
        bio pkg list "$pkg" | Should -BeExactly $pkgs[6..8]
    }

    It "uninstall does nothing if keeping all" {
        bio pkg uninstall --keep-latest=10 "$pkg" | Should -Contain "… Skipping Only 3 packages installed"
        bio pkg list "$pkg" | Should -BeExactly $pkgs[6..8]
    }

    It "uninstall all" {
        bio pkg uninstall --keep-latest=0 "$pkg"
        bio pkg list "$pkg" | Should -BeExactly @()
    }

    AfterAll {
        bio pkg uninstall --keep-latest=0 "$pkg"
    }
}
