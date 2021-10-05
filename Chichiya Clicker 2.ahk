Suspend,On
CoordMode,Mouse,client
#SingleInstance,Off
counterxxx:=1
;SetTimer,timertest,On
;SetTimer,loop2,On



;Gui,Add,Picture,x0 y0,Images\Chichiya.png
Gui,Add,Edit,x10 y10 w120 h20 vwindow1
Gui,Add,Button,x+5 w60 h20 gSetClicker1,Set Win 
Gui,Add,ListView,col3 x10 y+5 w185 r10 vlistview1,x|y|Delay
Gui,ADd,button,x+5 y10 h30 w60 vbutton1,Set Coordinate
Gui,Add,Button,y+5 h33 w60 gHideClicker1,Hide
Gui,Add,Button,y+5 h33 w60 gShowClicker1,Show
Gui,Add,Button,y+5 h33 w60 gDelete,Delete
Gui,Add,Button,y+5 h33 w60 gClicker1,Start
Gui,Add,Button,y+5 h34 w60 gStopClicker1,Stop
LV_ModifyCol(1,61)
LV_ModifyCol(2,61)
LV_ModifyCol(3,61)
Gui,Color,009AE4
gUI,adD,sTATUSbar
SB_SetText("2020 Chichiya Automation Copyright Reserved.")
Gui,Show,,Chichiya Clicker 2
testfunction:=Func("Set_coord").Bind("listview1")
GuiControl,+g,button1,% testfunction
return

HideClicker1:
WinHide,ahk_pid %window1%
return

ShowClicker1:
WinShow,ahk_pid %window1%
return

BringToFrontClicker1:
WinActivate,ahk_pid %window1%
return

delete:
LV_DeleteSelectedRows("listview1")  ; Deletes selected rows and returns number of deleted rows. by Learning one
return

StopClicker1:
SetTimer,StartClicker1,Off
return

SetClicker1:
Target_Window:=Set_Window(Target_Window)
GuiControl,,Window1, % Target_Window
Gui,Submit,NoHide
return

Clicker1:
	Clicker1counter :=1
	Gui,ListView,listview1
	Clicker1Rows := LV_GetCount()
	;msgbox,%Rows%
	Loop, %Clicker1Rows%
	{
		LV_GetText(Data,A_Index, 1)
        Clicker1X%Clicker1counter%:=Data
		Clicker1Counter++
	}
	Clicker1counter :=1
	Loop, %Clicker1Rows%
	{
		LV_GetText(Data,A_Index, 2)
        Clicker1Y%Clicker1counter%:=Data
		Clicker1counter++
	}
	Clicker1counter :=1
	Loop, %Clicker1Rows%
	{
		LV_GetText(Data,A_Index, 3)
        Clicker1Delay%Clicker1counter%:=Data
		Clicker1counter++
		
	}
	
	Clicker1counter:=1
	SetTimer,StartClicker1,1

return





StartClicker1:
clicker1x:=Clicker1X%Clicker1counter%
clicker1y:=Clicker1Y%Clicker1counter%
clicker1delay:=Clicker1Delay%Clicker1counter%
ControlClick,,ahk_pid %window1%,,Left,,X%clicker1x% Y%clicker1y% NA
sleep,Clicker1Delay%Clicker1counter%


Clicker1counter++
if(Clicker1counter>Clicker1Rows){
	;msgbox,done
	Clicker1Counter:=1
}

return




Set_Coord(value){
	Gui,ListView,%value%
	LV_Delete()
	isPressed:=0,i:=0
	Loop{
		LeftMouse:=GetKeyState("LButton")
		WinGetTitle,Temp_Window,A
		ToolTip,Left Click on the target window twice to set `n`n Current Window: %Temp_Window%
		if(LeftMouse==False&&isPressed==0)
		isPressed:=1
		else if(LeftMouse==True&&isPressed==1)
		{
			i++,isPressed:=0
			if(i>=2)
			{
				MouseGetPos,%value%x,%value%Y
				Winget,lastpid,pid,A
				SetBatchLines,-1
				CoordMode,Mouse,Screen
				MouseGetPos,MouseX,MouseY
				CoordMode,Mouse,Client
				ToolTip,
				;delayvar=%value%delay
				Gui +LastFound +OwnDialogs 
				winactivate,auto clicker 2
				;Mousemove,0,0
				;BlockInput,MouseMove
				
				Inputbox,%value%delay,Prompt,Do you want to add another Coordinate?`nDelay after the click,,200,200,,,,,100
				wingetpos,promptx,prompty,promptw,prompth,prompt
				If ErrorLevel
				{
					Gui,ListView,%value%
					LV_Add(,%value%X,%value%Y,%value%delay)
					CoordMode,Mouse,Screen
					MouseMove,MouseX,MouseY
					CoordMode,Mouse,Client
					SetBatchLines,10
					;BlockInput,MouseMoveOff
					WinActivate,ahk_pid %lastpid%
					break
				}else {
					Gui,ListView,%value%
					LV_Add(,%value%X,%value%Y,%value%delay)
					CoordMode,Mouse,Screen
					MouseMove,MouseX,MouseY
					CoordMode,Mouse,Client
					SetBatchLines,10
					;BlockInput,MouseMoveOff
					WinActivate,ahk_pid %lastpid%
				}

			}
		}
	}
	return Target_Window
	}

Set_Window(Target_Window)
{
isPressed:=0,i:=0
Loop
{
Left_Mouse:=GetKeyState("LButton")
WinGetTitle,Temp_Window,A
ToolTip,Left Click on the target window twice to set `n`n Current Window: %Temp_Temp%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if (i>2)
{
Winget,Target_Window,pid,A
ToolTip,
break
}
}
}
return Target_Window
}

GuiClose(){
msgbox,260,Prompt,Are you sure you want to Exit Chichiya?`n
	IfMsgBox, Yes
		ExitApp

	
	
}

LV_DeleteSelectedRows(listviewname) { ; Deletes selected rows and returns number of deleted rows. by Learning one
   global
   Gui,ListView,%listviewname%
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