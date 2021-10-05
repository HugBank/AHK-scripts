#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance,Force
CoordMode,Mouse,Client
DetectHiddenWindows,On

Gui,Add,Listview,x10 y10 w100 r7 Grid vWindow,Window PID
Gui,Add,Button,x+5 w100 h33 gAddWindow,Add Window
Gui,Add,Button,y+5 w100 h33 gHide,Hide
Gui,Add,Button,y+5 w100 h33 gShow,Show
Gui,Add,Button,y+5 w100 h33 gDelete,Delete

Gui,Add,Button,x218 y10 w100 h33 gHideAll,Hide All
Gui,Add,Button,y+5 w100 h33 gShowAll,Show All
Gui,Add,Button,y+5 w100 h33 gDeleteAll,Delete All
Gui,Add,Button,y+5 w100 h33 gCloseAll,Close All

Gui,Add,Button,x10 y170 w80 h25 gBlock,Block
Gui,Font,s10
Gui,Add,Edit,x+5 w65 h25 Center number vBlock,
Gui,Font,

Gui,Add,Button,x10 y200 w80 h25 gFist,Fist
Gui,Font,s10
Gui,Add,Edit,x+5 w65 h25 Center number vFist,
Gui,Font,

Gui,Add,Button,x10 y230 w80 h25 gSeed,Seed
Gui,Font,s10
Gui,Add,Edit,x+5 w65 h25 Center number vSeed,
Gui,Font,

Gui,Add,Button,x10 y260 w80 h25 gCharacter,Character
Gui,Font,s10
Gui,Add,Edit,x+5 w65 h25 Center number vCharacter,
Gui,Font,


Gui,Add,Button,x168 y170 w80 h25 gPlace1,Place 1
Gui,Font,s10
Gui,Add,Edit,x+5 w65 h25 Center number vPlace1,
Gui,Font,

Gui,Add,Button,x168 y200 w80 h25 gPlace2,Place 2
Gui,Font,s10
Gui,Add,Edit,x+5 w65 h25 Center number vPlace2,
Gui,Font,

Gui,Add,Button,x168 y230 w80 h25 gFissure,Fissure
Gui,Font,s10
Gui,Add,Edit,x+5 w65 h25 Center number vFissure,
Gui,Font,

Gui,Add,Button,x168 y260 w80 h25 gDrop,Drop
Gui,Font,s10
Gui,Add,Edit,x+5 w65 h25 Center number vDrop,
Gui,Font,

Gui,Font,bold
Gui,Add,Text,x10 y310 w100 h25,Estimated Block:
Gui,Font,
Gui,Font,s10
Gui,Add,Edit,x115 y305 w50 h25 r1 number vEstimatedBlock gUpdate,150
Gui,Add,UpDown,Range1-100 gUpdate,150
Gui,Font,

Gui,Font,bold
Gui,Add,Text,x190 y310 w100 h25,Delay Walk:
Gui,Font,
Gui,Font,s10
Gui,Add,Edit,x268 y305 w50 h25 vDelayWalk gUpdate,6000
Gui,Font,

Gui,Font,bold
Gui,Add,Text,x10 y355 w100 h25,Looping to Drop:
Gui,Font,
Gui,Font,s10
Gui,Add,Edit,x115 y350 w50 h25 r1 number vLooping gUpdate,2
Gui,Add,UpDown,Range1-10 gUpdate,2
Gui,Font

Gui,Font,bold
Gui,Add,Text,x200 y355 w100 h25,HitCount:
Gui,Font,
Gui,Font,s10
Gui,Add,Edit,x268 y350 w50 h25 r1 number vHitCount gUpdate,2
Gui,Add,UpDown,Range1-20 gUpdate,2
Gui,Font

Gui,Add,Button,x10 y380 w100 h35 vStartButton gStart,Start
Gui,Add,Button,x+5 w100 h35
Gui,Add,Button,x+5 w100 h35
Gui,Add,Button,x10 y+10 w100 h35 vStopButton gStop,Stop
Gui,Add,Button,x+5 w100 h35 gTutorial,Tutorial
Gui,Add,Button,x+5 w100 h35 gReload,Reload

Gui,Show,h490,Basic Seeds Farm
Gui,Add,StatusBar
SB_SetText("Copyright Chichiya Automation. All rights reserved.",1)
Gui,Color,009AE4
Gui,Submit,Nohide
return

