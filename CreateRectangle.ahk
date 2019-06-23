CreateRectangle(Identifier, XPos, YPos, Width := 30, Height := 30, BackColor := 0xFF00FF, ForeColor := "", Transparency := 255)
{
	Gui %Identifier%: Color, %BackColor%	; Set GUI BG color
	
	Gui %Identifier%: -Caption +ToolWindow +E0x20	; Create GUI With No Title Bar, No Taskbar Icon, Invisible To Alt-Tab, And That Is Click-Through
	
	if (BackColor = 0x010101 && ForeColor != "")	;	If BackColor Is 0x010101, Make BG Transparent And Turn Into Box Outline
	{
		;	Make Outline [Top]
		Gui %Identifier%: Add, Picture, % "x" 0 " y" 0 " w" Width " h" 2 " +0x4E +HWNDhPicture1"
		CreatePixel(StrReplace(ForeColor, "0x"), hPicture1)
	
		;	Make Outline [Bottom]
		Gui %Identifier%: Add, Picture, % "x" 0 " y" Height - 2 " w" Width " h" 2 " +0x4E +HWNDhPicture2"
		CreatePixel(StrReplace(ForeColor, "0x"), hPicture2)
	
		;	Make Outline [Left]
		Gui %Identifier%: Add, Picture, % "x" 0 " y" 0 " w" 2 " h" Height " +0x4E +HWNDhPicture3"
		CreatePixel(StrReplace(ForeColor, "0x"), hPicture3)
	
		;	Make Outline [Right]
		Gui %Identifier%: Add, Picture, % "x" Width - 2 " y" 0 " w" 2 " h" Height " +0x4E +HWNDhPicture4"
		CreatePixel(StrReplace(ForeColor, "0x"), hPicture4)
		
		Gui %Identifier%: Show, X%XPos% Y%YPos% W%Width% H%Height% NA, %Identifier%	; Show GUI
		
		WinSet, TransColor, 0x010101 255, %Identifier%	;	Make 0x010101 Invisible For This GUI
	
		WinSet AlwaysOnTop, ON, %Identifier%	; Always On Top
	}
	else	;	Else, Make Normal Colored Box With Defined Transparency
	{
		Gui %Identifier%: Show, X%XPos% Y%YPos% W%Width% H%Height% NA, %Identifier%	; Show GUI
	
		WinSet AlwaysOnTop, ON, %Identifier%	; Always On Top
	
		WinSet Transparent, %Transparency%, %Identifier%	; Set GUI Transparency
	}
}

; Overlay Color On Picture
CreatePixel(Color, Handle)
{
	VarSetCapacity(BMBITS, 4, 0), Numput("0x" . Color, &BMBITS, 0, "UInt")
	hBM := DllCall("Gdi32.dll\CreateBitmap", "Int", 1, "Int", 1, "UInt", 1, "UInt", 24, "Ptr", 0, "Ptr")
	hBM := DllCall("User32.dll\CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x2008, "Ptr")
	DllCall("Gdi32.dll\SetBitmapBits", "Ptr", hBM, "UInt", 3, "Ptr", &BMBITS) 
	DllCall("User32.dll\SendMessage", "Ptr", Handle, "UInt", 0x172, "Ptr", 0, "Ptr", hBM)
}

; Notes:
; An Example Of How To Use CreateRectangle For A Filled Box:
; CreateRectangle("ColoredFilledBox", A_ScreenWidth // 2, A_ScreenHeight // 2, 30, 30, 0xFF00FF, 0xFF00FF, 255)
; An Example Of How To Use CreateRectangle For A Non-Filled Outlined Box:
; CreateRectangle("BoxOutline", A_ScreenWidth // 2, A_ScreenHeight // 2, 30, 30, 0x010101, 0xFF00FF, 255)
; An Example Of How To Move The GUI Around:
; WinMove, ColoredFilledBox, , TargetLocationX - 15, TargetLocationY - 15
; WinMove, BoxOutline, , TargetLocationX - 15, TargetLocationY - 15
; An Example Of How To Hide The GUI:
; WinHide ColoredFilledBox, ,
; WinHide BoxOutline, ,
; An Example Of How To Make A Crosshair In The Screen's Center
; CrosshairHorz := CreateRectangle("CrosshairHorz", ZeroX - 5, ZeroY - 1, 10, 2, 0xFF00FF, 0xFF00FF, 255)
; CrosshairVert := CreateRectangle("CrosshairVert", ZeroX - 1, ZeroY - 5, 2, 10, 0xFF00FF, 0xFF00FF, 255)
; Enjoy!
; ~OFWModz~
