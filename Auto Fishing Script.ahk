
#SingleInstance Off
#NoTrayIcon


CoordMode,Mouse,Screen
CoordMode,Pixel,Screen
Hotkey,Lbutton,Off

SoundPlay *48

Menu, Tray, Icon,Shell32.dll,241

Menu, Tray, Add , E&dit Scite, Edit_Scite

Menu, Tray, Add , E&dit Notepad, Edit_Notepad



Menu, Tray, Add, Exit Screen Capture, Exit_Gui ; double click tray icon to exit

Menu, Tray, Default, Exit Screen Capture





;Work_Dir := "C:\Temp\"

;Work_Dir = %temp%

;SetWorkingDir, %Work_Dir%

IfNotExist Screenshots

FileCreateDir, Screenshots



folder_path := A_WorkingDir . "\Screenshots\"



index :=2









OnMessage(0x14, "WM_ERASEBKGND")

Gui, -Caption +ToolWindow

Gui, +LastFound

WinSet, TransColor, Black

; Create the pen here so we don't need to create/delete it every time.

RedPen := DllCall("CreatePen", "int", PS_SOLID:=0, "int", 5, "uint", 0xff)

Gui,3:Add,Button,x10 y10 w80 h25 gSelectWindow,Select Window
Gui,3:Add,Edit,x+10 h25 w100 vwindow1
Gui,3:Add,Button,x10 w80 h25 y+10 gTestLabel,Capture
Gui,3:Add,Picture,x+10 w100 h90,% "HBITMAP:*" . Create_Whattocapture_png()
Gui,3:Add,Button,x10 y75 w80 h25 gSelectWater,Select Water
Gui,3:Add,Edit,x10 y+10 w80 h25 vWaterCoords 
Gui,3:Add,Checkbox,gToggleCheckBox vCheckBoxVar x10 y+10,Use Detonator`/Hand Drill 
Gui,3:Add,Button,x10 y+10 Disabled h25 w80 vSelectEquipmentButton gSelectEquipment,Select Equipment
Gui,3:Add,Edit,x+10 h25 w100 Disabled vEquipmentEdit
Gui,3:Add,Button,x10 y+10 Disabled h25 w80 vSelectBaitButton gSelectBait,Select Bait
Gui,3:Add,Edit,x+10 h25 w100 Disabled vSelectBaitEdit
Gui,3:Add,Button,x10 y+15 w90 h35 gStart vStartButton,Start
Gui,3:Add,Button,x+10 w90 h35 Disabled vStopButton gStop,Stop
Gui,3:Color,009AE4
;Gui,Add,Button,x10 y10 w100 h50 gTestLabel,Capture
gui,3:show,,Auto Fishing
return

guiclose:
ExitApp
return

2guiclose:
ExitApp
return

3guiclose:
ExitApp
return

4guiclose:
ExitApp
return

SelectEquipment:
CoordMode,Mouse,Client
isPressed:=0,i:= 0
Loop
{
Left_Mouse:=GetKeyState("LButton")
WinGetTitle,Temp_Window,A
ToolTip,Left Click on the target twice to set `n`n Current Window: %Temp_Window%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(Left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if(i>=2)
{
MouseGetPos,EquipmentX,EquipmentY
GuiControl,,EquipmentEdit,%EquipmentX%`,%EquipmentY%
ToolTip,
break
}
}
}
Gui,Submit,NoHide
CoordMode,Mouse,Screen

return


