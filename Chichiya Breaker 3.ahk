SetDefaultMouseSpeed,0
SetBatchLines,-1
SetControlDelay,-1
SetKeyDelay,-1
SetMouseDelay,-1
WindowCount:=2
DetectHiddenWindows,On
Suspend,On
#SingleInstance,Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client


Gui,Add,Listview,x15 y10 w100 h230 vWindow Checked,Window PID
Gui,Add,Button,x125 y10 w100 h30 gAddWindow,Add Window
Gui,Add,Button,y+10 w100 h30 gHide,Hide
Gui,Add,Button,y+10 w100 h30 gShow,Show
Gui,Add,Button,y+10 w100 h30 gHideAll,Hide All
Gui,Add,Button,y+10 w100 h30 gShowAll,Show All
Gui,Add,Button,y+10 w100 h30 gRemove,Remove PID

Gui,Add,Button,x15 y260 w100 h35 gStartBreaker,Start Breaker
Gui,Add,Button,x+10 w100 h35 gstopbreaker,Stop Breaker
Gui,Add,Button,x15 y306 w100 h35,
Gui,Add,Button,x+10 w100 h35 gCloseAll,Close All Growtopia

Gui,Color,009AE4
gui,show,,Breaker 3

return

Stopbreaker:
stop:=true
return



StartBreaker:
stop:=false
loop, {
LV_GetChecked()

counter:=1
loop,%totalchecked%{
	window:=window%counter%
	ControlSend,,{Space Down},ahk_pid %window%
	counter++
}

loop,70
if not stop{
	sleep,100
}else {
	counter:=1
	loop,%totalchecked%{
		window:=window%counter%
		ControlSend,,{Space Up},ahk_pid %window%
		counter++
	}
	return
}


counter:=1
loop,%totalchecked%{
	window:=window%counter%
	ControlSend,,{Space Up},ahk_pid %window%
	counter++
}



}


return


DeleteChecked(){
	global
	lvcount:=LV_GetCount()
	counter:=1
	loop,%lvcount%{
		window:=window%counter%
		window:=
		counter++
	}
	
}

LV_GetChecked() {
	global
	DeleteChecked()
	totalchecked:=1
    while rowNumber := LV_GetNext(rowNumber, "C")
	{
		LV_GetText(window%totalchecked%,rowNumber)
		totalchecked++
	}
	totalChecked--
}



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

Start:
return

Stop:
return


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
