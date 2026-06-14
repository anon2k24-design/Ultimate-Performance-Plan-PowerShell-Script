# Ultimate Performance Plan PowerShell Script
# Enables and activates the Ultimate Performance power plan
#
# Support this project:
#   PayPal: https://www.paypal.com/donate/?business=UNP6WN3E95EAL&currency_code=USD
#   GitHub: https://github.com/anon2k24-design

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: Run this script as Administrator." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Ultimate Performance Plan Enabler" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$ultimateBaseGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
$existingPlan = powercfg /list | Select-String "Ultimate Performance"

if ($existingPlan) {
    $activeGuidMatch = [regex]::Match($existingPlan.Line, '([A-Fa-f0-9-]{36})')
    if ($activeGuidMatch.Success) {
        $ultimatePlanGuid = $activeGuidMatch.Value
        powercfg /setactive $ultimatePlanGuid
        Write-Host "✓ Existing Ultimate Performance plan activated" -ForegroundColor Green
        Write-Host "GUID: $ultimatePlanGuid" -ForegroundColor Gray
    }
    else {
        Write-Host "ERROR: Ultimate Performance plan was found but GUID could not be parsed." -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}
else {
    $duplicateOutput = powercfg /duplicatescheme $ultimateBaseGuid
    $guidMatch = [regex]::Match(($duplicateOutput | Out-String), '([A-Fa-f0-9-]{36})')

    if ($guidMatch.Success) {
        $ultimatePlanGuid = $guidMatch.Value
        powercfg /setactive $ultimatePlanGuid
        Write-Host "✓ Ultimate Performance plan created and activated" -ForegroundColor Green
        Write-Host "GUID: $ultimatePlanGuid" -ForegroundColor Gray
    }
    else {
        Write-Host "ERROR: Failed to create the Ultimate Performance plan." -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

Write-Host ""
Write-Host "Ultimate Performance plan has been enabled and activated!" -ForegroundColor Green
Write-Host ""

Read-Host "Press Enter to exit"