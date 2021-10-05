#SingleInstance,Force
DetectHiddenWindows,On
CoordMode,Mouse,Client

Gui,Main:Add,Button,x10 y10 w50 h30 gSetWindow,Set Window
Gui,Main:Font,s12
Gui,Main:Add,Edit,x+0 w55 h30 vwinpid
Gui,Main:FOnt
Gui,Main:Add,Button,x10 y330 w105 h30 gRemove,Remove
Gui,Main:Add,Button,x10 y45 w105 h30 gSetOvens,Set Ovens
Gui,Main:Add,ListView,y+5 w105 h240 vOvenList,x|y
Gui,Main:Add,Button,x+5 y10 w75 h30 gsetflour,Set Flour
Gui,Main:Add,Button,y+10 w75 h30 gSetEgg,Set Egg
Gui,Main:Add,Button,y+10 w75 h30 gSetMilk,Set Milk
Gui,Main:Add,Button,y+10 w75 h30 gSetBlueberry,Set Blueberry
Gui,Main:Add,Button,y+10 w75 h30 gSetSugar,Set Sugar (Optional)
Gui,Main:Add,Button,y+10 w75 h30 gSetFist,Set Fist
Gui,Main:Add,Button,y+10 w75 h30 gSetLowButton,Set Low Button
Gui,Main:Add,Button,y+10 w75 h30 gSetCharacter,Set Character
Gui,Main:Font,s12
Gui,Main:Add,Edit,x+5 y10 w100 h30 Center vflouredit
Gui,Main:Add,Edit,y+10 w100 h30 Center veggedit
Gui,Main:Add,Edit,y+10 w100 h30 Center vmilkedit
Gui,Main:Add,Edit,y+10 w100 h30 Center vblueberryedit
Gui,Main:Add,Edit,y+10 w100 h30 Center vsugaredit
Gui,Main:Add,Edit,y+10 w100 h30 Center vfistedit
Gui,Main:Add,Edit,y+10 w100 h30 Center vlowbuttonedit
Gui,Main:Add,Edit,y+10 w100 h30 Center vcharacteredit
Gui,Main:Font
Gui,Main:Add,Button,x+5 y10 w40 h30 gClearFLour,Clear
Gui,Main:Add,Button,y+10 w40 h30 gClearEgg,Clear
Gui,Main:Add,Button,y+10 w40 h30 gClearMilk,Clear
Gui,Main:Add,Button,y+10 w40 h30 gClearBlueberry,Clear
Gui,Main:Add,Button,y+10 w40 h30 gClearSugar,Clear
Gui,Main:Add,Button,y+10 w40 h30 gClearFist,Clear
Gui,Main:Add,Button,y+10 w40 h30 gClearLowButton,Clear
Gui,Main:Add,Button,y+10 w40 h30 gClearCharacter,Clear

