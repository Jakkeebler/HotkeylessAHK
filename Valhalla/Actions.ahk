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

; Focus the VS Code window that has repoPath open, or open a new one if none has it.
; Match is by folder name in the window title (VS Code titles: "file - folder - Visual Studio Code").
FocusOrOpenRepoInVSCode(repoPath) {
    if !DirExist(repoPath) {
        ShowPanicTooltip("Repo not found: " repoPath)
        return
    }

    SplitPath(repoPath, &folderName)

    for hwnd in WinGetList("ahk_exe Code.exe") {
        if InStr(WinGetTitle("ahk_id " hwnd), folderName) {
            if (WinGetMinMax("ahk_id " hwnd) = -1)
                WinRestore("ahk_id " hwnd)
            WinActivate("ahk_id " hwnd)
            return
        }
    }

    OpenFolderInVSCode(repoPath)
}

OpenRepo_BookwyrmScribe() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Apps\Books\Bookwyrm Scribe - NodeJS")
}

OpenRepo_BookwyrmCollector() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Apps\Books\Bookwyrm Collector")
}

OpenRepo_BookwyrmHoard() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Apps\Books\Bookwyrm Hoard - NextJS")
}

OpenRepo_BookwyrmWheel() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Apps\Books\Bookwyrm Wheel")
}

OpenRepo_PlexMoviePicker() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Apps\Plex Movie Picker - AI")
}

OpenRepo_BusinessDashboard() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Apps\Business Dashbord")
}

OpenRepo_LivingDexTracker() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Pokemon\LivingDex-Labs\V0-LivingDex-AI")
}

OpenRepo_PokeHub() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Pokemon\PokeHub")
}

OpenRepo_ShowdownBot() {
    FocusOrOpenRepoInVSCode("C:\Users\Jeron\Documents\Programming\Pokemon\Showdown Bot")
}

VivaldiPrivateHwnds() {
    static hwnds := Map()
    return hwnds
}

ShowPanicTooltip(text) {
    ToolTip text
    SetTimer(() => ToolTip(), -1200)
}
