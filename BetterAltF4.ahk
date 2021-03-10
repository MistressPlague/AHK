<!F4::
{
	WinGet, xPID, PID, A
	WinGetTitle, Title, A

	Gui, +AlwaysOnTop
	Gui, Color, 000000
	Gui, Font, S8 cFF00FF Bold, Verdana
	Gui, Add, Text,, What Would You Like To Do To:
	Gui, Add, Text, x10 y26, %Title%?
	Gui, Add, Button, cRed x10 y50 w75 h25, Kill
	Gui, Add, Button, x85 y50 w75 h25, Close
	Gui, Add, Button, x160 y50 w75 h25, Cancel
	Gui, Show, Restore, BetterAltF4
	Gui Flash
	Suspend, On
	return

	GuiClose:
	{
		Gui, Destroy
		Suspend, Off
		return
	}

	ButtonKill:
	{
		Process, Close, %xPID%
		Gui, Destroy
		Suspend, Off
		return
	}

	ButtonClose:
	{
		WinClose, %Title%
		Gui, Destroy
		Suspend, Off
		return
	}
	
	ButtonCancel:
	{
		Gui, Destroy
		Suspend, Off
		return
	}
}
