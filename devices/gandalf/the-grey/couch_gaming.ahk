recordedKeys := ""
SetTimer, resetRecordedKeys, 1000
return

^g::
recordedKeys .= "g"
if (recordedKeys="gg") {
    recordedKeys := ""
    Run, multimonitortool.exe /enable 1
    Run, multimonitortool.exe /setprimary 1
    Run, multimonitortool.exe /disable 3
    Run, multimonitortool.exe /enable 2
}
return

^o::
recordedKeys .= "o"
if (recordedKeys="go") {
    resetRecordedKeys := ""
    Run, multimonitortool.exe /enable 3
    Run, multimonitortool.exe /setprimary 3
    Run, multimonitortool.exe /disable 1 2
    Sleep, 2000
    Run, "C:\Program Files (x86)\Steam\steam.exe" -newbigpicture "steam://open/bigpicture"
}
return

resetRecordedKeys:
recordedKeys := ""
return