Tutorial:
run,https://www.youtube.com/watch?v=8c1BOY22pQI&t=228s
return

Update:
Gui,Submit,NOhide
return

Reload:
MsgBox,4,Reload,Are you sure you want to reload the program?
IfMsgBox,Yes
{
Reload
}
return

GuiClose:
msgbox,4,Exit App,Are you sure you want to exit the program?
ifmsgbox,Yes
{
ExitApp
}
return

DeleteAll:
msgbox,4,Delete,Are you sure you want to delete all PID?
ifmsgbox,Yes
{
Gui,Listview,Window
LV_Delete()
} else {
return
}
return

Delete:
Gui,Listview,Window
RowNumber := LV_GetNext(,"F")
LV_GetText(Text,RowNumber,1)
LV_Delete(RowNumber)
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

HideAll:
Gui,ListView,Window
Loop % LV_GetCount()
{
	LV_GetText(RetrievedText, A_Index)
	WinHide,ahk_pid %RetrievedText%
}
return

Hide:
RowNumber := LV_GetNext(,"F")
LV_GetText(Window,RowNumber,1)
WinHide,ahk_pid %Window%
return

ShowAll:
Gui,ListView,Window
Loop % LV_GetCount()
{
	LV_GetText(RetrievedText, A_Index)
	WinShow,ahk_pid %RetrievedText%
}
return

Show:
RowNumber := LV_GetNext(,"F")
LV_GetText(Window,RowNumber,1)
WinShow,ahk_pid %Window%
WinActivate,ahk_pid %Window%
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

Block:
isPressed:=0,i:= 0
Loop
{
    Left_Mouse:=GetKeyState("LButton")
    MouseGetPos,TempX,TempY
    ToolTip,Click twice to set Block Coordinates`.`n%TempX%`,%TempY%
    if(Left_Mouse==False&&isPressed==0)
    isPressed:=1
    else if(Left_Mouse==True&&isPressed==1)
    {
        i++,isPressed:=0
        if(i>=2)
        {
            MouseGetPos,BlockX,BlockY
            GuiControl,,Block,%BlockX%,%BlockY%
            tooltip,
            break
        }
    }
    
 }
return

Fist:
isPressed:=0,i:= 0
Loop
{
    Left_Mouse:=GetKeyState("LButton")
    MouseGetPos,TempX,TempY
    ToolTip,Click twice to set Fist Coordinates`.`n%TempX%`,%TempY%
    if(Left_Mouse==False&&isPressed==0)
    isPressed:=1
    else if(Left_Mouse==True&&isPressed==1)
    {
        i++,isPressed:=0
        if(i>=2)
        {
            MouseGetPos,FistX,FistY
            GuiControl,,Fist,%FistX%,%FistY%
            tooltip,
            break
        }
    }
    
 }
return

Place1:
isPressed:=0,i:= 0
Loop
{
    Left_Mouse:=GetKeyState("LButton")
    MouseGetPos,TempX,TempY
    ToolTip,Click twice to set Place1 Coordinates`.`n%TempX%`,%TempY%
    if(Left_Mouse==False&&isPressed==0)
    isPressed:=1
    else if(Left_Mouse==True&&isPressed==1)
    {
        i++,isPressed:=0
        if(i>=2)
        {
            MouseGetPos,Place1X,Place1Y
            GuiControl,,Place1,%Place1X%,%Place1Y%
            tooltip,
            break
        }
    }
    
 }
return

Character:
isPressed:=0,i:= 0
Loop
{
    Left_Mouse:=GetKeyState("LButton")
    MouseGetPos,TempX,TempY
    ToolTip,Click twice to set Character Coordinates`.`n%TempX%`,%TempY%
    if(Left_Mouse==False&&isPressed==0)
    isPressed:=1
    else if(Left_Mouse==True&&isPressed==1)
    {
        i++,isPressed:=0
        if(i>=2)
        {
            MouseGetPos,CharacterX,CharacterY
            GuiControl,,Character,%CharacterX%,%CharacterY%
            tooltip,
            break
        }
    }
    
 }
return