SelectBait:
CoordMode,Mouse,Client
isPressed:=0,i:= 0
Loop
{
Left_Mouse:=GetKeyState("LButton")
WinGetTitle,Temp_Window,A
ToolTip,Left Click on the target twice to set `n`n Current Window: %Temp_Window%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(Left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if(i>=2)
{
MouseGetPos,BaitX,BaitY
GuiControl,,SelectBaitEdit,%BaitX%`,%BaitY%
ToolTip,
break
}
}
}
Gui,Submit,NoHide
CoordMode,Mouse,Screen


return


ToggleCheckBox:
Gui,Submit,NoHide
if (CheckBoxVar==1){
GuiControl,Enable,SelectEquipmentButton
GuiControl,Enable,EquipmentEdit
GuiControl,Enable,SelectBaitEdit
GuiControl,Enable,SelectBaitButton
}else {
GuiControl,Disable,SelectEquipmentButton
GuiControl,Disable,EquipmentEdit
GuiControl,Disable,SelectBaitEdit
GuiControl,Disable,SelectBaitButton


}

return


f5::
Pause
return

Start:


status:="Start"
if (WaterCoords=""){
Msgbox,Please Select Water.
return
}
if (begin_x=""){
Msgbox,Please Capture Background.
return
}


GuiControl,Enable,StopButton
GuiControl,Disable,StartButton

While (status=="Start"){
		ImageSearch,,,begin_x,begin_y,end_x,end_y,%A_ScriptDir%\Screenshots\screenshot.PNG
		;imagesearch,,
		if (ErrorLevel=2){
			tooltip, ERROR - YOU MUST START CAPTURING FROM TOP LEFT TO BOTTOM RIGHT.
		}else if (Errorlevel=1){
			ControlClick,,ahk_pid %window1%,,Left,1,X%waterX% Y%WaterY% NA
			sleep,2000
			if (CheckBoxVar==1){
			ControlClick,,ahk_pid %window1%,,Left,1,X%EQUIPMENTX% Y%EQUIPMENTY% NA	
			sleep,200
			ControlClick,,ahk_pid %window1%,,Left,1,X%waterX% Y%WaterY% NA
			sleep,200
			ControlClick,,ahk_pid %window1%,,Left,1,X%BAITX% Y%BAITY% NA
			sleep,200
			}
			ControlClick,,ahk_pid %window1%,,Left,1,X%waterX% Y%WaterY% NA
			StartTimeer:=A_TickCount
			;insert here loop that checks if image not found
			loop{
				ElapsedTimeer:=A_TickCount - StartTimeer
				ImageSearch,,,begin_x,begin_y,end_x,end_y,%A_ScriptDir%\Screenshots\screenshot.PNG
				if (ErrorLevel=1){
					sleep,1500
					break
				}else if (ErrorLevel=0){
					if (ElapsedTimeer>3000){
						ControlClick,,ahk_pid %window1%,,Left,1,X%waterX% Y%WaterY% NA
						StartTimeer:=A_TickCount
					}
				}
			}
			sleep,2000
		}else if (ErrorLevel=0){
		
		}

}

return


Stop:
status:="Stop"
GuiControl,Enable,StartButton
GuiControl,Disable,StopButton
tooltip,
return

SelectWindow:
windownum:=1
Target_Window:=Set_Window(Target_Window,windownum)
GuiControl,,window1,% Target_Window
Gui,Submit,NoHide
return


return


SelectWater:
CoordMode,Mouse,Client
isPressed:=0,i:= 0
Loop
{
Left_Mouse:=GetKeyState("LButton")
WinGetTitle,Temp_Window,A
ToolTip,Left Click on the target twice to set `n`n Current Window: %Temp_Window%
if(Left_Mouse==False&&isPressed==0)
isPressed:=1
else if(Left_Mouse==True&&isPressed==1)
{
i++,isPressed:=0
if(i>=2)
{
MouseGetPos,WaterX,WaterY
GuiControl,,WaterCoords,%WaterX%`,%WaterY%
ToolTip,
break
}
}
}
Gui,Submit,NoHide
CoordMode,Mouse,Screen

return


testlabel:
Hotkey,Lbutton,On

SetTimer,ToolTipFollow,20
return





ToolTipFollow:
Tooltip,Capture background
return



LButton::


CoordMode, Mouse, Screen
MouseGetPos, begin_x, begin_y

MouseGetPos, xorigin, yorigin

SetTimer, rectangle, 10

KeyWait, LButton

