
function Invoke-Main {
    Enable-CouchGamingOnStartup
    Enable-GitConfig
    Enable-VsCodeSettings
    Disable-WindowsSounds
}

# Taken from https://gist.github.com/bitcrazed/c788f9dcf1d630340a19
#--- Used to uninstall unwanted default apps ---

function Remove-App
{
    Param ([string]$appName)
    Write-Output "Trying to remove $appName"
    Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
    Get-AppXProvisionedPackage -Online `
        | Where-Object DisplayName -like $appName `
        | Remove-AppxProvisionedPackage -Online
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
$hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | ForEach-Object { "0x$_"}
$kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout'
New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified)

Disable-NetAdapterBinding -InterfaceAlias "*" -ComponentID "ms_tcpip6"

# Assume default source of https://chocolatey.org/api/v2
choco install alacritty -y
choco install brave -y
choco install gnucash -y
choco install steam -y
choco install zoom -y
choco install op -y
choco install vscode.install -y
choco install obs-studio -y
choco install autohotkey.install -y

choco install jetbrainsmononf -y
choco install nerd-fonts-robotomono -y
choco install nerd-fonts-inconsolata -y

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

function Enable-VsCodeSettings {
    # Not sure how this will go on a fresh install because I'm not sure if the app will exist
    $TargetConfigPath = Join-Path -Path $Env:USERPROFILE -Child "AppData\Roaming\Code\User\settings.json"
    $SourceConfigPath = Join-Path -Path $Env:USERPROFILE -Child "workspace\infrastructure\homedirs\windows\vscode\settings.json"
    New-Item -Path $TargetConfigPath -ItemType SymbolicLink -Value $SourceConfigPath  
}

# Thanks to the following this week, this wasn't too tough!
# https://superuser.com/questions/1300539/change-sound-scheme-in-windows-via-windows-registry
function Disable-WindowsSounds {
    Get-ChildItem -Path "HKCU:\AppEvents\Schemes\Apps\*\*\.current" `
        | Set-ItemProperty -Name "(Default)" -Value ""
}

Invoke-Main