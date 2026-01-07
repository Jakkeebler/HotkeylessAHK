CloseAppByProcess(processName) {
    hwnds := WinGetList("ahk_exe " processName)
    for hwnd in hwnds {
        try WinClose("ahk_id " hwnd)
    }

    Sleep 500

    while (pid := ProcessExist(processName)) {
        try ProcessClose(pid)
        Sleep 200
    }
}

ShutdownTrayApp(processName, menuItemText) {
    if (!ProcessExist(processName)) {
        return
    }

    trayPoint := FindTrayIconPoint(processName)
    if (trayPoint) {
        CoordMode "Mouse", "Screen"
        Click "Right", trayPoint.x, trayPoint.y
        if WinWaitActive("ahk_class #32768", , 1) {
            Send(menuItemText)
            Send("{Enter}")
            Sleep 500
        }
    }

    CloseAppByProcess(processName)
}

FindTrayIconPoint(processName) {
    toolbars := GetTrayToolbars()
    for hToolbar in toolbars {
        point := FindTrayIconPointInToolbar(hToolbar, processName)
        if (point) {
            return point
        }
    }
    return false
}

GetTrayToolbars() {
    toolbars := []
    shellTray := DllCall("FindWindow", "Str", "Shell_TrayWnd", "Ptr", 0, "Ptr")
    trayNotify := DllCall("FindWindowEx", "Ptr", shellTray, "Ptr", 0, "Str", "TrayNotifyWnd", "Ptr", 0, "Ptr")
    sysPager := DllCall("FindWindowEx", "Ptr", trayNotify, "Ptr", 0, "Str", "SysPager", "Ptr", 0, "Ptr")
    toolbar := DllCall("FindWindowEx", "Ptr", sysPager, "Ptr", 0, "Str", "ToolbarWindow32", "Ptr", 0, "Ptr")
    if (toolbar) {
        toolbars.Push(toolbar)
    }

    overflow := DllCall("FindWindow", "Str", "NotifyIconOverflowWindow", "Ptr", 0, "Ptr")
    overflowToolbar := DllCall("FindWindowEx", "Ptr", overflow, "Ptr", 0, "Str", "ToolbarWindow32", "Ptr", 0, "Ptr")
    if (overflowToolbar) {
        toolbars.Push(overflowToolbar)
    }

    return toolbars
}

FindTrayIconPointInToolbar(hToolbar, processName) {
    static TB_BUTTONCOUNT := 0x418
    static TB_GETBUTTON := 0x417
    static TB_GETITEMRECT := 0x41D
    static PROCESS_VM_READ := 0x0010
    static PROCESS_QUERY_INFORMATION := 0x0400
    static TBBUTTON_SIZE := A_PtrSize = 8 ? 32 : 20

    pid := 0
    DllCall("GetWindowThreadProcessId", "Ptr", hToolbar, "UInt*", &pid)
    if (!pid) {
        return false
    }

    hProcess := DllCall("OpenProcess", "UInt", PROCESS_VM_READ | PROCESS_QUERY_INFORMATION, "Int", 0, "UInt", pid, "Ptr")
    if (!hProcess) {
        return false
    }

    buttonCount := SendMessage(TB_BUTTONCOUNT, 0, 0, , "ahk_id " hToolbar)
    if (buttonCount <= 0) {
        DllCall("CloseHandle", "Ptr", hProcess)
        return false
    }

    tbbuf := Buffer(TBBUTTON_SIZE, 0)
    trayBuf := Buffer(A_PtrSize + 8, 0)
    rect := Buffer(16, 0)
    pt := Buffer(8, 0)

    loop buttonCount {
        index := A_Index - 1
        SendMessage(TB_GETBUTTON, index, tbbuf, , "ahk_id " hToolbar)
        dataPtr := NumGet(tbbuf, 16, "Ptr")
        if (!dataPtr) {
            continue
        }

        bytesRead := 0
        if (!DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", dataPtr, "Ptr", trayBuf, "UPtr", trayBuf.Size, "UPtr*", &bytesRead)) {
            continue
        }

        hWnd := NumGet(trayBuf, 0, "Ptr")
        if (!hWnd) {
            continue
        }

        try procName := WinGetProcessName("ahk_id " hWnd)
        catch {
            continue
        }

        if (StrLower(procName) != StrLower(processName)) {
            continue
        }

        SendMessage(TB_GETITEMRECT, index, rect, , "ahk_id " hToolbar)
        left := NumGet(rect, 0, "Int")
        top := NumGet(rect, 4, "Int")
        right := NumGet(rect, 8, "Int")
        bottom := NumGet(rect, 12, "Int")
        centerX := left + ((right - left) // 2)
        centerY := top + ((bottom - top) // 2)
        NumPut("Int", centerX, pt, 0)
        NumPut("Int", centerY, pt, 4)
        DllCall("ClientToScreen", "Ptr", hToolbar, "Ptr", pt)
        x := NumGet(pt, 0, "Int")
        y := NumGet(pt, 4, "Int")

        DllCall("CloseHandle", "Ptr", hProcess)
        return {x: x, y: y}
    }

    DllCall("CloseHandle", "Ptr", hProcess)
    return false
}