SetTimer, rectangle, Off

Gui, Cancel

MouseGetPos, end_x, end_y
SetTimer,ToolTipFollow,Off
ToolTip,
;msgbox,%begin_x%`,%begin_y%`n%end_x%`,%end_y%


if (end_x > begin_x AND end_y > begin_y){

;file%index% := oi".png"

;screen := begin_x . "|" . begin_y . "|" . Abs(end_x-begin_x) . "|" Abs(end_y-begin_y) ; X|Y|W|H

Capture_x:=begin_x

Capture_y:=begin_y

}else if (end_x < begin_x AND end_y < begin_y){

Capture_x:=end_x

Capture_y:=end_y

}else if (end_x < begin_x AND end_y > begin_y){

Capture_x:=end_x

Capture_y:=begin_y

}else if (end_x > begin_x AND end_y < begin_y){

Capture_x:=begin_x

Capture_y:=end_y

}





Capture_width:=Abs(end_x-begin_x)

Capture_height:= Abs(end_y-begin_y)





screen := Capture_x . "|" . Capture_y . "|" . Capture_width . "|" Capture_height ; X|Y|W|H



;file%index% := folder_path "screenshot x" Capture_x ",y" Capture_y " width" Capture_width ", height" Capture_height ".png"

;file%index% := folder_path "screenshot " A_Now_Format(A_Now) ", w" Capture_width " h" Capture_height ".png"

file%index% := folder_path "screenshot.png"



x:=file%index%

Screenshot(x,screen)

sleep 300

Hotkey,Lbutton,Off
;Gosub, makeGUI

return







rectangle:

CoordMode, Mouse, Screen

MouseGetPos, x2, y2



; Has the mouse moved?

if (x1 y1) = (x2 y2)

return



; Allow dragging to the left of the click point.

if (x2 < xorigin) {

x1 := x2

x2 := xorigin

} else

x1 := xorigin



; Allow dragging above the click point.

if (y2 < yorigin) {

y1 := y2

y2 := yorigin

} else

y1 := yorigin



Gui, Show, % "NA X" x1 " Y" y1 " W" x2-x1 " H" y2-y1

Gui, +LastFound

DllCall("RedrawWindow", "uint", WinExist(), "uint", 0, "uint", 0, "uint", 5)

return



full_screen:

file%index% := folder_path "screenshot " A_Now_Format(A_Now) ".png"

x:=file%index%

screen := 0 . "|" . 0 . "|" . A_ScreenWidth . "|" A_ScreenHeight ; X|Y|W|H

Screenshot(x,screen)

sleep 300

Gosub, makeGUI

return



makeGUI:

Gui,%index% : +LastFound +Resize +Minsize400x330 ; +AlwaysOnTop

Gui,%index%: Color, 6B8590
Gui,%index%:Add,Text,,teets
Gui,%index%: Margin,0,0

;Gui,%index%: Add, Picture, x10 y4 w16 h16 gSave Icon259 AltSubmit, shell32.dll ;

;Gui,%index%: Add, Picture, x40 y4 w16 h16 gSave_2 Icon24 AltSubmit, imageres.dll ;



file_GUI:= file%index%

;MsgBox, , , % "makeGUI: " index " - " file1

Gui,%index%: Add, Picture, x0 y24 , %file_GUI%

Gui,%index%: Show,, Screenshot

index+=1

return







Save:

;File_num:= "C:\a\My File" A_Gui ".png"

File_num:= file%A_Gui%

;FileSelectFile, FileName , S, %File_num%.png , Save As, Image Files (*.png) ;C:\a\My File.png

FileSelectFile, FileName , S, %File_num% , Save As, Image Files (*.png)

file:=file%A_Gui%



;FileCopy, %file%, %FileName%

FileCopy, %file%, %FileName%.png ;Feb5 2018

return



Save_2:

File_num:= file%A_Gui%

;FileSelectFile, FileName , S, %File_num%.png , Save As, Image Files (*.png)

FileSelectFile, FileName , S, %File_num% , Save As, Image Files (*.png)

file:=file%A_Gui%



;======================== compress with pngquanti

CompressPNG := "C:\Program Files\Misc\PNGquant\libs\pngquanti\pngquanti.exe" ; path to pngquant

RunWait , %CompressPNG% "%file%"



RegExMatch(file,"^(.*)\.png$", f)

file:= f1 . "-fs8.png"



;MsgBox, , , % file "`n" FileName

