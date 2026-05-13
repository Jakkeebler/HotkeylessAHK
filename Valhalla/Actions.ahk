; Valhalla - Actions ------------------------------------------------------------
Action_CodexApprove() {
    SendEvent "{F3 down}"
    Sleep 50
    SendEvent "1"
    Sleep 50
    SendEvent "{F3 up}"
    Sleep 300
    Click "Left"
    Sleep 1000
}

PanicMute() {
    try SoundSetMute(true)

    for hwnd in WinGetList("ahk_exe chrome.exe") {
        title := WinGetTitle("ahk_id " hwnd)
        if InStr(title, "Incognito") {
            try WinHide("ahk_id " hwnd)
        }
    }

    markedHwnds := VivaldiPrivateHwnds()
    deadHwnds := []
    for hwnd, _ in markedHwnds {
        if WinExist("ahk_id " hwnd) {
            try WinHide("ahk_id " hwnd)
        } else {
            deadHwnds.Push(hwnd)
        }
    }
    for hwnd in deadHwnds {
        markedHwnds.Delete(hwnd)
    }
}

PanicUnmute() {
    try SoundSetMute(false)

    prevHidden := A_DetectHiddenWindows
    DetectHiddenWindows true

    for hwnd in WinGetList("ahk_exe chrome.exe") {
        title := WinGetTitle("ahk_id " hwnd)
        if InStr(title, "Incognito") {
            try WinShow("ahk_id " hwnd)
        }
    }

    markedHwnds := VivaldiPrivateHwnds()
    deadHwnds := []
    for hwnd, _ in markedHwnds {
        if WinExist("ahk_id " hwnd) {
            try WinShow("ahk_id " hwnd)
        } else {
            deadHwnds.Push(hwnd)
        }
    }
    for hwnd in deadHwnds {
        markedHwnds.Delete(hwnd)
    }

    DetectHiddenWindows prevHidden
}

; Stream Deck: press while a Vivaldi private window is focused to tag it for PanicMute.
MarkVivaldiPrivate() {
    try {
        hwnd := WinGetID("A")
        exe := WinGetProcessName("ahk_id " hwnd)
        if (exe != "vivaldi.exe") {
            ShowPanicTooltip("Not a Vivaldi window")
            return
        }
        VivaldiPrivateHwnds()[hwnd] := true
        ShowPanicTooltip("Vivaldi private window marked")
    } catch as e {
        ShowPanicTooltip("Mark failed: " e.message)
    }
}

UnmarkVivaldiPrivate() {
    try {
        hwnd := WinGetID("A")
        markedHwnds := VivaldiPrivateHwnds()
        if markedHwnds.Has(hwnd) {
            markedHwnds.Delete(hwnd)
            ShowPanicTooltip("Vivaldi private window unmarked")
        } else {
            ShowPanicTooltip("Active window was not marked")
        }
    }
}

VivaldiPrivateHwnds() {
    static hwnds := Map()
    return hwnds
}

ShowPanicTooltip(text) {
    ToolTip text
    SetTimer(() => ToolTip(), -1200)
}