Seed:
isPressed:=0,i:= 0
Loop
{
    Left_Mouse:=GetKeyState("LButton")
    MouseGetPos,TempX,TempY
    ToolTip,Click twice to set Seed Coordinates`.`n%TempX%`,%TempY%
    if(Left_Mouse==False&&isPressed==0)
    isPressed:=1
    else if(Left_Mouse==True&&isPressed==1)
    {
        i++,isPressed:=0
        if(i>=2)
        {
            MouseGetPos,SeedX,SeedY
            GuiControl,,Seed,%SeedX%,%SeedY%
            tooltip,
            break
        }
    }
    
 }
return

Drop:
isPressed:=0,i:= 0
Loop
{
    Left_Mouse:=GetKeyState("LButton")
    MouseGetPos,TempX,TempY
    ToolTip,Click twice to set Drop Coordinates`.`n%TempX%`,%TempY%
    if(Left_Mouse==False&&isPressed==0)
    isPressed:=1
    else if(Left_Mouse==True&&isPressed==1)
    {
        i++,isPressed:=0
        if(i>=2)
        {
            MouseGetPos,DropX,DropY
            GuiControl,,Drop,%DropX%,%DropY%
            tooltip,
            break
        }
    }
    
 }
return

Place2:
isPressed:=0,i:= 0
Loop
{
    Left_Mouse:=GetKeyState("LButton")
    MouseGetPos,TempX,TempY
    ToolTip,Click twice to set Place2 Coordinates`.`n%TempX%`,%TempY%
    if(Left_Mouse==False&&isPressed==0)
    isPressed:=1
    else if(Left_Mouse==True&&isPressed==1)
    {
        i++,isPressed:=0
        if(i>=2)
        {
            MouseGetPos,Place2X,Place2Y
            GuiControl,,Place2,%Place2X%,%Place2Y%
            tooltip,
            break
        }
    }
    
 }
return

Fissure:
isPressed:=0,i:= 0
Loop
{
    Left_Mouse:=GetKeyState("LButton")
    MouseGetPos,TempX,TempY
    ToolTip,Click twice to set Fissure Coordinates`.`n%TempX%`,%TempY%
    if(Left_Mouse==False&&isPressed==0)
    isPressed:=1
    else if(Left_Mouse==True&&isPressed==1)
    {
        i++,isPressed:=0
        if(i>=2)
        {
            MouseGetPos,FissureX,FissureY
            GuiControl,,Fissure,%FissureX%,%FissureY%
            tooltip,
            break
        }
    }
    
 }
return

Stop:
GuiControl,Enable,StartButton
GuiControl,Disable,StopButton
stop:=true
return

Start:
GuiControl,Enable,StopButton
GuiControl,Disable,StartButton
stop:=false

Gui,ListView,Window
PIDCount:=LV_GetCount()
counter:=1
loop, % LV_GetCount()
{
    LV_GetText(window%counter%, A_Index)
	counter++
}

loopcounter:=1
loop{
        GT_Auto_Walk("Right",DelayWalk,"Window")
        sleep,50
        Click_AllPID_Function(FistX,FistY,"Window")
        sleep,50
        Click_AllPID_Function(SeedX,SeedY,"Window")			
        sleep,50			
        Hold_AllPID_Function(CharacterX,CharacterY,"Window")			
        sleep,50			
        total:=DelayWalk+1000
        GT_Auto_Walk("Left",total,"Window")
        Release_AllPID_Function(CharacterX,CharacterY,"Window")			
        sleep,70		
        if (loopcounter=Looping){            
            Click_AllPID_Function(FistX,FistY,"Window")
            sleep,50
            Click_AllPID_Function(FissureX,FissureY,"Window")
            sleep,50
            Click_AllPID_Function(SeedX,SeedY,"Window")
            sleep,50
            Click_AllPID_Function(DropX,DropY,"Window")
            sleep,1500
            Send_Key_AllPID_Function("Enter","Window")
            sleep,800
            Click_AllPID_Function(FistX,FistY,"Window")
            sleep,100
            Click_AllPID_Function(FissureX,FissureY,"Window")
            sleep,200
            loopcounter:=1
        }
        
        loopcount:=EstimatedBlock/2
        Loop,%LoopCount%{
            Click_AllPID_Function(BlockX,BlockY,"Window")
            Sleep,50
            Click_AllPID_Function(Place1X,Place1Y,"Window")
            sleep,200
            Click_AllPID_Function(Place2X,Place2Y,"Window")
            sleep,200
            Click_AllPID_Function(FistX,FistY,"Window")
            sleep,100
            Hold_AllPID_Function(Place1X,Place1Y,"Window")
            HitSleep:=HitCount*200
            sleep,%HitSleep%
            Release_AllPID_Function(Place1X,Place1Y,"Window")
            sleep,200
            Hold_AllPID_Function(Place2X,Place2Y,"Window")
            HitSleep:=HitCount*200
            sleep,%HitSleep%
            Release_AllPID_Function(Plac2X,Place2X,"Window")
            sleep,200
            Send_Key_Down_AllPID_Function("Up","Window")
            sleep,500
            Send_Key_Up_AllPID_Function("Up","Window")
            sleep,500
        }
		loopcounter++
	}
    
    