Gui,Main:Add,Button,x10 y+10 w105 h40 gStart vStartButton,Start
Gui,Main:Add,Button,x+10 w105 h40 gHideOrShow,Hide/Show
Gui,Main:Add,Button,x+10 w105 h40 gHelp,Help
Gui,Main:Add,Button,y+10 x10 w105 h40 gStop vStopButton Disabled,Stop
Gui,Main:Add,Button,x+10 w105 h40 gSettings,Settings
Gui,Main:Add,Button,x+10 w105 h40 greload,Reload
Gui,Main:Add,Text,x10 y+10 vTimer,Timer`:0`            `
Gui,Main:default
LV_ModifyCol(1,50)
LV_ModifyCol(2,50)

Gui,Main:Color,009AE4
Gui,Main:Show,,Auto Cook Berry Crepe



Gui,Settings:Add,Groupbox,x10 y10 w220 h140,Delays
Gui,Settings:Add,Text,x20 y30, Delay when opening and closing Oven
Gui,Settings:Add,Edit,y+5 x20 w120 h25 Number Limit6 vovendelay gUpdater,2000
Gui,Settings:Add,Text,x20 y+20, Delay when putting ingredients to the oven
Gui,Settings:Add,Edit,y+5 x20 w120 h25 Number Limit6 vingredientdelay gUpdater,500

Gui,Settings:Add,Groupbox,x10 y+20 w220 h50,Loops
Gui,Settings:Add,Edit,x20 y175 w60 h20 vLoopCount gUpdateLoop Number,0
Gui,Settings:Add,UpDown,gUpdateLoop
Gui,Settings:Add,Text,x+10,0 = infinite

Gui,Settings:Color,FFB6C1
Gui,Settings:Submit,NoHide










return

Help:
return


UpdateLoop:
Gui,Settings:Submit,NoHide
if (LoopCount==0){
	LoopCount:=99999999999
}

return



Updater:
Gui,Settings:Submit,NoHide
return


MainGuiClose:
ExitApp
return


SettingsGUIClose:
Gui,Settings:Cancel
Gui,Main:-Disabled 
Gui,Main:Show
return


Settings:
Gui,Settings: +ownerMain +AlwaysOnTop 
Gui,Main:+Disabled
Gui,Settings:Show,,Settings

return


Remove:
LV_DeleteSelectedRows("OvenList")
return


ClearLowButton:
LowButtonX:=
LowButtonY:=
GuiControl,,LowButtonEdit
return


ClearFist:
FistX:=
FistY:=
GuiControl,,FistEdit,

return


ClearSugar:
SugarX:=
SugarY:=
GuiControl,,SugarEdit,
return



ClearBlueberry:
BlueBerryX:=
BlueBerryY:=
GuiControl,,BlueberryEdit,
return



ClearMilk:
MilkX:=
MilkY:=
GuiControl,,MilkEdit,

return


ClearEgg:
EggX:=
EggY:=
GuiControl,,EggEdit,
return

ClearFlour:
FlourX:=
FlourY:=
GuiControl,,FlourEdit,

return



return

ClearCharacter:
CharacterX:=
CharacterY:=
GuiControl,,CharacterEdit,

return




UpdateTimer:
ElapsedTimer:=A_TickCount - StartTime
GuiControl,Main:,Timer,Timer`:%ElapsedTimer%
return


Sound:
SoundBeep, 900, 200
return


Reload:
Reload
return

Stop:
Stop:=true
tooltip,stopping... please wait.
sleep,2000
tooltip,
GuiControl,Enable,StartButton
GuiControl,Disable,StopButton
return


Start:

GuiControl,Enable,StopButton
GuiControl,Disable,StartButton
stop:=false
OvenCounter :=1
Gui,Main:ListView,OvenList
OvenRows := LV_GetCount()
;msgbox,%Rows%
Loop, %OvenRows%
{
	LV_GetText(Data,A_Index, 1)
	OvenX%OvenCounter%:=Data
	OvenCounter++
}
OvenCounter :=1
Loop, %OvenRows%
{
	LV_GetText(Data,A_Index, 2)
	OvenY%OvenCounter%:=Data
	OvenCounter++
}



