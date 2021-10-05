#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Singleinstance,Force
CoordMode,Mouse,Client
DetectHiddenWindows,ON
Gui,Color,009AE4
SetKeyDelay,-1,50

Gui,Font,s8 normal
Gui,add,GroupBox,x10 y+0 w370 h135 cBlack,Set PID Window
Gui,add,listview,x15 y15 r5 w83 grid cBlack vListSpammer gUpdate,Window PID

Gui,add,button,x+5 y15 w85 h30 gAddSpammer,Add Window
Gui,add,button,x+5 w85 h30 gCloseSpammer,Close
Gui,add,button,x+5 w85 h30 gCloseallSpammer,Close All

Gui,add,button,x103 y+5 w85 h33 gShowSpammer,Show
Gui,add,button,x+5 w85 h33 gHideSpammer,Hide
Gui,add,button,x+5 w85 h33 gDeleteSpammer,Delete

Gui,add,button,x103 y+5 w85 h33 gShowAllSpammer,Show All
Gui,add,button,x+5 w85 h33 gHideAllSpammer,Hide All
Gui,add,button,x+5 w85 h33 gDeleteAllSpammer,Delete All

Gui,add,GroupBox,x10 y150 w370 h133 cBlack,Set Text 
Gui,Font,cBlack s9
Gui,add,listview,x15 y165 w260 r6 grid gUpdate vListTExt -hdr,Text

Gui,add,button,x+5 w85 h33 gAddTextSpammer,Add Text
Gui,add,button,y+5 w85 h33 gDeleteTExtSpammer,Delete
Gui,add,button,y+5 w85 h33 gDeleteAllTExtSpammer,Delete All

Gui,add,text,x10 y+15 cBlack,Delay
Gui,add,edit,x+10 w80 vDelaySpammer gUpdate,4000
;Gui,add,button,x+10 h23 w100 ,Refresh

Gui,Font,s12
Gui,add,button,x10 y+10 w180 h40 gStartSpammer vStartSpammer,Start
Gui,add,button,x+10 w180 h40 gStopSpammer vStopSpammer,Stop
Gui,Font,
Gui,Show,h400,Spammer
Gui,Add,StatusBar
SB_SetText("Copyright Chichiya Team. All rights reserved.",1)
Gui,Submit,Nohide
return


UPdate:
Gui,Submit,Nohide
return


StartSpammer:
GuiControl,Disable,StartSpammer
GuiControl,Enable,StopSpammer
Counter := 1
Counter1 := 1

Gui,Listview,ListSpammer
Rows := Lv_GetCount()

loop,%Rows%
{
Lv_GetText(TargetWindow,A_Index)
Winpid%counter% := TargetWindow
;msgbox,%TargetWindow%
counter++
}
counter := 1

Gui,Listview,ListText
Row := Lv_GetCount()

loop ,%Row%{
LV_GetText(SpamText,A_Index)
Text%counter1% := SpamText
;msgbox,%SpamText%
counter1++
}
counter1 := 1

Gui,Submit,Nohide
settimer,StartSpam,1
return

StartSpam:
Text := Text%counter1%
Window := Winpid%counter%
ControlSend,,{enter},Ahk_Pid %Window%
ControlSend,,%text%,Ahk_Pid %Window%
ControlSend,,{enter},Ahk_Pid %Window%
counter++
if (counter > rows)
{
sleep,%delaySpammer%
counter := 1
counter1++
if (counter1 > row)
{
counter1 := 1
}
}
return

CloseSpammer:
Gui,Listview,ListSpammer
Active := LV_GetNext(,"F")
LV_GetText(PID,Active,1)
WinClose,Ahk_Pid %Pid%
Lv_delete(Active)
Gui,Submit,Nohide
return

DeleteSpammer:
Gui,Listview,ListSpammer
RowNumber := LV_GetNext(,"F")
LV_GetText(Text,RowNumber,1)
LV_Delete(RowNumber)
return