;FileCopy, %file%, %FileName%

FileCopy, %file%, %FileName%.png

;========================

return



#g:: Gosub, full_screen



#h:: Gosub, FromWindow



^g:: Gosub, full_screen



^h:: Gosub, FromWindow



FromWindow:

InputBox, window , Window Title, Enter Window Title, , 300, 100,,,,,ahk_class OperaWindowClass



dat:= A_Now_Format(A_Now)

;file := folder_path "screenshot ”" window "” " A_Now_Format(A_Now) ".png"

file%index%:= folder_path "screenshot ”" window "” " A_Now_Format(A_Now) ".png"

ID:= WinExist(window)

y:=file%index%

ClipFromWindow(y,ID)

Gosub, makeGUI

index+=1

return





ClipFromWindow(outfile, ID) {

pToken := Gdip_Startup()

pBitmap:=Gdip_BitmapFromHWND(ID)

Gdip_SaveBitmapToFile(pBitmap, outfile, 80)





Gdip_DisposeImage(pBitmap)

Gdip_Shutdown(pToken)

}





Screenshot(outfile, screen) {

pToken := Gdip_Startup()

raster := 0x40000000 + 0x00CC0020



pBitmap := Gdip_BitmapFromScreen(screen,raster)



Gdip_SaveBitmapToFile(pBitmap, outfile, 80)

Gdip_DisposeImage(pBitmap)

Gdip_Shutdown(pToken)

}







A_Now_Format(raw){

RegExMatch(raw,"^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})", d)

date:=d1 "-" d2 "-" d3 " " d4 "-" d5 "-" d6

return date

}



WM_ERASEBKGND(wParam, lParam)

{

global x1, y1, x2, y2, RedPen

Critical 50

if A_Gui = 1

{

; Retrieve stock brush.

blackBrush := DllCall("GetStockObject", "int", BLACK_BRUSH:=0x4)

; Select pen and brush.

oldPen := DllCall("SelectObject", "uint", wParam, "uint", RedPen)

oldBrush := DllCall("SelectObject", "uint", wParam, "uint", blackBrush)

; Draw rectangle.

DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", x2-x1, "int", y2-y1)

; Reselect original pen and brush (recommended by MS).

DllCall("SelectObject", "uint", wParam, "uint", oldPen)

DllCall("SelectObject", "uint", wParam, "uint", oldBrush)

return 1

}

}





;=======

OnExit:

Exit_Gui:

