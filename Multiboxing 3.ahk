SetDefaultMouseSpeed,0
SetBatchLines,-1
SetControlDelay,-1
SetKeyDelay,-1
SetMouseDelay,-1
DetectHiddenWindows,On
Suspend,On
#SingleInstance,Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client


Gui,Add,Listview,x15 y10 w100 h230 vWindow,Window PID
Gui,Add,Button,x125 y10 w100 h30 gAddWindow,Add Window
Gui,Add,Button,y+10 w100 h30 gHide,Hide
Gui,Add,Button,y+10 w100 h30 gShow,Show
Gui,Add,Button,y+10 w100 h30 gHideAll,Hide All
Gui,Add,Button,y+10 w100 h30 gShowAll,Show All
Gui,Add,Button,y+10 w100 h30 gRemove,Remove PID

Gui,Add,Button,x15 y260 w100 h35 vStartButton gStartMultiboxing,Start Multiboxing
Gui,Add,Button,x+10 w100 h35 vStopButton gStopMultiboxing,Stop Multiboxing
Gui,Add,Button,x15 y306 w100 h35,
Gui,Add,Button,x+10 w100 h35 gCloseAll,Close All



Gui,Show,w240,Multiboxing 3
Gui,Color,009AE4
Gui,Submit,Nohide












return





stopmultiboxing:
GuiControl,Disable,stopbutton
GuiControl,Enable,startbutton
Suspend,On
return


startmultiboxing:
GuiControl,Disable,startbutton
GuiControl,Enable,stopbutton
windowcount:=LV_GetCount()
counter:=1
loop, %windowcount%{
	LV_GetText(window%counter%,counter)
	counter++
}


Suspend, Off
return






Update:
Gui,Submit,NOhide
return


GuiClose:
ExitApp
return

Hide:
RowNumber := LV_GetNext(,"F")
LV_GetText(Window,RowNumber,1)
WinHide,ahk_pid %Window%
return

Show:
RowNumber := LV_GetNext(,"F")
LV_GetText(Window,RowNumber,1)
WinShow,ahk_pid %Window%
WinActivate,ahk_pid %Window%
return

HideAll:
Gui,ListView,Window
Loop % LV_GetCount()
{
	LV_GetText(RetrievedText, A_Index)
	WinHide,ahk_pid %RetrievedText%
}
return

ShowAll:
Gui,ListView,Window
Loop % LV_GetCount()
{
	LV_GetText(RetrievedText, A_Index)
	WinShow,ahk_pid %RetrievedText%
}
return

Remove:
LV_DeleteSelectedRows("Window")
return

CloseAll:
Gui,ListView,Window
MsgBox,4,Close,Are you sure you want to close all PID?
IfMsgBox,Yes
{
Loop % LV_GetCount()
{
	LV_GetText(RetrievedText, A_Index)
	WinClose,ahk_pid %RetrievedText%
}
LV_Delete()
}
return

AddWindow:
isPressed:=0,i:=0
Loop
{
Left_Mouse:=GetKeyState("LButton")
WinGetTitle,Temp_Window,A
ToolTip,Left Click on the target window twice to set `n`n Current Window: %Temp_Window%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if (i>2)
{
Winget,Target_Window,pid,A
ToolTip,
Gui,ListView,Window
LV_Add(,Target_Window)
break
}
}
}
return










~RButton::
MouseGetPos,MouseCLickedOnX,MouseClickedOnY
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	counter:=1
	loop,%windowcount%{
		WinGet,value,PID,A
		window:=window%counter%
		if (value != window) {
			ControlClick,,ahk_pid %window%,,Right,,X%MouseCLickedOnX% Y%MouseClickedOnY% NA D
		}
		counter++
	}
}
return


~RButton Up::
counter:=1
loop,%windowcount%{
	window:=window%counter%
	ControlClick,,ahk_pid %window%,,Right,,X%MouseCLickedOnX% Y%MouseClickedOnY% NA U
	counter++
}
return




~LButton::
MouseGetPos,MouseCLickedOnX,MouseClickedOnY
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	counter:=1
	loop,%windowcount%{
		WinGet,value,PID,A
		window:=window%counter%
		if (value != window) {
			ControlClick,,ahk_pid %window%,,Left,,X%MouseCLickedOnX% Y%MouseClickedOnY% NA D
		}
		counter++
	}
}
return


~LButton Up::
counter:=1
loop,%windowcount%{
	window:=window%counter%
	ControlClick,,ahk_pid %window%,,Left,,X%MouseCLickedOnX% Y%MouseClickedOnY% NA U
	counter++
}
return


~w::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("w")
}
return


~w Up::
SendKeyUp("w")
return


~a::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("a")
}
return


~a up::
SendKeyUp("a")
return


~s::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("s")
}
return


~s up::
SendKeyUp("s")
return


~d::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("d")
}
return


~d up::
SendKeyUp("d")
return


~q::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("q")
}
return


~q up::
SendKeyUp("q")
return


~e::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("e")
}
return


~e up::
SendKeyUp("e")
return


~r::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("r")
}
return


~r up::
SendKeyUp("r")
return


~t::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("t")
}
return


~t up::
SendKeyUp("t")
return


~y::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("y")
}
return


~y up::
SendKeyUp("y")
return


~u::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("u")
}
return


