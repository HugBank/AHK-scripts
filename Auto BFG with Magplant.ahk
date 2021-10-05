#SingleInstance,Off
CoordMode,Mouse,Client


Gui,Add,Button,x10 y10 w80 h30 gAddWindow,Add Window
Gui,Add,ListView,y+5 w80 r6 vPIDListView,PID
Gui,Add,Button,y+5 w80 h29 gPIDDelete,Delete
Gui,Add,Button,x+5 y10 w80 h29,
Gui,Add,Button,y+5 w80 h29 gShow,Show
Gui,Add,Button,y+5 w80 h29 gHIde,Hide
Gui,Add,Text,y+5,Hit Count
Gui,Add,Edit,y+5 w80 h25 gUpdate -VScroll Number Limit3 vHitCount,4
Gui,Add,UpDown,gUpdate Range1-999,4
Gui,Add,Text,y+8,Delay Per Hit
Gui,Add,Edit,y+5 w80 h25 gUpdate -VScroll Number Limit5 vDelayPerHit,200
Gui,Add,UpDown,gUpdate Range1-99999,200
Gui,Add,Button,x+10 y10 w80 h30 gAddCoord,Add Coordinates
Gui,Add,ListView,y+5 w80 r6 vCoordListView,x|y
Gui,SUbmit,NOHide
LV_ModifyCol(1,38)
LV_ModifyCol(2,38)
Gui,Add,Button,y+5 w80 h29 gCoordDelete,Delete

Gui,Add,Button,y+5 x10 w60 h30 gSetFist,Set Fist
Gui,Font,s12
Gui,Add,Edit,x+5 w60 h30 vFistEdit,
Gui,Font,
Gui,Add,Button,x+5 w60 h30 gSetBlock,Set Block
Gui,Font,s12
Gui,Add,Edit,x+5 w60 h30 vBlockEdit,
Gui,Font,



Gui,Add,Button,y+10 x13 w80 h35 gShowAll,Show All
Gui,Add,Button,x+5 w80 h35 gHideAll,Hide All
Gui,Add,Button,x+5 w80 h35 gCloseAll,Close All
Gui,Add,Button,y+5 x13 w80 h35 gStart,Start
Gui,Add,Button,x+5 w80 h35 gTutorial,Tutorial
Gui,Add,Button,x+5 w80 h35 gStopper,Stop

Gui,Add,StatusBar
SB_SetText("Copyright Chichiya Team. All rights reserved.",1)
Gui,Color,009AE4
Gui,Show,,Auto BFG (Magplant)
Gui,Submit,Nohide
return


Tutorial:
run,https://www.youtube.com/watch?v=m1gvbHy8i-c

return


GuiClose:
gosub,ShowAll
ExitApp
return

Update:
Gui,Submit,NOhide
return


Stopper:
;GuiControl,Enable,StartButton
;GuiControl,Disable,StopButton
Stop:=true

return


Start:
Stop:=false
Gui,ListView,PIDListView
PIDCount:=LV_GetCount()
counter:=1
loop, % LV_GetCount()
{
    LV_GetText(window%counter%, A_Index)
	counter++
}

Gui,ListView,CoordListView
CoordinateCount:=LV_GetCount()
counter:=1
loop, % LV_GetCount()
{
	LV_GetText(x%counter%,A_Index,1)
	LV_GetText(y%counter%,A_Index,2)
	counter++
}


