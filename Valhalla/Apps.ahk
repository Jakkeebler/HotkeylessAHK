; Valhalla - App Launchers ------------------------------------------------------
; Each launcher opens VS Code on the repo, launches dev commands in Windows Terminal
; (split panes), waits for the dev server to respond, then opens the default browser.

BookwyrmScribe_Start() {
    repoPath := "C:\Users\Jeron\Documents\Programming\Apps\Books\Bookwyrm Scribe - NodeJS"
    devUrl := "http://localhost:5173"
    ; Vite proxies /api and /ws to the Express server on 3000. The page is broken
    ; until that server responds, so we gate the browser open on the slower one.
    apiUrl := "http://localhost:3000"

    if !DirExist(repoPath) {
        MsgBox "Bookwyrm Scribe repo not found at:`n" repoPath, "Bookwyrm Scribe", "Icon!"
        return
    }

    OpenFolderInVSCode(repoPath)

    existingWt := Map()
    for hwnd in WinGetList("ahk_exe WindowsTerminal.exe") {
        existingWt[hwnd] := true
    }

    Run 'wt -d "' repoPath '" --title "Scribe Server" cmd /k npm run dev:server'

    newWt := 0
    deadline := A_TickCount + 8000
    while (A_TickCount < deadline && !newWt) {
        for hwnd in WinGetList("ahk_exe WindowsTerminal.exe") {
            if !existingWt.Has(hwnd) {
                newWt := hwnd
                break
            }
        }
        if !newWt {
            Sleep 100
        }
    }

    if newWt {
        Run 'wt -w 0 split-pane -H -d "' repoPath '" --title "Scribe Client" cmd /k npm run dev:client'
    } else {
        MsgBox "Windows Terminal didn't open in time. Client pane skipped.`nStart it manually with: npm run dev:client", "Bookwyrm Scribe", "Icon!"
    }

    if WaitForUrl(apiUrl, 60000) {
        Run devUrl
    } else {
        MsgBox "Scribe server didn't respond at " apiUrl " within 60s.`nOpen " devUrl " manually once the dev server is ready.", "Bookwyrm Scribe", "Icon!"
    }
}

HotkeylessAHK_Start() {
    repoPath := A_ScriptDir
    OpenFolderInOneCommander(repoPath)
    OpenFolderInVSCode(repoPath)
}

BookwyrmHoard_Start() {
    repoPath := "C:\Users\Jeron\Documents\Programming\Apps\Books\Bookwyrm Hoard - NextJS"
    devUrl := "http://localhost:3000"

    if !DirExist(repoPath) {
        MsgBox "Bookwyrm Hoard repo not found at:`n" repoPath, "Bookwyrm Hoard", "Icon!"
        return
    }

    OpenFolderInVSCode(repoPath)

    Run 'wt -d "' repoPath '" --title "Hoard Dev" cmd /k npm run dev'

    if WaitForUrl(devUrl, 60000) {
        Run devUrl
    } else {
        MsgBox "Next.js didn't respond at " devUrl " within 60s.`nOpen it manually once the dev server is ready.", "Bookwyrm Hoard", "Icon!"
    }
}

; Polls a URL with GETs until it responds (any 2xx-4xx) or timeout elapses.
WaitForUrl(url, timeoutMs := 30000, pollMs := 500) {
    whr := ComObject("WinHttp.WinHttpRequest.5.1")
    deadline := A_TickCount + timeoutMs
    while (A_TickCount < deadline) {
        try {
            whr.Open("GET", url, false)
            whr.SetTimeouts(1000, 1000, 1000, 1000)
            whr.Send()
            if (whr.Status >= 200 && whr.Status < 500) {
                return true
            }
        } catch {
            ; connection refused / pending — keep polling
        }
        Sleep pollMs
    }
    return false
}
