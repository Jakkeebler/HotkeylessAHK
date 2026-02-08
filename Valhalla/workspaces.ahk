HelloWorld2() {
    MsgBox "Hello from Valhalla!"
}

; Valhalla - Workspaces ---------------------------------------------------------
DigitalMuse_Etsy() {
    chromePath := A_ProgramFiles "\Google\Chrome\Application\chrome.exe"
    if !FileExist(chromePath) {
        chromePath := A_ProgramFiles " (x86)\Google\Chrome\Application\chrome.exe"
    }

    if FileExist(chromePath) {
        launchCmd := '"' chromePath '" --profile-directory="Profile 6" --new-window "https://app.everbee.io/" "https://www.etsy.com"'
    } else {
        launchCmd := 'chrome.exe --profile-directory="Profile 6" --new-window "https://app.everbee.io/" "https://www.etsy.com"'
    }

    existingChromeWindows := Map()
    for hwnd in WinGetList("ahk_exe chrome.exe") {
        existingChromeWindows[hwnd] := true
    }

    Run launchCmd

    Sleep 1200
    logPath := A_ScriptDir "\window-debug.log"

    newChromeHwnd := 0
    deadline := A_TickCount + 10000
    while (A_TickCount < deadline && !newChromeHwnd) {
        for hwnd in WinGetList("ahk_exe chrome.exe") {
            if !existingChromeWindows.Has(hwnd) {
                newChromeHwnd := hwnd
                break
            }
        }
        if !newChromeHwnd {
            Sleep 100
        }
    }

    if !newChromeHwnd && WinWaitActive("ahk_exe chrome.exe", , 5) {
        newChromeHwnd := WinExist("A")
    }

    if newChromeHwnd {
        WinActivate("ahk_id " newChromeHwnd)
        WinWaitActive("ahk_id " newChromeHwnd, , 3)

        if WinGetMinMax("ahk_id " newChromeHwnd) != 0 {
            WinRestore("ahk_id " newChromeHwnd)
            Sleep 150
        }

        left := 0
        top := 0
        right := A_ScreenWidth
        bottom := A_ScreenHeight

        width := right - left
        height := bottom - top
        targetWidth := Ceil(width / 4)
        targetX := right - targetWidth

        WinGetPos &beforeX, &beforeY, &beforeW, &beforeH, "ahk_id " newChromeHwnd
        WinMove targetX, top, targetWidth, height, "ahk_id " newChromeHwnd
        Sleep 200
        WinGetPos &afterX, &afterY, &afterW, &afterH, "ahk_id " newChromeHwnd

        timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        logLine := timestamp
            . " | hwnd=" newChromeHwnd
            . " | mainScreenArea=(" left "," top "," right "," bottom ")"
            . " | target=(" targetX "," top "," targetWidth "," height ")"
            . " | before=(" beforeX "," beforeY "," beforeW "," beforeH ")"
            . " | after=(" afterX "," afterY "," afterW "," afterH ")"
            . " | state=" WinGetMinMax("ahk_id " newChromeHwnd)
        FileAppend logLine "`n", logPath, "UTF-8"
    }
}

; Valhalla - Work ---------------------------------------------------------------
EndWork() {
    CloseAppByProcess("ms-teams.exe")
    CloseAppByProcess("Teams.exe")
    CloseAppByProcess("mstsc.exe")
    CloseAppByProcess("FortiClientVPN.exe")
    ShutdownTrayApp("FortiTray.exe", "Shutdown")
    CloseAppByProcess("FortiClient.exe")
}
