
function Invoke-Main {
    Enable-CouchGamingOnStartup
    Enable-GitConfig
    Enable-AlacrittyConfig
    Disable-WindowsSounds
}

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

    "Microsoft.XboxApp"
    "Microsoft.XboxIdentityProvider"

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

# https://boxstarter.org/winconfig#set-windowsexploreroptions
Set-WindowsExplorerOptions `
  -EnableShowHiddenFilesFoldersDrives `
  -EnableShowFileExtensions `
  -EnableShowFullPathInTitleBar


#  https://boxstarter.org/winconfig#set-boxstartertaskbaroptions
Set-BoxstarterTaskbarOptions `
  -Size Small `
  -Dock Top `
  -DisableSearchBox

# Switchings CAPSLOCK to CTRL
$hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | % { "0x$_"}
$kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout'
New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified)

Disable-NetAdapterBinding -InterfaceAlias "*" -ComponentID "ms_tcpip6"

choco install alacritty -y --source="'https://chocolatey.org/api/v2'"
choco install brave -y --source="'https://chocolatey.org/api/v2'"
choco install gnucash -y --source="'https://chocolatey.org/api/v2'"
choco install steam -y --source="'https://chocolatey.org/api/v2'"
choco install zoom -y --source="'https://chocolatey.org/api/v2'"
choco install op -y --source="'https://chocolatey.org/api/v2'"
choco install vscode.install -y --source="'https://chocolatey.org/api/v2'"

choco install autohotkey.install -y --source="'https://chocolatey.org/api/v2'"

function Enable-CouchGamingOnStartup {
    # Create shortcuts to the ahk files so they are setup on startup
    # https://stackoverflow.com/questions/9701840/how-to-create-a-shortcut-using-powershell
    $WshShell = New-Object -comObject WScript.Shell
    # Need to figure out how to read shell:startup
    # https://www.devdungeon.com/content/windows-run-script-startup
    $StartupFolder = Join-Path -Path $env:AppData -ChildPath "Microsoft\Windows\Start Menu\Programs\Startup"
    $CouchGamingShortcut = Join-Path -Path $StartupFolder -ChildPath "couch_gaming.ahk.lnk"
    $Shortcut = $WshShell.CreateShortcut($CouchGamingShortcut)
    # https://www.autoitconsulting.com/site/scripting/get-current-script-directory-powershell-vbscript-batch/
    $ScriptDir = Join-Path -Path $Env:USERPROFILE -Child "workspace\infrastructure\homedirs\windows"
    $CouchGamingAhk = Join-Path -Path $ScriptDir -ChildPath .\couch_gaming.ahk
    $Shortcut.TargetPath = $CouchGamingAhk
    $Shortcut.Save()
}

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

function Enable-GitConfig {
    $TargetGitConfigPath = Join-Path -Path $Env:USERPROFILE -Child ".gitconfig"
    $ScriptDir = Join-Path -Path $Env:USERPROFILE -Child "workspace\infrastructure\homedirs\windows"
    $SourceGitConfigPath = Join-Path $ScriptDir -Child "dot.gitconfig"
    New-Item -Path $TargetGitConfigPath -ItemType SymbolicLink -Value $SourceGitConfigPath
}

function Enable-AlacrittyConfig {
    $ConfigPath =  Join-Path -Path $Env:APPDATA -Child "alacritty"
    New-Item -ItemType Directory -Path $ConfigPath -Force

    $TargetPath = Join-Path -Path $ConfigPath -Child "alacritty.yml"
    $ScriptDir = Join-Path -Path $Env:USERPROFILE -Child "workspace\infrastructure\homedirs\windows"
    $SourcePath = Join-Path $ScriptDir -Child "alacritty.yml"
    New-Item -Path $TargetPath -ItemType SymbolicLink -Value $SourcePath -Force
}

# Thanks to the following this week, this wasn't too tough!
# https://superuser.com/questions/1300539/change-sound-scheme-in-windows-via-windows-registry
function Disable-WindowsSounds {
    Get-ChildItem -Path "HKCU:\AppEvents\Schemes\Apps\*\*\.current" `
        | Set-ItemProperty -Name "(Default)" -Value ""
}

Invoke-Main