#Requires AutoHotkey v2.0
SendMode("Input")
SetWorkingDir(A_ScriptDir)
TraySetIcon("files\icon.ico")
A_IconTip := "HotkeylessAHK"
#SingleInstance force
#Include files\lib.ahk
#Include Common\sharedfunctions.ahk
#Include Valhalla\Vallhalla_Main.ahk
#Include Prompts\Gemini.ahk
; HotkeylessAHK by sebinside
; ALL INFORMATION: https://github.com/sebinside/HotkeylessAHK
; Make sure that you have downloaded everything, especially the "/files" folder.
; Make sure that you have Node.js installed and available in the PATH variable.

serverPort := 42800 ; The port that the server will listen on. Make sure that this port is not blocked by your firewall or used by another application.

functionClassNames := ["CustomFunctions"] ; this can be expanded to allow for other function classes, i.e., PersonalFunctions, WorkFunctions and so on. Note that duplicate function names may hide each other as there is no handling for scopes!
; These classes can (of course) be defined in other AHK files and imported using #Include "<path to AHK file>".

debug := false ; set to true to see the console output of the Node.js server. This will also show the console window, which is hidden by default.

SetupServer(serverPort, debug)
RunClient(serverPort, functionClassNames)

; Your custom functions go into the 'CustomFunctions' class.
; You can then call them by using the URL "localhost:<serverPort>/send/<functionName>"
; The function name "kill" is reserved.

class CustomFunctions {
	; Original Functions
	HelloWorld() {
		MsgBox "Hello, World!"
	}

	OpenExplorer() {
		Run "explorer.exe"
	}

	; can be called using the URL "localhost:<serverPort>/send/FunctionWithParams?Hello,World"
	FunctionWithParams(param1, param2) {
		MsgBox "Param1: " . param1 . "`nParam2: " . param2
	}

	; Common Functions
	KillAllScripts() {
		ExitApp
		ToolTip "All Scripts Killed"
		Sleep 3000
		ToolTip
		Sleep 2000
		return
	}

	ReloadScript() {
		Reload
		return
	}

	; Valhalla Functions ---------------------------------------------------------
	Valhalla_HelloWorld2() {
		HelloWorld2()
	}

	; Valhalla - Work Functions --------------------------------------------------
	Valhalla_EndWork() {
		EndWork()
	}

	; Valhalla - Workspace Functions ---------------------------------------------
	Valhalla_DigitalMuse_Etsy() {
		DigitalMuse_Etsy()
	}

	Valhalla_Firefox_GeminiChatGPT() {
		Workspace_Firefox_GeminiChatGPT()
	}

	; Valhalla - Action Functions ------------------------------------------------
	Valhalla_CodexApprove() {
		Action_CodexApprove()
	}

	; Gemini - Prompts -----------------------------------------------------------
	; Single Piece - Aligned -----------------------------------------------------
	Gemini_Statement18x24(roomTheme := "") {
		return Gemini_Statement18x24Prompt(roomTheme)
	}

	Gemini_StatementFlexible(roomTheme := "") {
		return Gemini_StatementFlexiblePrompt(roomTheme)
	}
	; Multi Piece - Aligned ------------------------------------------------------
	Gemini_HeroMultiAligned(imageCount := "") {
		return Gemini_HeroMultiAlignedPrompt(imageCount)
	}

	Gemini_RoomMultiAligned(imageCount := "") {
		return Gemini_RoomMultiAlignedPrompt(imageCount)
	}

	Gemini_OfficeMultiAligned(imageCount := "") {
		return Gemini_OfficeMultiAlignedPrompt(imageCount)
	}

	Gemini_LivingMultiAligned(imageCount := "") {
		return Gemini_LivingMultiAlignedPrompt(imageCount)
	}

	Gemini_StatementMultiAligned(imageCount := "", roomTheme := "") {
		return Gemini_StatementMultiAlignedPrompt(imageCount, roomTheme)
	}

	; Multi Piece - Staggered ---------------------------------------------------
	Gemini_HeroMultiStaggered(imageCount := "") {
		return Gemini_HeroMultiStaggeredPrompt(imageCount)
	}

	Gemini_RoomMultiStaggered(imageCount := "") {
		return Gemini_RoomMultiStaggeredPrompt(imageCount)
	}

	Gemini_OfficeMultiStaggered(imageCount := "") {
		return Gemini_OfficeMultiStaggeredPrompt(imageCount)
	}

	Gemini_LivingMultiStaggered(imageCount := "") {
		return Gemini_LivingMultiStaggeredPrompt(imageCount)
	}

	Gemini_StatementMultiStaggered(imageCount := "", roomTheme := "") {
		return Gemini_StatementMultiStaggeredPrompt(imageCount, roomTheme)
	}
}


