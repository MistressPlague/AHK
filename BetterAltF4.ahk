<!F4::
{
	WinGet, xPID, PID, A

	Gui, Add, Text,,  Are You Sure?
	Gui, Add, Button, x10 y25 w100 h25, YES
	Gui, Add, Button, x110 y25 w100 h25, NO
	Gui, Show
	Gui Flash
	Suspend, On
	return

	GuiClose:
	{
		Gui, Destroy
		Suspend, Off
		return
	}

	ButtonYES:
	{
		Process, Close, %xPID%
		Gui, Destroy
		Suspend, Off
		return
	}

	ButtonNO:
	{
		Gui, Destroy
		Suspend, Off
		return
	}
}
