recordedKeys := ""
SetTimer, resetRecordedKeys, 1000
return

; These are stable Monitor IDs that I can use to refer to each of my screens
; ACER MONITOR\ACI27A3\{4d36e96e-e325-11ce-bfc1-08002be10318}\0008
; TV   MONITOR\SAM0DF6\{4d36e96e-e325-11ce-bfc1-08002be10318}\0007
; DELL MONITOR\DEL421E\{4d36e96e-e325-11ce-bfc1-08002be10318}\0005

^g::
recordedKeys .= "g"
if (recordedKeys="gg") {
    recordedKeys := ""

    ; I must load a MultiMonitorTool config file that has all screens in the layout I want
    ; The reload is required because between some configurations a monitor might be left
    ; out of the live config. This /LoadConfig ensures I have a consist monitor list all the time
    Run, multimonitortool.exe /LoadConfig "C:\Users\micro\multimonitor.cfg"

    ; I don't know if any of these Sleep statements are really required...
    Sleep, 1000
    ; Enable my primarmy monitor and set to be my primar
    Run, multimonitortool.exe /enable "MONITOR\DEL421E\{4d36e96e-e325-11ce-bfc1-08002be10318}\0005"
    Sleep, 1000
    Run, multimonitortool.exe /SetPrimary "MONITOR\DEL421E\{4d36e96e-e325-11ce-bfc1-08002be10318}\0005"
    Sleep, 1000

    ; Disable the TV... for reason I don't need to re-enable the Asus secondary monitor...
    Run, multimonitortool.exe /disable "MONITOR\SAM0DF6\{4d36e96e-e325-11ce-bfc1-08002be10318}\0007"
}
return

^o::
recordedKeys .= "o"
if (recordedKeys="go") {
    resetRecordedKeys := ""

    ; Same rationale for this as in the "gg" shortcut
    Run, multimonitortool.exe /LoadConfig "C:\Users\micro\multimonitor.cfg"
    Sleep, 1000

    ; First step is enable the TV (not sure how this behaves if the TV is off or not set to PC input)
    Run, multimonitortool.exe /enable "MONITOR\SAM0DF6\{4d36e96e-e325-11ce-bfc1-08002be10318}\0007"
    Sleep, 1000

    ; Setting the TV to the primary to remove any launch location ambiguitity (maybe not necessary?)
    Run, multimonitortool.exe /SetPrimary "MONITOR\SAM0DF6\{4d36e96e-e325-11ce-bfc1-08002be10318}\0007"

    ; Disable the primary and secondary PC monitors. I'm doing this to conserve power and save the GPU
    ; some cycles... that being said, having set the primary monitor to the TV is probably sufficient
    ; to get consistent functionality.
    Run, multimonitortool.exe /disable "MONITOR\ACI27A3\{4d36e96e-e325-11ce-bfc1-08002be10318}\0008" "MONITOR\DEL421E\{4d36e96e-e325-11ce-bfc1-08002be10318}\0005"
    Sleep, 1000
    Run, "C:\Users\micro\AppData\Local\Playnite\Playnite.FullscreenApp.exe"
}
return

resetRecordedKeys:
recordedKeys := ""
return
