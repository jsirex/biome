bio pkg install core/windows-service

Describe "Biome Windows Service" {
    It "Starts the service" {
        Start-Service Biome
        Wait-Supervisor -Timeout 45
        (Invoke-WebRequest "http://localhost:9631/butterfly" -UseBasicParsing).StatusCode | Should -Be 200
    }
    It "Stops the service" {
        Stop-Service Biome
        Get-Process bio-sup -ErrorAction SilentlyContinue | Should -Be $null
        Get-Process bio-launch -ErrorAction SilentlyContinue | Should -Be $null
    }
}