loop,%LoopCOunt%{
	


counter:=1
loop,%OvenRows%{	; Add Flour to Ovens
	Xcoord:=OvenX%counter%
	Ycoord:=OvenY%counter%
	if not stop{
		SendClick(FlourX,FlourY,winpid)	;Click on Flour
	}else {
		goto,stopper
	}
	sleep,50
	if not stop {
		SendClick(Xcoord,Ycoord,winpid)	;Click on Oven
	}else {
		goto,stopper
	}
	sleep,%ovendelay%
	if not stop {
		SendClick(LowButtonX,LowButtonY,winpid)	;Click on Low Button
	}else {
		goto,stopper
	}
	sleep,%ovendelay%
	counter++
}

/*
loop{	;Wait for Timer to reach 30.5sec
	ElapsedTime := A_TickCount - StartTime
	if not stop{
		if (ElapsedTime>26500){
			break
		}
	}else{
		goto,stopper
	}
}
*/

counter:=1
SendClick(EggX,EggY,winpid)	;Click on Egg
sleep,50
StartTime:=A_TickCount	;Start Timer 
setTimer,UpdateTimer,1
loop,%OvenRows%{	; Add Eggs to Ovens
	Xcoord:=OvenX%counter%
	Ycoord:=OvenY%counter%
	if not stop{
		SendClick(Xcoord,Ycoord,winpid)	;Click on Oven
	}else {
		goto,stopper
	}
	sleep,%ingredientdelay%
	counter++
}


loop{	;Wait for Timer to reach 26.5sec
	ElapsedTime := A_TickCount - StartTime
	if not stop{
		if (ElapsedTime>26500){
			break
		}
	}else{
		goto,stopper
	}
}

counter:=1
SendClick(MilkX,MilkY,winpid)	;Click on Milk
sleep,50
loop,%OvenRows%{	; Add Milk to Ovens
	Xcoord:=OvenX%counter%
	Ycoord:=OvenY%counter%
	if not stop{
		SendClick(Xcoord,Ycoord,winpid)	;Click on Oven
	}else{
		goto,stopper
	}
	sleep,%ingredientdelay%
	counter++
}


loop{	;Wait for Timer to reach 40sec
	ElapsedTime := A_TickCount - StartTime
	if not stop{
		if (ElapsedTime>39900){
			break
		}
	}else{
		goto,stopper
	}
	
}


counter:=1
SendClick(BlueberryX,BlueberryY,winpid)	;Click on Blueberry
sleep,50
loop,%OvenRows%{	; Add Blueberry to Ovens
	Xcoord:=OvenX%counter%
	Ycoord:=OvenY%counter%
	if not stop{
		SendClick(Xcoord,Ycoord,winpid)	;Click on Oven
	}else {
		goto,stopper
	}
	sleep,%ingredientdelay%
	counter++
}


if (SugarX!=""){
	counter:=1
	SendClick(SugarX,SugarY,winpid)	;Click on Sugar
	sleep,50
	loop,%OvenRows%{	; Add Eggs to Ovens
		Xcoord:=OvenX%counter%
		Ycoord:=OvenY%counter%
		if not stop{
			SendClick(Xcoord,Ycoord,winpid)	;Click on Oven
		}else{
			goto,stopper
		}
		sleep,%ingredientdelay%
		if not stop{
			SendClick(Xcoord,Ycoord,winpid)	;Click on Oven second time
		}else{
			goto,stopper
		}
		sleep,%ingredientdelay%
		counter++
	}	
}



loop{	;Wait for Timer to reach 60sec
	ElapsedTime := A_TickCount - StartTime
	if not stop{
		if (ElapsedTime>59900){
			break
		}
	}else{
		goto,stopper
	}
}


counter:=1
SendClick(FistX,FistY,winpid)	;Click on Fist
sleep,50
loop,%OvenRows%{	; Add Eggs to Ovens
	Xcoord:=OvenX%counter%
	Ycoord:=OvenY%counter%
	if not stop{
		SendClick(Xcoord,Ycoord,winpid)	;Click on Oven
	}else{
			goto,stopper
	}
	sleep,%ingredientdelay%
	counter++
}

SetTimer,UpdateTimer,Off
GuiControl,Main:,Timer,Timer:0
sleep,500
}
return


stopper:
SetTimer,UpdateTimer,Off
GuiControl,,Timer,Timer:0


return






















HideOrShow:
if (windowstatus=="Hidden"){
	WinShow,ahk_pid %winpid%
	windowstatus=Visible
}else {
	WinHide,ahk_pid %winpid%
	windowstatus=Hidden
}
	
return



SetLowButton:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	MouseGetPos,TempX,TempY
	ToolTip,Low Button`n`nLeft Click on the Low Button twice to set `n`n Coordinate: %TempX%`,%TempY%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			MouseGetPos,LowButtonX,LowButtonY
			GuiControl,,LowButtonEdit,%LowButtonX%`,%LowButtonY%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return