MsgBox,,, ` Exit ,1

FileDelete, %folder_path%*.png

exitapp

return



;=======



;Esc:: Gosub, Exit





Edit_Notepad:

Run, "C:\Program Files\Misc\Notepad2\Notepad2.exe" "%A_ScriptFullPath%"

return



Edit_Scite:

Run, "C:\Program Files\AutoHotkey\SciTE\SciTE.exe" "%A_ScriptFullPath%"

return



Exit:

FileDelete, %folder_path%*.png

;FileRecycle, %folder_path%*.png

;FileRemoveDir,%folder_path%, 1

ExitApp

return





;#Include Gdip_All.ahk













{

Ptr := A_PtrSize ? "UPtr" : "UInt"

if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)

DllCall("LoadLibrary", "str", "gdiplus")

VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)

DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)

return

}





{

Ptr := A_PtrSize ? "UPtr" : "UInt"

DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)

if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)

DllCall("FreeLibrary", Ptr, hModule)

return

}







{

WinGetPos,,, Width, Height, ahk_id %hwnd%

hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)

PrintWindow(hwnd, hdc)

pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)

SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)

return

}









{

Ptr := A_PtrSize ? "UPtr" : "UInt"



SplitPath, sOutput,,, Extension

if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG

return

Extension := "." Extension



DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)

VarSetCapacity(ci, nSize)

DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)

if !(nCount && nSize)

return



If (A_IsUnicode){

StrGet_Name := "StrGet"

Loop, %nCount%

{

sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")

if !InStr(sString, "*" Extension)

continue



pCodec := &ci+idx

break

}

} else {

Loop, %nCount%

{

Location := NumGet(ci, 76*(A_Index-1)+44)

nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int", 0, "uint", 0, "uint", 0)

VarSetCapacity(sString, nSize)

DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)

if !InStr(sString, "*" Extension)

continue



pCodec := &ci+76*(A_Index-1)

break

}

}



if !pCodec

return



if (Quality != 75)

{

Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality

if Extension in .JPG,.JPEG,.JPE,.JFIF

{

DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)

VarSetCapacity(EncoderParameters, nSize, 0)

DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)

Loop, % NumGet(EncoderParameters, "UInt") ;%

{

elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)

if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)

{

p := elem+&EncoderParameters-pad-4

NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")

break

}

}

}

}



if (!A_IsUnicode)

{

nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, 0, "int", 0)

VarSetCapacity(wOutput, nSize*2)

DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, &wOutput, "int", nSize)

VarSetCapacity(wOutput, -1)

if !VarSetCapacity(wOutput)

return

E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &wOutput, Ptr, pCodec, "uint", p ? p : 0)

}

else

E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &sOutput, Ptr, pCodec, "uint", p ? p : 0)

return

}











{

if (Screen = 0)

{

Sysget, x, 76

Sysget, y, 77

Sysget, w, 78

Sysget, h, 79

}

else if (SubStr(Screen, 1, 5) = "hwnd:")

{

Screen := SubStr(Screen, 6)

if !WinExist( "ahk_id " Screen)

return

WinGetPos,,, w, h, ahk_id %Screen%

x := y := 0

hhdc := GetDCEx(Screen, 3)

}

else if (Screen&1 != "")

{

Sysget, M, Monitor, %Screen%

x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop

}

else

{

StringSplit, S, Screen, |

x := S1, y := S2, w := S3, h := S4

}



if (x = "") || (y = "") || (w = "") || (h = "")

return



chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()

BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)

ReleaseDC(hhdc)



pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)

SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)

return

}







{

Ptr := A_PtrSize ? "UPtr" : "UInt"



hdc2 := hdc ? hdc : GetDC()

VarSetCapacity(bi, 40, 0)



NumPut(w, bi, 4, "uint")

, NumPut(h, bi, 8, "uint")

, NumPut(40, bi, 0, "uint")

, NumPut(1, bi, 12, "ushort")

, NumPut(0, bi, 16, "uInt")

, NumPut(bpp, bi, 14, "ushort")



hbm := DllCall("CreateDIBSection"

, Ptr, hdc2

, Ptr, &bi

, "uint", 0

, A_PtrSize ? "UPtr*" : "uint*", ppvBits

, Ptr, 0

, "uint", 0, Ptr)



if !hdc

ReleaseDC(hdc2)

return

}





















{

Ptr := A_PtrSize ? "UPtr" : "UInt"



DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)

return

}








Create_whattocapture_png(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 24948 << !!A_IsUnicode)
B64 := "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"
B64 .= "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
; Bitmap creation adopted from "How to convert Image data (JPEG/PNG/GIF) to hBITMAP?" by SKAN
; -> http://www.autohotkey.com/board/topic/21213-how-to-convert-image-data-jpegpnggif-to-hbitmap/?p=139257
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}





Set_Window(Target_Window,windownum)
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
WinSetTitle,A,,%windownum% Growtopia
WinGet,Target_Window,PID,A
ToolTip,
break
}
}
}
return Target_Window
}
*~LButton::
if(Clicker_Is_On==1)
{
Click,
}
return


Gdip_Startup()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}


Gdip_BitmapFromHWND(hwnd)
{
	WinGetPos,,, Width, Height, ahk_id %hwnd%
	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
	PrintWindow(hwnd, hdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	return pBitmap
}


Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality=75)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	SplitPath, sOutput,,, Extension
	if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return -1
	Extension := "." Extension

	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2
	
	If (A_IsUnicode){
		StrGet_Name := "StrGet"
		Loop, %nCount%
		{
			sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
			if !InStr(sString, "*" Extension)
				continue
			
			pCodec := &ci+idx
			break
		}
	} else {
		Loop, %nCount%
		{
			Location := NumGet(ci, 76*(A_Index-1)+44)
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue
			
			pCodec := &ci+76*(A_Index-1)
			break
		}
	}
	
	if !pCodec
		return -3

	if (Quality != 75)
	{
		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if Extension in .JPG,.JPEG,.JPE,.JFIF
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
			Loop, % NumGet(EncoderParameters, "UInt")      ;%
			{
				elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
				if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
				{
					p := elem+&EncoderParameters-pad-4
					NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")
					break
				}
			}      
		}
	}

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wOutput, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, &wOutput, "int", nSize)
		VarSetCapacity(wOutput, -1)
		if !VarSetCapacity(wOutput)
			return -4
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &wOutput, Ptr, pCodec, "uint", p ? p : 0)
	}
	else
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &sOutput, Ptr, pCodec, "uint", p ? p : 0)
	return E ? -5 : 0
}

Gdip_DisposeImage(pBitmap)
{
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}

Gdip_Shutdown(pToken)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}


Gdip_BitmapFromScreen(Screen=0, Raster="")
{
	if (Screen = 0)
	{
		Sysget, x, 76
		Sysget, y, 77	
		Sysget, w, 78
		Sysget, h, 79
	}
	else if (SubStr(Screen, 1, 5) = "hwnd:")
	{
		Screen := SubStr(Screen, 6)
		if !WinExist( "ahk_id " Screen)
			return -2
		WinGetPos,,, w, h, ahk_id %Screen%
		x := y := 0
		hhdc := GetDCEx(Screen, 3)
	}
	else if (Screen&1 != "")
	{
		Sysget, M, Monitor, %Screen%
		x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop
	}
	else
	{
		StringSplit, S, Screen, |
		x := S1, y := S2, w := S3, h := S4
	}

	if (x = "") || (y = "") || (w = "") || (h = "")
		return -1

	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
	ReleaseDC(hhdc)
	
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}


CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)
	
	NumPut(w, bi, 4, "uint")
	, NumPut(h, bi, 8, "uint")
	, NumPut(40, bi, 0, "uint")
	, NumPut(1, bi, 12, "ushort")
	, NumPut(0, bi, 16, "uInt")
	, NumPut(bpp, bi, 14, "ushort")
	
	hbm := DllCall("CreateDIBSection"
					, Ptr, hdc2
					, Ptr, &bi
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "uint*", ppvBits
					, Ptr, 0
					, "uint", 0, Ptr)

	if !hdc
		ReleaseDC(hdc2)
	return hbm
}

CreateCompatibleDC(hdc=0)
{
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}


SelectObject(hdc, hgdiobj)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}


PrintWindow(hwnd, hdc, Flags=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("PrintWindow", Ptr, hwnd, Ptr, hdc, "uint", Flags)
}


DeleteObject(hObject)
{
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}

DeleteDC(hdc)
{
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}

Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}


GetDCEx(hwnd, flags=0, hrgnClip=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
    return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}

GetDC(hwnd=0)
{
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}

BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdi32\BitBlt"
					, Ptr, dDC
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sDC
					, "int", sx
					, "int", sy
					, "uint", Raster ? Raster : 0x00CC0020)
}
ReleaseDC(hdc, hwnd=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}