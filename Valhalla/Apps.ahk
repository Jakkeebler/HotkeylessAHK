; Valhalla - App Launchers ------------------------------------------------------
; Each launcher opens VS Code on the repo, launches dev commands in Windows Terminal
; (split panes), waits for the dev server to respond, then opens the default browser.

BookwyrmScribe_Start() {
    repoPath := "C:\Users\Jeron\Documents\Programming\Apps\Books\Bookwyrm Scribe - NodeJS"
    devUrl := "http://localhost:5173"

    if !DirExist(repoPath) {
        MsgBox "Bookwyrm Scribe repo not found at:`n" repoPath, "Bookwyrm Scribe", "Icon!"
        return
    }

    OpenFolderInVSCode(repoPath)

    Run 'wt -d "' repoPath '" --title "Scribe Server" cmd /k npm run dev:server'
    Sleep 800
    Run 'wt -w 0 split-pane -H -d "' repoPath '" --title "Scribe Client" cmd /k npm run dev:client'

    if WaitForUrl(devUrl, 60000) {
        Run devUrl
    } else {
        MsgBox "Vite didn't respond at " devUrl " within 60s.`nOpen it manually once the dev server is ready.", "Bookwyrm Scribe", "Icon!"
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