SetFist:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	MouseGetPos,TempX,TempY
	ToolTip,Fist`n`nLeft Click on the Fist twice to set `n`n Coordinate: %TempX%`,%TempY%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			MouseGetPos,FistX,FistY
			GuiControl,,FistEdit,%FistX%`,%FistY%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return



SetCharacter:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	MouseGetPos,TempX,TempY
	ToolTip,Character`n`nLeft Click on the Character twice to set `n`n Coordinate: %TempX%`,%TempY%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			MouseGetPos,CharacterX,CharacterY
			GuiControl,,CharacterEdit,%CharacterX%`,%CharacterY%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return




SetSugar:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	MouseGetPos,TempX,TempY
	ToolTip,Sugar`n`nLeft Click on the Sugar twice to set `n`n Coordinate: %TempX%`,%TempY%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			MouseGetPos,SugarX,SugarY
			GuiControl,,SugarEdit,%SugarX%`,%SugarY%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return



SetBlueberry:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	MouseGetPos,TempX,TempY
	ToolTip,Blueberry`n`nLeft Click on the Blueberry twice to set `n`n Coordinate: %TempX%`,%TempY%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			MouseGetPos,BlueBerryX,BlueBerryY
			GuiControl,,BlueberryEdit,%BlueBerryX%`,%BlueBerryY%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return



SetMilk:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	MouseGetPos,TempX,TempY
	ToolTip,Milk`n`nLeft Click on the Milk twice to set `n`n Coordinate: %TempX%`,%TempY%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			MouseGetPos,MilkX,MilkY
			GuiControl,,MilkEdit,%MilkX%`,%MilkY%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return



SetEgg:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	MouseGetPos,TempX,TempY
	ToolTip,Egg`n`nLeft Click on the Egg twice to set `n`n Coordinate: %TempX%`,%TempY%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			MouseGetPos,EggX,EggY
			GuiControl,,EggEdit,%EggX%`,%EggY%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return




SetFlour:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	MouseGetPos,TempX,TempY
	ToolTip,Flour`n`nLeft Click on the Flour twice to set `n`n Coordinate: %TempX%`,%TempY%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			MouseGetPos,FlourX,FlourY
			GuiControl,,FlourEdit,%FlourX%`,%FlourY%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return









SetWindow:
isPressed:=0,i:= 0
Loop
{
	Left_Mouse:=GetKeyState("LButton")
	WinGetTitle,tempwindow,A
	ToolTip,Left Click on the target window twice to set `n`n Current Window: %tempwindow%
	if(Left_Mouse==False&&isPressed==0)
	isPressed:=1
	else if(Left_Mouse==True&&isPressed==1)
	{
		i++,isPressed:=0
		if(i>=2)
		{
			WinGet,windowpid,pid,A
			GuiControl,,winpid,%windowpid%
			Gui,Main:Submit,NoHide
			ToolTip,
			break
		}
	}
}

return

SetOvens:
Inputbox,HowManyOven,How Many Oven,How many oven do you want to use`? `(1-15)
If (HowManyOven<16){
	loop,%HowManyOven%{
		AddCoordinateXY("OvenList")
	}
}else {
	msgbox,,Prompt,You can not use more than 15 ovens.
}
return



AddCoordinateXY(NameOfListView){
	Gui,MainGUI:ListView,%NameOfListView%
	isPressed:=0,i:= 0
	Loop
	{
		Left_Mouse:=GetKeyState("LButton")
		MouseGetPos,TempX,TempY
		ToolTip,Click twice to set Coordinates`.`n%TempX%`,%TempY%
		if(Left_Mouse==False&&isPressed==0)
		isPressed:=1
		else if(Left_Mouse==True&&isPressed==1)
		{
			i++,isPressed:=0
			if(i>=2)
			{
				MouseGetPos,TempX,TempY
				LV_Add(,TempX,TempY)
				tooltip,
				break
			}
		}
		
	 }
     Gui,MainGUI:Submit,NoHide
		
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



SendClick(X,Y,pid){
ControlClick,,ahk_pid %pid%,,Left,,X%X% Y%Y% NA	
	
return
}
return