return



Send_Key_AllPID_Function(KeyName,listviewname){
    global
    Gui,ListView,%ListViewName%
    PIDCount:=LV_GetCount()
    counter:=1
    loop, %PIDCount%{
        window:=window%counter%
        if not stop{
            ControlSend,,{%KeyName%},ahk_pid %window%
            sleep,20
        }else{
            exit
        }
        counter++
    }
    return
}


Send_Key_Up_AllPID_Function(KeyName,listviewname){
    global
    Gui,ListView,%ListViewName%
    PIDCount:=LV_GetCount()
    counter:=1
    loop, %PIDCount%{
        window:=window%counter%
        if not stop{
            ControlSend,,{%KeyName% Up},ahk_pid %window%
        }else{
            exit
        }
        counter++
    }
    return
}


Send_Key_Down_AllPID_Function(KeyName,listviewname){
    global
    Gui,ListView,%ListViewName%
    PIDCount:=LV_GetCount()
    counter:=1
    loop, %PIDCount%{
        window:=window%counter%
        if not stop{
            ControlSend,,{%KeyName% Down},ahk_pid %window%
        }else{
            exit
        }
        counter++
    }
    return
}

Release_AllPID_Function(x,y,listviewname){
    global
    Gui,ListView,%ListViewName%
    PIDCount:=LV_GetCount()
    counter:=1
    loop, %PIDCount%{
        window:=window%counter%
        if not stop{
            ControlClick,,ahk_pid %window%,,Left,,X%x% Y%y% NA U
        }else{
            exit
        }
        counter++
    }
    return
}

Hold_AllPID_Function(x,y,listviewname){
    global
    Gui,ListView,%ListViewName%
    PIDCount:=LV_GetCount()
    counter:=1
    loop, %PIDCount%{
        window:=window%counter%
        if not stop{
            ControlClick,,ahk_pid %window%,,Left,,X%x% Y%y% NA D
        }else{
            exit
        }
        counter++
    }
    return
}


Click_AllPID_Function(x,y,listviewname){
    global
    Gui,ListView,%ListViewName%
    PIDCount:=LV_GetCount()
    counter:=1
    loop, %PIDCount%{
        window:=window%counter%
        if not stop{
            ControlClick,,ahk_pid %window%,,Left,,X%x% Y%y% NA
        }else{
            exit
        }
        counter++
    }
    return
}



GT_Auto_Walk(LeftOrRight,WalkingTime,ListViewName){
    global
    GTAutoWalkTimer:=A_TickCount
    GTAutoWalkTimer2:=A_TickCount    
    Send_Key_Down_AllPID_Function(LeftOrRight,ListViewName)
    loop {
        GTAutoWalkTimerElapsed:=A_TickCount-GTAutoWalkTimer
        GTAutoWalkTimerElapsed2:=A_TickCount-GTAutoWalkTimer2
        if not stop
        {
            if (GTAutoWalkTimerElapsed < WalkingTime){
                if (GTAutoWalkTimerElapsed2>7000)
                {
                    Send_Key_Up_AllPID_Function(LeftOrRight,ListViewName)
                    sleep,20
                    Send_Key_Down_AllPID_Function(LeftOrRight,ListViewName)
                    GTAutoWalkTimer2:=A_TickCount
                }
                
            } else {
                Send_Key_Up_AllPID_Function(LeftOrRight,ListViewName)
                break
            }
        }else {
            Gui,ListView,%ListViewName%
            PIDCount:=LV_GetCount()
            Stopcounter:=1
            loop, %PIDCount%{
                window:=window%Stopcounter%
                ControlSend,,{%LeftOrRight% Up},ahk_pid %window%
                Stopcounter++
            }
            Exit
        }
        
    }
    return
}