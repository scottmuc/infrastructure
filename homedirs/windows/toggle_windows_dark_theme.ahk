; https://stackoverflow.com/questions/32397032/run-a-powershell-command-through-autohotkey-script
; https://helpdeskgeek.com/windows-10/how-to-automatically-toggle-dark-light-modes-on-windows-10/
psScript =
(
    param($flagLightMode)
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value $flagLightMode -Type Dword -Force
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value $flagLightMode -Type Dword -Force
)

; Windows + Shift + d
#+d::
RunWait PowerShell.exe -Command &{%psScript%} '0',, hide
RunWait wsl.exe --cd ~ --exec bash ./workspace/infrastructure/homedirs/common/bin/background dark,, hide
return

; Windows + Shift + l
#+l::
RunWait PowerShell.exe -Command &{%psScript%} '1',, hide
RunWait wsl.exe --cd ~ --exec bash ./workspace/infrastructure/homedirs/common/bin/background light,, hide
return