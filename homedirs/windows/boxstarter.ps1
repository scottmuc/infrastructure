
function Invoke-Main {
    Remove-DefaultApplications

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

    Set-CapslockAsControlKey
    Disable-NetAdapterBinding -InterfaceAlias "*" -ComponentID "ms_tcpip6"

    Install-ChocolateyPackages

    Enable-CouchGamingOnStartup
    Enable-DarkThemeToggler
    Enable-GitConfig
    Enable-VsCodeSettings
    
    Disable-WindowsSounds
    Set-ThisDirectoryToQuickAccess

    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    Enable-WindowsOptionalFeature -Online -FeatureName Virtual-Machine-Platform
}


# Origin https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-default-apps.ps1
function Remove-DefaultApplications {
    $apps = @(
        # default Windows 10 apps
        "Microsoft.549981C3F5F10" #Cortana
        "Microsoft.3DBuilder"
        "Microsoft.Appconnector"
        "Microsoft.BingFinance"
        "Microsoft.BingNews"
        "Microsoft.BingSports"
        "Microsoft.BingTranslator"
        "Microsoft.BingWeather"
        #"Microsoft.FreshPaint"
        "Microsoft.GamingServices"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftPowerBIForWindows"
        "Microsoft.MicrosoftSolitaireCollection"
        #"Microsoft.MicrosoftStickyNotes"
        "Microsoft.MinecraftUWP"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.Office.OneNote"
        "Microsoft.People"
        "Microsoft.Print3D"
        "Microsoft.SkypeApp"
        "Microsoft.Wallet"
        #"Microsoft.Windows.Photos"
        "Microsoft.WindowsAlarms"
        #"Microsoft.WindowsCalculator"
        "Microsoft.WindowsCamera"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsPhone"
        "Microsoft.WindowsSoundRecorder"
        #"Microsoft.WindowsStore"   # can't be re-installed
        "Microsoft.Xbox.TCUI"
        "Microsoft.XboxApp"
        "Microsoft.XboxGameOverlay"
        "Microsoft.XboxSpeechToTextOverlay"
        "Microsoft.YourPhone"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
    
        # Threshold 2 apps
        "Microsoft.CommsPhone"
        "Microsoft.ConnectivityStore"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Messaging"
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.WindowsFeedbackHub"
    
        # Creators Update apps
        "Microsoft.Microsoft3DViewer"
        #"Microsoft.MSPaint"
    
        #Redstone apps
        "Microsoft.BingFoodAndDrink"
        "Microsoft.BingHealthAndFitness"
        "Microsoft.BingTravel"
        "Microsoft.WindowsReadingList"
    
        # Redstone 5 apps
        "Microsoft.MixedReality.Portal"
        "Microsoft.ScreenSketch"
        "Microsoft.XboxGamingOverlay"
    
        # non-Microsoft
        "2FE3CB00.PicsArt-PhotoStudio"
        "46928bounde.EclipseManager"
        "4DF9E0F8.Netflix"
        "613EBCEA.PolarrPhotoEditorAcademicEdition"
        "6Wunderkinder.Wunderlist"
        "7EE7776C.LinkedInforWindows"
        "89006A2E.AutodeskSketchBook"
        "9E2F88E3.Twitter"
        "A278AB0D.DisneyMagicKingdoms"
        "A278AB0D.MarchofEmpires"
        "ActiproSoftwareLLC.562882FEEB491" # next one is for the Code Writer from Actipro Software LLC
        "CAF9E577.Plex"  
        "ClearChannelRadioDigital.iHeartRadio"
        "D52A8D61.FarmVille2CountryEscape"
        "D5EA27B7.Duolingo-LearnLanguagesforFree"
        "DB6EA5DB.CyberLinkMediaSuiteEssentials"
        "DolbyLaboratories.DolbyAccess"
        "DolbyLaboratories.DolbyAccess"
        "Drawboard.DrawboardPDF"
        "Facebook.Facebook"
        "Fitbit.FitbitCoach"
        "Flipboard.Flipboard"
        "GAMELOFTSA.Asphalt8Airborne"
        "KeeperSecurityInc.Keeper"
        "NORDCURRENT.COOKINGFEVER"
        "PandoraMediaInc.29680B314EFC2"
        "Playtika.CaesarsSlotsFreeCasino"
        "ShazamEntertainmentLtd.Shazam"
        "SlingTVLLC.SlingTV"
        "SpotifyAB.SpotifyMusic"
        #"TheNewYorkTimes.NYTCrossword"
        "ThumbmunkeysLtd.PhototasticCollage"
        "TuneIn.TuneInRadio"
        "WinZipComputing.WinZipUniversal"
        "XINGAG.XING"
        "flaregamesGmbH.RoyalRevolt2"
        "king.com.*"
        "king.com.BubbleWitch3Saga"
        "king.com.CandyCrushSaga"
        "king.com.CandyCrushSodaSaga"
        "A025C540.Yandex.Music"
    
        # apps which cannot be removed using Remove-AppxPackage
        #"Microsoft.BioEnrollment"
        #"Microsoft.MicrosoftEdge"
        #"Microsoft.Windows.Cortana"
        #"Microsoft.WindowsFeedback"
        #"Microsoft.XboxGameCallableUI"
        #"Microsoft.XboxIdentityProvider"
        #"Windows.ContactSupport"
    
        # apps which other apps depend on
        "Microsoft.Advertising.Xaml"
    )
    
    $appxprovisionedpackage = Get-AppxProvisionedPackage -Online
    
    foreach ($app in $apps) {
        Write-Output "Trying to remove $app"
    
        Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers
    
        ($appxprovisionedpackage).Where( {$_.DisplayName -EQ $app}) |
            Remove-AppxProvisionedPackage -Online
    }
}


