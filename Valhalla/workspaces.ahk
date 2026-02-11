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

Workspace_Firefox_GeminiChatGPT() {
    launchPauseMs := 1200
    betweenLaunchPauseMs := 600
    movePauseMs := 350
    logPath := A_ScriptDir "\window-debug.log"

    firefoxPath := A_ProgramFiles "\Mozilla Firefox\firefox.exe"
    if !FileExist(firefoxPath) {
        firefoxPath := A_ProgramFiles " (x86)\Mozilla Firefox\firefox.exe"
    }

    if FileExist(firefoxPath) {
        firefoxExe := '"' firefoxPath '"'
    } else {
        firefoxExe := "firefox.exe"
    }

    existingFirefoxWindows := Map()
    for hwnd in WinGetList("ahk_exe firefox.exe") {
        existingFirefoxWindows[hwnd] := true
    }

    geminiHwnd := LaunchFirefoxWindow(firefoxExe, "https://gemini.google.com/app", existingFirefoxWindows, launchPauseMs)
    Sleep betweenLaunchPauseMs
    chatgptHwnd := LaunchFirefoxWindow(firefoxExe, "https://chatgpt.com/", existingFirefoxWindows, launchPauseMs)

    GetTopRightMonitorWorkArea(&left, &top, &right, &bottom)
    monitorWidth := right - left
    monitorHeight := bottom - top
    if (monitorWidth < 2 || monitorHeight < 2) {
        return
    }

    leftWidth := Floor(monitorWidth / 2)
    rightWidth := monitorWidth - leftWidth
    rightX := left + leftWidth

    timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
    FileAppend timestamp
        . " | FIREFOX | targetMonitorWorkArea=(" left "," top "," right "," bottom ")"
        . " | chatgptTarget=(" left "," top "," leftWidth "," monitorHeight ")"
        . " | geminiTarget=(" rightX "," top "," rightWidth "," monitorHeight ")"
        . "`n", logPath, "UTF-8"

    ; ChatGPT on the left half, Gemini on the right half.
    if chatgptHwnd {
        MoveWindowToRect(chatgptHwnd, left, top, leftWidth, monitorHeight, logPath, "ChatGPT")
        Sleep movePauseMs
    }
    if geminiHwnd {
        MoveWindowToRect(geminiHwnd, rightX, top, rightWidth, monitorHeight, logPath, "Gemini")
    }
}

LaunchFirefoxWindow(firefoxExe, url, knownWindows, launchPauseMs := 700) {
    Run firefoxExe ' -new-window "' url '"'
    Sleep launchPauseMs

    newWindow := 0
    deadline := A_TickCount + 12000
    while (A_TickCount < deadline && !newWindow) {
        for hwnd in WinGetList("ahk_exe firefox.exe") {
            if !knownWindows.Has(hwnd) {
                knownWindows[hwnd] := true
                newWindow := hwnd
                break
            }
        }

        if !newWindow {
            Sleep 100
        }
    }

    if newWindow {
        WinWait("ahk_id " newWindow, , 5)
        Sleep 300
    }

    return newWindow
}

MoveWindowToRect(windowHwnd, x, y, width, height, logPath := "", label := "") {
    if !windowHwnd || !WinExist("ahk_id " windowHwnd) {
        return false
    }

    WinActivate("ahk_id " windowHwnd)
    WinWaitActive("ahk_id " windowHwnd, , 3)
    Sleep 250

    if WinGetMinMax("ahk_id " windowHwnd) != 0 {
        WinRestore("ahk_id " windowHwnd)
        Sleep 250
    }

    WinMove x, y, width, height, "ahk_id " windowHwnd
    Sleep 300
    WinGetPos &afterX, &afterY, &afterW, &afterH, "ahk_id " windowHwnd

    if !RectCloseEnough(afterX, afterY, afterW, afterH, x, y, width, height, 30) {
        WinMove x, y, width, height, "ahk_id " windowHwnd
        Sleep 300
        WinGetPos &afterX, &afterY, &afterW, &afterH, "ahk_id " windowHwnd
    }

    if (logPath != "") {
        timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        status := RectCloseEnough(afterX, afterY, afterW, afterH, x, y, width, height, 30) ? "ok" : "off-target"
        FileAppend timestamp
            . " | FIREFOX | " label
            . " | hwnd=" windowHwnd
            . " | target=(" x "," y "," width "," height ")"
            . " | after=(" afterX "," afterY "," afterW "," afterH ")"
            . " | state=" WinGetMinMax("ahk_id " windowHwnd)
            . " | status=" status
            . "`n", logPath, "UTF-8"
    }

    return RectCloseEnough(afterX, afterY, afterW, afterH, x, y, width, height, 30)
}

RectCloseEnough(actualX, actualY, actualW, actualH, targetX, targetY, targetW, targetH, tolerance := 20) {
    return (
        Abs(actualX - targetX) <= tolerance
        && Abs(actualY - targetY) <= tolerance
        && Abs(actualW - targetW) <= tolerance
        && Abs(actualH - targetH) <= tolerance
    )
}

GetTopRightMonitorWorkArea(&left, &top, &right, &bottom) {
    monitorCount := MonitorGetCount()
    if monitorCount < 1 {
        left := 0
        top := 0
        right := A_ScreenWidth
        bottom := A_ScreenHeight
        return false
    }

    monitors := []
    minTop := 2147483647

    loop monitorCount {
        monitorIndex := A_Index
        MonitorGetWorkArea(monitorIndex, &mLeft, &mTop, &mRight, &mBottom)
        monitors.Push({
            idx: monitorIndex,
            left: mLeft,
            top: mTop,
            right: mRight,
            bottom: mBottom
        })

        if (mTop < minTop) {
            minTop := mTop
        }
    }

    target := false
    topRowTolerance := 350
    for monitor in monitors {
        if (monitor.top <= minTop + topRowTolerance) {
            if (!target || monitor.right > target.right) {
                target := monitor
            }
        }
    }

    if !target {
        for monitor in monitors {
            if (!target || monitor.top < target.top || (monitor.top = target.top && monitor.right > target.right)) {
                target := monitor
            }
        }
    }

    left := target.left
    top := target.top
    right := target.right
    bottom := target.bottom
    return true
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
