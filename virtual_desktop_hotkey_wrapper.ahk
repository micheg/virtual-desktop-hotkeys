#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

^!1::switchDesktopByNumber(1)
^!2::switchDesktopByNumber(2)
^!3::switchDesktopByNumber(3)
^!4::switchDesktopByNumber(4)
^!5::switchDesktopByNumber(5)
^!6::switchDesktopByNumber(6)
^!7::switchDesktopByNumber(7)
^!8::switchDesktopByNumber(8)
^!9::switchDesktopByNumber(9)

^!l::switchDesktopToRight()
^!h::switchDesktopToLeft()

^!q::MoveCurrentWindowToDesktop(1)
^!w::MoveCurrentWindowToDesktop(2)
^!e::MoveCurrentWindowToDesktop(3)
^!r::MoveCurrentWindowToDesktop(4)
^!t::MoveCurrentWindowToDesktop(5)
^!y::MoveCurrentWindowToDesktop(6)
^!u::MoveCurrentWindowToDesktop(7)
^!i::MoveCurrentWindowToDesktop(8)
^!o::MoveCurrentWindowToDesktop(9)

^!c::createVirtualDesktop()
^!d::deleteVirtualDesktop()

; Copy this function into your script to use it.
; Run, cmd.exe /c .\VirtualDesktop11.exe -Switch:1,, hide
; var := Run, cmd.exe /c .\VirtualDesktop11.exe -Count,, hide
; alsdj := RunWaitOne(".\VirtualDesktop11.exe -Count")
; alsdj := RunWaitOne("VirtualDesktop11.exe -Count")
; alsdj := RunHide("VirtualDesktop11.exe /Quiet /Count")
; alsdj := Run, cmd.exe /c .\VirtualDesktop11.exe -Switch:1,, hide
; switchDesktopByNumber(1)
; return

createVirtualDesktop() {
    RunVirtualDesktopCommand("-New -Switch")
}

deleteVirtualDesktop() {
    RunVirtualDesktopCommand("-GetCurrentDesktop -Remove")
}

MoveCurrentWindowToDesktop(desktopNumber) {
    correctDesktopNumber := desktopNumber - 1
    RunVirtualDesktopCommand("-GetDesktop:" correctDesktopNumber " -MoveActiveWindow -Switch:" correctDesktopNumber)
}

switchDesktopToLeft() {
    RunVirtualDesktopCommand("-Left")
	updateTrayIcon(targetDesktop)
}

switchDesktopToRight() {
    RunVirtualDesktopCommand("-Right")
	updateTrayIcon(targetDesktop)
}

switchDesktopByNumber(targetDesktop) {
    correctDesktopNumber := targetDesktop - 1
    RunVirtualDesktopCommand("-Switch:" correctDesktopNumber)
	updateTrayIcon(targetDesktop)
}

updateTrayIcon(desktopNumber) {
	Menu, Tray, Icon, icons/%desktopNumber%.ico
}

RunVirtualDesktopCommand(Command) {
    Run, cmd.exe /c .\VirtualDesktop11.exe %Command%,, hide
}

RunHide(Command) {
	dhw := A_DetectHiddenWindows
	DetectHiddenWindows, On
	Run, %ComSpec%,, Hide, cPid
	WinWait, ahk_pid %cPid%
	DetectHiddenWindows, %dhw%
	DllCall("AttachConsole", "uint", cPid)

	Shell := ComObjCreate("WScript.Shell")
	Exec := Shell.Exec(Command)
	Result := Exec.StdOut.ReadAll()

	DllCall("FreeConsole")
	Process, Close, %cPid%
	Return Result
}