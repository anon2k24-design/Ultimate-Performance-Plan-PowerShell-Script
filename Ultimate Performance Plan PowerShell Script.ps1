# Ultimate Performance Plan PowerShell Script
# This script enables the "Ultimate Performance" power plan

# Duplicate the Ultimate Performance scheme
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

# Set the active power plan to Ultimate Performance
$ultimatePlanGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -setactive $ultimatePlanGuid

echo "Ultimate Performance plan has been enabled and activated!"