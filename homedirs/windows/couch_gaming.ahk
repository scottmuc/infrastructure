recordedKeys := ""
SetTimer, resetRecordedKeys, 1000
return

^g::
recordedKeys .= "g"
if (recordedKeys="gg") {
    recordedKeys := ""
    Run, displayswitch.exe /internal
}
return

^o::
recordedKeys .= "o"
if (recordedKeys="go") {
    resetRecordedKeys := ""
    Run, displayswitch.exe /clone
    Sleep, 2000
    Run, "C:\Program Files (x86)\Steam\steam.exe" -newbigpicture "steam://open/bigpicture"
}
return

resetRecordedKeys:
recordedKeys := ""
return
