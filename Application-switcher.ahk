#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
; ~Escape::Reload
; Shortcut for jumping to applications and cycling through open windows of that application
~^s::Reload

;cannot user classes because vscode and chrome are same
OpenProgram(applicationPath){
	run "%applicationPath%",,, process_id
		WinWait, ahk_pid %process_id%,, 1.5
		if ErrorLevel{
			error = winwait failed
		}
    WinActivate, ahk_pid %process_id%
}
FocusOrOpen(windowTitle, applicationPath){
	if(WinExist(windowTitle)){
		if(WinActive(windowTitle)){
			WinActivateBottom, %windowTitle%
		}
		else{
			WinActivate
		}
	}
	else{
		OpenProgram(ApplicationPath)
	}
	Return
}

#1::FocusOrOpen("- Visual Studio Code","C:\Users\donne\AppData\Local\Programs\Microsoft VS Code\Code.exe")
#+1::OpenProgram("C:\Users\donne\AppData\Local\Programs\Microsoft VS Code\Code.exe")
#2::FocusOrOpen("- Google Chrome","C:\Program Files\Google\Chrome\Application\chrome.exe")
#+2::OpenProgram("C:\Program Files\Google\Chrome\Application\chrome.exe")
#4::FocusOrOpen("Notion", "C:\Users\donne\AppData\Local\Programs\Notion\Notion.exe")
#3::FocusOrOpen("ahk_class CabinetWClass", "C:\Users\donne\Desktop\Personal")
#+3::OpenProgram("C:\Users\donne\Desktop\Personal")