#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
; ~Escape::Reload
; Shortcut for jumping to applications and cycling through open windows of that application
~^s::Reload
; get size of current monitor

;close window

;snap winsow fullscreen
#f::
  WinGet mon, ID, A
  activeMon := GetMonitorIndexFromWindow(activeWin)
  SysGet mon, Monitorworkarea, %activeMon%
  WinMove,A,,monleft, montop,monright,monbottom
  return
;snap window left
#j::
  WinGet mon, ID, A
  activeMon := GetMonitorIndexFromWindow(activeWin)
  SysGet mon, Monitorworkarea, %activeMon%
  WinMove,A,,monleft, montop,(monright-monleft)/2,monbottom
  return
;snap window right
#;::
  WinGet mon, ID, A
  activeMon := GetMonitorIndexFromWindow(activeWin)
  SysGet mon, Monitorworkarea, %activeMon%
  WinMove,A,,(monright-monleft)/2, montop,monright,monbottom
  return

;utility functions

GetMonitorIndexFromWindow(windowHandle)
{
	; Starts with 1.
	monitorIndex := 1

	VarSetCapacity(monitorInfo, 40)
	NumPut(40, monitorInfo)
	
	if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2)) 
		&& DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) 
	{
		monitorLeft   := NumGet(monitorInfo,  4, "Int")
		monitorTop    := NumGet(monitorInfo,  8, "Int")
		monitorRight  := NumGet(monitorInfo, 12, "Int")
		monitorBottom := NumGet(monitorInfo, 16, "Int")
		workLeft      := NumGet(monitorInfo, 20, "Int")
		workTop       := NumGet(monitorInfo, 24, "Int")
		workRight     := NumGet(monitorInfo, 28, "Int")
		workBottom    := NumGet(monitorInfo, 32, "Int")
		isPrimary     := NumGet(monitorInfo, 36, "Int") & 1

		SysGet, monitorCount, MonitorCount

		Loop, %monitorCount%
		{
			SysGet, tempMon, Monitor, %A_Index%

			; Compare location to determine the monitor index.
			if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop)
				and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom))
			{
				monitorIndex := A_Index
				break
			}
		}
	}
	
	return %monitorIndex%
}