~u up::
SendKeyUp("u")
return


~i::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("i")
}
return


~i up::
SendKeyUp("i")
return


~o::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("o")
}
return


~o up::
SendKeyUp("o")
return


~p::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("p")
}
return


~p up::
SendKeyUp("p")
return


~f::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("f")
}
return


~f up::
SendKeyUp("f")
return


~g::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("g")
}
return


~g up::
SendKeyUp("g")
return


~h::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("h")
}
return


~h up::
SendKeyUp("h")
return


~j::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("j")
}
return


~j up::
SendKeyUp("j")
return


~k::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("k")
}
return


~k up::
SendKeyUp("k")
return


~l::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("l")
}
return


~l up::
SendKeyUp("l")
return


~z::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("z")
}
return


~z up::
SendKeyUp("z")
return


~x::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("x")
}
return


~x up::
SendKeyUp("x")
return


~c::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("c")
}
return


~c up::
SendKeyUp("c")
return


~v::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("v")
}
return


~v up::
SendKeyUp("v")
return


~b::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("b")
}
return


~b up::
SendKeyUp("b")
return


~n::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("n")
}
return


~n up::
SendKeyUp("n")
return


~m::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("m")
}
return


~m up::
SendKeyUp("m")
return


~1::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("1")
}
return


~1 up::
SendKeyUp("1")
return


~2::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("2")
}
return


~2 up::
SendKeyUp("2")
return


~3::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("3")
}
return


~3 up::
SendKeyUp("3")
return


~4::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("4")
}
return


~4 up::
SendKeyUp("4")
return


~5::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("5")
}
return


~5 up::
SendKeyUp("5")
return


~6::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("6")
}
return


~6 up::
SendKeyUp("6")
return


~7::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("7")
}
return


~7 up::
SendKeyUp("7")
return


~8::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("8")
}
return


~8 up::
SendKeyUp("8")
return




~9::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("9")
}
return


~9 up::
SendKeyUp("9")
return


~0::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("0")
}
return
 

~0 up::
SendKeyUp("0")
return


~Space::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("Space")
}
return


~Space up::
SendKeyUp("Space")
return


~Esc::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("Esc")
}
return


~Esc up::
SendKeyUp("Esc")
return


~Tab::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("Tab")
}
return


~Tab up::
SendKeyUp("Tab")
return


~Enter::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("Enter")
}
return


~Enter up::
SendKeyUp("Enter")
return


~Backspace::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("Backspace")
}
return

return
~Backspace up::
SendKeyUp("Backspace")
return



~`::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("``")
}
return


~` up::
SendKeyUp("``")
return





~/::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("/")
}
return


~/ up::
SendKeyUp("/")
return




~[::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("[")
}
return


~[ up::
SendKeyUp("[")
return


~]::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("]")
}
return


~] up::
SendKeyUp("]")
return


~\::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("\")
}
return


~\ up::
SendKeyUp("\")
return

~;::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown(";")
}
return


~; up::
SendKeyUp(";")
return


~'::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("'")
}
return


~' up::
SendKeyUp("'")
return


~,::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown(",")
}
return


~, up::
SendKeyUp(",")
return



~.::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown(".")
}
return


~. up::
SendKeyUp(".")
return


~LShift::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("LShift")
}
return


~LShift up::
SendKeyUp("LShift")
return


~RShift::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("RShift")
}
return


~RShift up::
SendKeyUp("RShift")
return



~Alt::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("Alt")
}
return


~Alt up::
SendKeyUp("Alt")
return


~Ctrl::
Winget,ActiveWindow,ProcessName,A
if (ActiveWindow == "Growtopia.exe"){
	SendKeyDown("Ctrl")
}
return


~Ctrl up::
SendKeyUp("Ctrl")
return






SendKeyUp(key){
	global
	counter:=1
	loop,%windowcount%{
		window:=window%counter%
		ControlSend,,{%key% Up},ahk_pid %window%
		counter++
	}
}

SendKeyDown(key){
	global
	counter:=1
	loop,%windowcount%{
		WinGet,value,PID,A
		window:=window%counter%
		if (value != window) {
			ControlSend,,{%key% down},ahk_pid %window%
		}
		counter++
	}
	
	
}











LV_DeleteSelectedRows(listviewname) { ; Deletes selected rows and returns number of deleted rows. by Learning one
global
Gui,MainGUI:ListView,%listviewname%
SelectedRowsCount := 0
SelectedRows:=
;=== Get SelectedRows ===
RowNumber := 0
Loop
{
RowNumber := LV_GetNext(RowNumber)
if !RowNumber
break
SelectedRows .= RowNumber "|"
SelectedRowsCount ++
}

StringTrimRight, SelectedRows, SelectedRows, 1
TotalRows := LV_GetCount() ; LV_GetCount() returns the total number of rows in the control

If (SelectedRowsCount = TotalRows) { ; all selected
LV_Delete() ; If the parameter is omitted, all rows in the ListView are deleted
return SelectedRowsCount
}
else if (SelectedRowsCount = 0) ; nothing selected
return 0
else {
Loop, parse, SelectedRows, |
{
if (A_index = 1)
LV_Delete(A_LoopField)
else
LV_Delete(A_LoopField-A_Index+1)
}

Gui,MainGUI:Submit,NoHide
return SelectedRowsCount
}
}







