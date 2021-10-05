#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Singleinstance,Force
CoordMode,Mouse,Client
DetectHiddenWindows,ON
SetKeyDelay,-1,50



Gui,add,text,x233 y30,(Paste Growtopia File Here)
Gui,add,edit,x228 y50 w140 vGTFILE gUpdate r1

Gui,add,edit,x285 w60 gUpdate r1 number vdelayperlogin,2000
Gui,add,updown, gUpdate Range1-100000,2000
Gui,add,text,x250 y80,Delay:

Gui,Font,cBlack s12 normal
Gui,add,groupbox,x10 y5 w370 h110 center,Set Auto Login 

Gui,Font,cBlack s8 normal
Gui,add,button,x15 y30 w100 gtarget1,Set Coord`nGrow ID
Gui,Font,cBlack s15 normal
Gui,add,edit,x+5 w100 r1 center vID gupdate,
Gui,Font,cBlack s8 normal
Gui,add,button,x15 y+5 w100 gtarget2,Set Coord`nPassword
Gui,Font,cBlack s15 normal
Gui,add,edit,x+5 w100 r1 center vPASS gUpdate,

Gui,Font,cBlack s15 normal
Gui,add,groupbox,x35 y115 w320 h195 center,Set GrowID and Password

Gui,Font,
Gui,Add,button, x215 y250 h35 w90 vbutton1 gAddAccount,Add Account
Gui,Add,button, x70 y265 h35 w90 vbutton2 gDeleteSelected,Remove Account
Gui,Add,ListView,col0 x65 y150 w100 r6 grid vAccountList gLVUpdate -hdr,Username|Password
Gui,Add,Checkbox,x205 y220 h25 w20 BackgroundTrans gShowPass vShowpass,
Gui,Add,Text,x225 y225 BackgroundTrans gShowPass2 ,Show Password

LV_ModifyCol(1,96)

Gui,add,text,x180 y170,Username:
Gui,add,edit,x240 y168 w80 h20 vusername,
Gui,add,text,x180 y200,Password:
Gui,add,edit,x240 y198 w80 h20 password vpassword,

Gui,Add,Button,x148 y320 w100 h30 glabel1,START
Gui,Add,Button,y+5 w100 h30 gSetDefault,Save
Gui,Submit,Nohide
gosub,loaddefault
LV_ModifyCol(2,(t:=!t) ?  0:"AutoHdr") ;For demonstration.

Gui,Add,StatusBar
SB_SetText("Copyright Chichiya Team. All rights reserved.",1)
Gui,Color,009AE4
Gui,Show,w390 h415,Auto Login
return




LoadDefault:
IniRead,x1,%A_Temp%\ALSD.ini,GrowID Coordinate,x
IniRead,y1,%A_Temp%\ALSD.ini,GrowID Coordinate,y
GuiControl,,ID,%x1% %y1%

IniRead,x2,%A_Temp%\ALSD.ini,Password Coordinate,x
IniRead,y2,%A_Temp%\ALSD.ini,Password Coordinate,y
GuiControl,,Pass,%x2% %y2%

IniRead,DelayperLogin,%A_Temp%\ALSD.ini,Settings,Delay Per Login
GuiControl,,DelayperLogin,%DelayperLogin%

IniRead,GTFILEPATH,%A_Temp%\ALSD.ini,Growtopia File Path,Path
GuiControl,,GTFILE,%GTFILEPATH%

counter:=1
Loop{
	IniRead,tempusername,%A_Temp%\ALSD.ini,Accounts,username %counter%	
	IniRead,temppassword,%A_Temp%\ALSD.ini,Accounts,password %counter%	
	if (tempusername!="ERROR" or username!=""){
	LV_Add(,tempusername,temppassword)
	}else {
		break
	}
	counter++
}


GUI,SUbmit,NoHide


return