function Set-CapslockAsControlKey {
    $hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | ForEach-Object { "0x$_"}
    $kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout'
    New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified)
}

function Install-ChocolateyPackages {
    # Assume default source of https://chocolatey.org/api/v2
    choco install alacritty -y
    choco install gnucash -y
    choco install steam -y
    choco install zoom -y
    choco install op -y
    choco install vscode.install -y
    choco install obs-studio -y
    choco install autohotkey.install -y
    choco install vivaldi.install -y
    choco install obsidian -y

    choco install jetbrainsmononf -y
    choco install nerd-fonts-robotomono -y
    choco install nerd-fonts-inconsolata -y

    # Collectors list: https://github.com/prometheus-community/windows_exporter#collectors
    choco install prometheus-windows-exporter.install --confirm `
        --package-parameters='"/EnabledCollectors:cpu,cs,logical_disk,memory,net,os,service,system,process,thermalzone"'
}

function Set-ThisDirectoryToQuickAccess {
    $Shell = New-Object -ComObject shell.application -Verbose
    $ScriptDir = Join-Path -Path $Env:USERPROFILE -Child "workspace\infrastructure\homedirs\windows"
    $Shell.Namespace($ScriptDir).Self.InvokeVerb("pintohome")
}

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

function Enable-DarkThemeToggler {
    # Copy+Paste of Enable-CouchGamingOnStartup
    $WshShell = New-Object -comObject WScript.Shell
    $StartupFolder = Join-Path -Path $env:AppData -ChildPath "Microsoft\Windows\Start Menu\Programs\Startup"
    $ShortcutPath = Join-Path -Path $StartupFolder -ChildPath "toggle_windows_dark_theme.ahk.lnk"
    $Shortcut = $WshShell.CreateShortcut($ShortcutPath)
    $ScriptDir = Join-Path -Path $Env:USERPROFILE -Child "workspace\infrastructure\homedirs\windows"
    $ShortcutSource = Join-Path -Path $ScriptDir -ChildPath .\toggle_windows_dark_theme.ahk
    $Shortcut.TargetPath = $ShortcutSource
    $Shortcut.Save()
}


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
