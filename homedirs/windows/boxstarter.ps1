
# Taken from https://gist.github.com/bitcrazed/c788f9dcf1d630340a19
#--- Used to uninstall unwanted default apps ---

function Remove-App
{
    Param ([string]$appName)
    Write-Output "Trying to remove $appName"
    Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
    Get-AppXProvisionedPackage -Online | Where DisplayName -like $appName | Remove-AppxProvisionedPackage -Online
}

#--- Uninstall unwanted default apps ---

# Get a list of existing applications by running:
#
# Get-AppxPackage | % { $_.Name }

$applicationList = @(
    "Microsoft.BingFinance"
    "Microsoft.3DBuilder"
    "Microsoft.CommsPhone"
    "Microsoft.Getstarted"
    "*MarchofEmpires*"
    "Microsoft.GetHelp"
    "Microsoft.Messaging"
    "*Minecraft*"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.WindowsPhone"
    "*Solitaire*"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.Office.Sway"

#    "Microsoft.XboxApp"
#    "Microsoft.XboxIdentityProvider"

    "Microsoft.NetworkSpeedTest"
    "Microsoft.Print3D"

    #Non-Microsoft

    "*Autodesk*"
    "*BubbleWitch*"
    "king.com.CandyCrush*"
    "*Dell*"
    "*Dropbox*"
    "*Facebook*"
    "*Keeper*"
    "*Twitter*"
    "*Plex*"
    "*.Duolingo-LearnLanguagesforFree"
    "*.EclipseManager"
    "ActiproSoftwareLLC.562882FEEB491" # Code Writer
    "*.AdobePhotoshopExpress");


foreach ($app in $applicationList) {
    Remove-App $app
}

Set-WindowsExplorerOptions `
  -EnableShowFileExtensions

Set-BoxstarterTaskbarOptions -Size Small -Dock Top

# Switchings CAPSLOCK to CTRL
$hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | % { "0x$_"}
$kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout'
New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified)

choco install git -y --source="'https://chocolatey.org/api/v2'" `
  --package-parameters='"/GitAndUnixToolsOnPath /WindowsTerminal"'

choco install brave -y --source="'https://chocolatey.org/api/v2'"
choco install gnucash -y --source="'https://chocolatey.org/api/v2'"
choco install steam -y --source="'https://chocolatey.org/api/v2'"
# goggalaxy has an error need to manually install for now
#choco install goggalaxy -y --source="'https://chocolatey.org/api/v2'"
choco install zoom -y --source="'https://chocolatey.org/api/v2'"

# 1password installer still broken
# choco install 1password -y --source="'https://chocolatey.org/api/v2'"

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

Disable-NetAdapterBinding -InterfaceAlias "Ethernet" -ComponentID "ms_tcpip6"