SetDefault:
FileDelete,%A_Temp%\ALSD.ini
IniWrite,%x1%,%A_Temp%\ALSD.ini,GrowID Coordinate,x
IniWrite,%y1%,%A_Temp%\ALSD.ini,GrowID Coordinate,y
IniWrite,%x2%,%A_Temp%\ALSD.ini,Password Coordinate,x
IniWrite,%y2%,%A_Temp%\ALSD.ini,Password Coordinate,y
IniWrite,%GTFILE%,%A_Temp%\ALSD.ini,Growtopia File Path,Path
IniWrite,%DelayPerLogin%,%A_Temp%\ALSD.ini,Settings,Delay Per Login
Gui,ListView,AccountList
usernamecount:=LV_GetCount()


counter:=1
loop,%usernamecount%{
	LV_GetText(Data,A_Index, 1)
	IniWrite,%Data%,%A_Temp%\ALSD.ini,Accounts,username %counter%
	counter++
}

counter:=1
loop,%usernamecount%{
	LV_GetText(Data,A_Index, 2)
	IniWrite,%Data%,%A_Temp%\ALSD.ini,Accounts,password %counter%
	counter++
}


return




AddAccount:
Gui,Submit,NoHide
Gui,ListView,AccountList
usernamecount:=LV_GetCount()
LV_Add(,username,password)
Gui,Submit,NoHide
return

LVupdate:
RowNumber := LV_GetNext(,"F")
return



DeleteSelected:
RowNumber := LV_GetNext(,"F")
LV_Delete(RowNumber)
Gui,Submit,NoHide

return


ShowPass2:
if (showpass==1){
	GuiControl,,showpass,0
	GuiControl,+Password,password
}else{
	GuiControl,,showpass,1
	GuiControl,-Password,password
}
Gui,Submit,NoHide

return


ShowPass:
Gui,Submit,NoHide
if (showpass==1){
	GuiControl,-Password,password
}else {
	GuiControl,+Password,password
}

return
Update:
Gui,Submit,Nohide
return


Target1:
Set_POsition(x1,y1)
GuiControl,,ID,%x1% %y1%
return

Target2:
Set_POsition1(x2,y2)
GuiControl,,PASS,%x2% %y2%
return

Set_Position(Byref X,Byref Y)
{
	i := 0
	k := 0
	loop {
		Click := GetKeyState("Lbutton")
		tooltip,Click 2 times to Grow ID
		if (Click == False && k == 0)
		k := 1
		else if (Click == True && k == 1)
		{
		MouseGetPOs,x,y,
		tooltip,
		break
		{
}
}
}
Return TArget_Window
}


Set_Position1(Byref X,Byref Y)
{
	i := 0
	k := 0
	loop {
		Click := GetKeyState("Lbutton")
		tooltip,Click 2 times to PASSWORD
		if (Click == False && k == 0)
		k := 1
		else if (Click == True && k == 1)
		{
		MouseGetPOs,x,y,
		tooltip,
		break
		{
}
}
}
Return TArget_Window
}

label1:

Gui,ListView,AccountList
ListRows := LV_GetCount()
counter :=1
Loop, %ListRows%
{
	LV_GetText(Data,A_Index, 1)
	username%counter%:=Data
	counter++
}

counter :=1
Loop, %ListRows%
{
	LV_GetText(Data,A_Index, 2)
	password%counter%:=Data
	counter++
}




counter:=1
loop,%ListRows%{
thePID=GrowtopiaPID%counter%
Run,Growtopia,%gtfile%,,thePID
WinWait,ahk_pid %thePID%
WinSetTitle,ahk_pid %thePID%,,Growtopia %counter%
sleep,1000
ControlSend,,{Enter},ahk_pid %thePID%
sleep,1500
ControlClick,,Ahk_Pid %thePID%,,,, NA x%x1% y%y1%
sleep,100
ControlSend,,% username%counter%,ahk_pid %thePID%
sleep,200
ControlClick,,Ahk_Pid %thePID%,,,, NA x%x2% y%y2%
sleep,100
ControlSend,,% password%counter%,ahk_pid %thePID%
sleep,1200
ControlSend,,{Enter},ahk_pid %thePID%
counter++
sleep,%DelayPerLogin%
}

return




GuiClose:
ExitApp
return