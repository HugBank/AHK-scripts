;~ https://www.autohotkey.com/boards/viewtopic.php?t=35737  by scriptor2016 ; For voice recognition to work you need Microsoft SAPI installed in your PC, some versions of Windows don't support voice recognition though.
; You may also need to train voice recognition in Windows so that it will understand your voice.
#Persistent
#SingleInstance, Force

global pspeaker := ComObjCreate("SAPI.SpVoice") ;plistener := ComObjCreate("SAPI.SpSharedRecognizer") 
plistener:= ComObjCreate("SAPI.SpInprocRecognizer") ; For not showing Windows Voice Recognition widget.
paudioinputs := plistener.GetAudioInputs() ; For not showing Windows Voice Recognition widget.
plistener.AudioInput := paudioinputs.Item(0)   ; For not showing Windows Voice Recognition widget.
ObjRelease(paudioinputs) ; Release object from memory, it is not needed anymore.
pcontext := plistener.CreateRecoContext()
pgrammar := pcontext.CreateGrammar()
pgrammar.DictationSetState(0)
prules := pgrammar.Rules()
prulec := prules.Add("wordsRule", 0x1|0x20)
prulec.Clear()
pstate := prulec.InitialState()

;Object of Text responses and their Labels to jump to when detected
global responses:={"stop":"stopwalking","go left":"goleft","go right":"goright","jump":"singlejump","respawn":"respawngt"}
for Text, v in Responses ;Need to add e ach text to the pstate object and watch for them
	pstate.AddWordTransition( ComObjParameter(13,0),Text) ; ComObjParemeter(13,0) is value Null for AHK_L




prules.Commit()
pgrammar.CmdSetRuleState("wordsRule",1)
prules.Commit()
ComObjConnect(pcontext, "On")
If (pspeaker && plistener && pcontext && pgrammar && prules && prulec && pstate){	
	SplashTextOn,300,50,,Voice recognition initialisation succeeded
}Else { 
	MsgBox, Sorry, voice recognition initialisation FAILED  
	pspeaker.speak("Starting voice recognition initialisation failed")
}
sleep, 2000
SplashTextOff


Gui,Add,Button, x10 y10 w100 h50 gwinsetter,Set Window
Gui,Font,s30
Gui,Add,Edit, x+10 w265 h50 gsubmitter vgtpid,
Gui,Font,s20
Gui,Add,Text,x20 y+20, Voice Commands
Gui,Font,s15
Gui,Add,Text,x20 y+10,`"Go Left`"`t`= Move to left
Gui,Add,Text,x20 y+10,`"Go Right`"`t`= Move to Right
Gui,Add,Text,x20 y+10,`"Jump`"`t`t`= Jump once
;Gui,Add,Text,x20 y+10,`"Double Jump`"`t`= Jump twice
Gui,Add,Text,x20 y+10,`"Stop`"`t`t`= Stop Moving
Gui,Add,Text,x20 y+10,`"Respawn`"`t`= Character respawn
Gui,Add,Button,x10 y+20 w100 h50 gStart vstartbutton, Start
Gui,Add,Button,x+10 w100 h50 gStop vstopbutton disabled, Stop


Gui,Color,36B4F0
gui,show,, Chichiya GT Auto Farm Assistant 

Pause

return
;********************On recognition function***********************************
OnRecognition(StreamNum,StreamPos,RecogType,Result){
	sText:= Result.PhraseInfo().GetText() ; Grab the text we just spoke and go to that subroutine
		;~ pspeaker.Speak("You love maria very much sir. " sText) 	
		;~ MsgBox, Command is %sText%
	if (Responses[sText]) ;If text is found as a key in the object then... 
		gosub % Responses[sText] ;jump to the gosub
	ObjRelease(sText)
}

;********************Voice command labels***********************************

GuiClose:
ExitApp
return

Start:
Pause
GuiControl,Disable,startbutton
GuiControl,Enable,stopbutton
return
Stop:

GuiControl,Disable,stopbutton
GuiControl,Enable,startbutton
Pause
return



singlejump:
if (gtpid!=""){
	IfWinExist,ahk_pid %gtpid%
	{
		
	}else{
		msgbox, window does not exist, please set a new window.
		return
	}
	
Controlsend,,{w down},ahk_pid %gtpid%
sleep,200
ControlSend,,{w Up}, ahk_pid %gtpid%
}else {
msgbox, Please set a window.	
return
}
return



doublejump:
if (gtpid!=""){
	IfWinExist,ahk_pid %gtpid%
	{
		
	}else{
		msgbox, window does not exist, please set a new window.
		return
	}
	
Controlsend,,{w down},ahk_pid %gtpid%
sleep,200
ControlSend,,{w Up}, ahk_pid %gtpid%
Controlsend,,{w down},ahk_pid %gtpid%
sleep,200
ControlSend,,{w Up}, ahk_pid %gtpid%
}else {
msgbox, Please set a window.	
return
}
return

goleft:
if (gtpid!=""){
	IfWinExist,ahk_pid %gtpid%
	{
		
	}else{
		msgbox, window does not exist, please set a new window.
		return
	}
	
controlsend,,{Left Up},ahk_pid %gtpid%
controlsend,,{Right Up},ahk_pid %gtpid%
controlsend,,{Left Down},ahk_pid %gtpid%
}else {
msgbox, Please set a window.	
return
}
return

goright:
if (gtpid!=""){
	IfWinExist,ahk_pid %gtpid%
	{
		
	}else{
		msgbox, window does not exist, please set a new window.
		return
	}
	
controlsend,,{Right Up},ahk_pid %gtpid%
controlsend,,{Left Up},ahk_pid %gtpid%
controlsend,,{Right Down},ahk_pid %gtpid%
}else {
msgbox, Please set a window.	
return
}
return

stopwalking:
if (gtpid!=""){
	IfWinExist,ahk_pid %gtpid%
	{
		
	}else{
		msgbox, window does not exist, please set a new window.
		return
	}
	
controlsend,,{Left Up},ahk_pid %gtpid%
controlsend,,{Right Up},ahk_pid %gtpid%
}else {
msgbox, Please set a window.	
return
}
return

respawngt:
if (gtpid!=""){
	IfWinExist,ahk_pid %gtpid%
	{
		
	}else{
		msgbox, window does not exist, please set a new window.
		return
	}
	
ControlClick,,ahk_pid  %gtpid%,,,,X973 Y43 NA
sleep,50
ControlClick,,ahk_pid  %gtpid%,,,,X500 Y200 NA
}else {
msgbox, Please set a window.	
return
}
return

submitter:
Gui,Submit,NoHide
return

winsetter:
Target_Window:=Set_Window(Target_Window)
GuiControl,,gtpid,% Target_Window
Gui,Submit,NoHide
return

Set_Window(Target_Window)
{
isPressed:=0,i:= 0
Loop
{
Left_Mouse:=GetKeyState("LButton")
WinGetTitle,Temp_Window,A
ToolTip,Left Click on the target window twice to set `n`n Current Window: %Temp_Window%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(Left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if(i>=2)
{
;WinSetTitle,A,,%windownum% Growtopia
WinGet,Target_Window,PID,A
ToolTip,
break
}
}
}
return Target_Window
}

^Escape::ExitApp ;Control Escape exits the program