DeleteAllSpammer:
msgbox,4,Delete All,Are you sure you want to delete all Window PID?
ifmsgbox,Yes
{
Gui,Listview,ListSpammer
LV_Delete()
} else {
return
}
return

ShowSpammer:
Gui,Listview,ListSpammer
active := Lv_GetNext(,"F")
Lv_gettext(Pid,active,1)
WinShow,Ahk_Pid %Pid%
WinActivate,AHK_pid %pid%
return

hideSpammer:
Gui,Listview,ListSpammer
active := Lv_GetNext(,"F")
Lv_gettext(Pid,active,1)
WinHide,Ahk_Pid %Pid%
return

CloseAllSpammer:
Counter := 1
Gui,Listview,ListSpammer
Rows := Lv_GetCount()

msgbox,4,Close All PID,Are you sure you want to Close All PID?
ifmsgbox,Yes
{
loop,%Rows%
{
Lv_GetText(TargetWindow%counter%,A_Index)
Winpid := TargetWindow%counter%
WinClose,AHk_Pid %winPID%
Counter++
}
Lv_Delete()
} else {
return
}
return

ShowallSpammer:
Counter := 1
Gui,Listview,ListSpammer
Rows := Lv_GetCount()
loop,%Rows%
{
Lv_GetText(TargetWindow%counter%,A_Index)
Winpid := TargetWindow%counter%
WinShow,AHk_Pid %winPID%
Counter++
}
return

HideAllSpammer:
Counter := 1
Gui,Listview,ListSpammer
Rows := Lv_GetCount()
loop,%Rows%
{
Lv_GetText(TargetWindow%counter%,A_Index)
Winpid := TargetWindow%counter%
WinHide,AHk_Pid %winPID%
Counter++
}
return

StopSpammer:
GuiControl,Enable,StartSpammer
GuiControl,Disable,StopSpammer
Spammer := 0
settimer,StartSpam,off
return

addSpammer:
Spammer := SetSpammer()
Gui,Submit,Nohide
SetSpammer(){
i := 0
k := 0
	loop {
	WInGetTitle,Now,A
	tooltip,Click 2 times the Windows`n%now%
	Click := GetKeyState("Lbutton")
	if (Click == false && k == 0)
	k := 1
	else if (Click == true && k == 1)
	{
	i++
	K := 0
	if (i >= 2)
	{
	WinGet,Spammer,PID,A
	Gui,ListView,ListSpammer
	lv_add(,Spammer,A_Index)
	tooltip
	break
	}
	}
	}
return Spammer
}
return


DeleteTExtSpammer:
Gui,Listview,ListText
RowNumber := LV_GetNext(,"F")
LV_GetText(Text,RowNumber,1)
LV_Delete(RowNumber)
return

DeleteAllTExtSpammer:
msgbox,4,Delete All,Are you sure you want to delete all Text?
ifmsgbox,Yes
{
Gui,Listview,ListText
LV_Delete()
} else {
return
}
return

addtextSpammer:

loop{
Gui,+OwnDialogs +AlwaysOntop
Gui,ListView,ListTExt
Inputbox,TextSpammer,Promp,PUT ANY TEXT THAT YOU WANT TO SPAM.`n`nPRESS OK if you add more and PRESS CANCEL if not.,,200,200,,,, NA 
if errorlevel
{
if (TextSpammer != "")
{
Gui,ListView,TextSpammer
lv_add(A_Index,TextSpammer)
}
Gui,-AlwaysOntop
break 
} else {
if (TextSpammer != "")
{
Gui,ListView,TextSpammer
lv_add(A_Index,TextSpammer)
}
}
}
Gui,-AlwaysOntop
return

GuiClose:
Gui,+OwnDialogs +AlwaysOntop
msgbox,4,Exit App,Are you sure you want to Exit the program?
ifmsgbox,Yes
{
ExitApp
} else {
Gui,-AlwaysOntop
return
}
return