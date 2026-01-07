HelloWorld2() {
    MsgBox "Hello from Valhalla!"
}

EndWork() {
    CloseAppByProcess("ms-teams.exe")
    CloseAppByProcess("Teams.exe")
    CloseAppByProcess("mstsc.exe")
    CloseAppByProcess("FortiClientVPN.exe")
    ShutdownTrayApp("FortiTray.exe", "Shutdown")
    CloseAppByProcess("FortiClient.exe")
}