Loop{
	;Click on Block
	counter:=1
	loop %PIDCount%{
		window:=window%counter%
		ControlClick,,ahk_pid %window%,,Left,1,X%BlockX% Y%BlockY% NA
		counter++
	}
	sleep,50
	;End Click On Block
	
	
	;Place Blocks
	counter:=1
	loop,%CoordinateCount%{
		pidcounter:=1
		loop, %PIDCount%{
			window:=window%pidcounter%
			if not stop 
			{
				x:=x%counter%
				y:=y%counter%
				ControlClick,,ahk_pid %window%,,Left,1,X%x% Y%y% NA
			}else {
				return
			}
			pidcounter++
		}
		sleep,100
		counter++
	}
	;Stop Placing Blocks
	
	
	;Click on Fist
	counter:=1
	loop %PIDCount%{
		window:=window%counter%
		ControlClick,,ahk_pid %window%,,Left,1,X%FistX% Y%FistY% NA
		counter++
	}
	sleep,50
	;End Click On Fist
	
	
	;Hold Down The Blocks
	sleepvalue:=Hitcount*DelayperHit
	counter:=1
	loop,%coordinatecount%{
		pidcounter:=1
		
		loop,%PIDCOunt%
		{
			window:=window%pidcounter%
			if not stop{
				x:=x%counter%
				y:=y%counter%
				ControlClick,,ahk_pid %window%,,Left,1,X%x% Y%y% NA D
			}else {
				goto,releaser
			}
			pidcounter++
		}
		Timer:=A_TickCount
		
		loop{
			Elapsed:=A_TickCount-Timer
			if (Elapsed>sleepvalue){
				break
			}else {
			if stop {
				goto,releaser
			}
			}
		}
		counter2:=1
		loop,%coordinatecount%{
			pidcounter2:=1
			
			loop,%PIDCOunt%
			{
				window:=window%pidcounter2%
				x:=x%counter2%
				y:=y%counter2%
				ControlClick,,ahk_pid %window%,,Left,1,X%x% Y%y% NA U
				pidcounter2++
			}

			counter2++
		}
		
		counter++
	}
	;End Hold Down Blocks
	
	
	;Release Holds
	releaser:
	counter:=1
	loop,%coordinatecount%{
		pidcounter:=1
		
		loop,%PIDCOunt%
		{
			window:=window%pidcounter%
			x:=x%counter%
			y:=y%counter%
			ControlClick,,ahk_pid %window%,,Left,1,X%x% Y%y% NA U
			pidcounter++
		}

		counter++
	}
	;End Release Holds
	
	
	
	
}




return
















CloseALl:
Gui,ListView,PIDListView
Loop % LV_GetCount()
{
	LV_GetText(RetrievedText, A_Index)
	WinClose,ahk_pid %RetrievedText%
}
LV_Delete()
return


HideAll:
Gui,ListView,PIDListView
Loop % LV_GetCount()
{
	LV_GetText(RetrievedText, A_Index)
	WinHide,ahk_pid %RetrievedText%
}
return

ShowAll:
Gui,ListView,PIDListView
Loop % LV_GetCount()
{
	LV_GetText(RetrievedText, A_Index)
	WinShow,ahk_pid %RetrievedText%
}
return



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
return SelectedRowsCount
}
}




CoordDelete:
Gui,Submit,NoHide
LV_DeleteSelectedRows("CoordListView")
return

PIDDelete:
Gui,Submit,NoHide
LV_DeleteSelectedRows("PIDListView")

return

Show:
RowNumber := LV_GetNext(,"F")
LV_GetText(PIDToShow,RowNumber,1)
WinShow,ahk_pid %PIDToShow%
WinActivate,ahk_pid %PIDtoSHow%
return
Hide:
RowNumber := LV_GetNext(,"F")
LV_GetText(PIDToHide,RowNumber,1)
WinHide,ahk_pid %PIDToHide%
return

AddCoord:
isPressed:=0,i:=0
Loop
{
Left_Mouse:=GetKeyState("LButton")
MouseGetPos,TempX,TempY
ToolTip,Left Click on the target twice to set `n`n Current Coordinate: %TempX%`,%TempY%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if (i>2)
{
MouseGetPos,TempX2,TempY2
ToolTip,
Gui,ListView,CoordListView
LV_Add(,TempX2,TempY2)
break
}
}
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
Gui,ListView,PIDListView
LV_Add(,Target_Window)
break
}
}
}
return



SetFist:
isPressed:=0,i:=0
Loop
{
Left_Mouse:=GetKeyState("LButton")
MouseGetPos,TempX,TempY
ToolTip,Left Click on the Fist twice to set `n`n Current Coordinate: %TempX%`,%TempY%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if (i>2)
{
MouseGetPos,FistX,FistY
ToolTip,
GuiControl,,FistEdit,%FistX%`, %FistY%
break
}
}
}
return


SetBlock:
isPressed:=0,i:=0
Loop
{
Left_Mouse:=GetKeyState("LButton")
MouseGetPos,TempX,TempY
ToolTip,Left Click on the Block twice to set `n`n Current Coordinate: %TempX%`,%TempY%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if (i>2)
{
MouseGetPos,BlockX,BlockY
ToolTip,
GuiControl,,BlockEdit,%BlockX%`, %BlockY%
break
}
}
}
return