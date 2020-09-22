#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global guiopened := False
global camefrommute := True
global autoMuteEnabled := False
global nowtitle := ""

Gui, -Caption +LastFound +AlwaysOnTop +ToolWindow
GUI, Color, FFFFFF
;WinSet, TransColor, FFFFFF 255

GUI, Font, s14 W600
Gui, Add, Text, , Spotify Hack

SetTimer, GetTitle, 10

#IfWinNotExist, AHKSpot
^g::    ;shows GUI
guiopened := True
Gui, Show, AutoSize, AHKSpot
return

#IfWinExist, AHKSpot
^+g::   ;hides GUI
guiopened := False
Gui, Show, Hide
return

GuiClose:
guiopened := False
Gui, Show, Hide
return

#IfWinExist
^m::
autoMuteEnabled := !autoMuteEnabled
    if (!guiopened){
        if (autoMuteEnabled){
            MsgBox, 0, AHKSpot, muting advertisements enabled
        }
        else{
            MsgBox, 0, AHKSpot, muting advertisements disabled
        }
    }
    ChangeText(nowtitle)
return

#IfWinNotExist, AHKSpot
^+m::
    if (autoMuteEnabled){
        MsgBox, 0, AHKSpot, muting advertisements enabled
    }
    else{
        MsgBox, 0, AHKSpot, muting advertisements disabled
    }
return

#IfWinExist
^!r::       ;reload script
    Run, testscript.ahk
return

#IfWinActive, AHKSpot
~LButton::
    CoordMode, Mouse, Relative
    MouseGetPos, x0, y0, windowid
    WinGet, id, id, A
    if (windowid = id){
        SetTimer, WatchMouse, 10
    }
return

WatchMouse:
    CoordMode, Mouse, Screen
    KeyIsDown := GetKeyState("LButton", "P")
    if (KeyIsDown = 0){
        SetTimer, WatchMouse, off
        return
    }
    MouseGetPos, x, y
    x -= x0
    y -= y0
    SetWinDelay, -1
    WinMove, AHKSpot, , x, y
return

GetTitle:
    WinGet, id, list, ahk_exe spotify.exe
    loop, %id%{
        this_ID := id%A_Index%
        WinGetTitle, title2, ahk_id %this_ID%
        if (title2 != "" && title2 != "G" && title2 != "CspNotify Notify Window" && title2 != "MSCTFIME UI" && title2 != "Default IME"){ ;some other random titles in spotify.exe
            nowtitle := title2
        }
    }
    if (nowtitle != oldtitle){
        WinGetTitle, scrProgramTitle, A
        if (guiopened){
            if (autoMuteEnabled){
                ChangeText(nowtitle)
            }else{
                ChangeText(nowtitle)
            }
            WinActivate, %scrProgramTitle%
        }
        if (autoMuteEnabled){
            AutoMute(nowtitle)
        }
        oldtitle := nowtitle
    }
return

AutoMute(nowtitle){
    WinGetTitle, scrProgramTitle, A
    WinGet, pid, PID, ahk_exe spotify.exe
    if (pid != 0){
        if WinExist("Spotify Free") || WinExist("Advertisement") || WinExist("Spotify"){
            WinActivate
            Send, {CtrlDown} {ShiftDown} {Down} {ShiftUp} {CtrlUp}
            Sleep, 1
            WinActivate, %scrProgramTitle%
            camefrommute := True
        }else{
            if (camefrommute){
                WinActivate, %nowtitle%
                Send, {CtrlDown} {ShiftDown} {UP} {ShiftUp} {CtrlUp}
                Sleep, 50                                               ;dont know why, but spotify seems to be slow when unmuting, song is still muted but show thats its unmuted -> timeout, little volume change will fix it
                Send, {CtrlDown} {DOWN} {CtrlUp}
                Sleep, 50
                Send, {CtrlDown} {UP} {CtrlUp}
                Sleep, 1
                WinActivate, %scrProgramTitle%
                camefrommute := False
            }
        }
    }
    return
}

ChangeText(title){
    GUI +LastFound
    WinGetPos x, y, w
    xe := x + w
    GUI Destroy
   Gui, -Caption +LastFound +AlwaysOnTop +ToolWindow
    GUI, Color, FFFFFF
    ;WinSet, TransColor, FFFFFF 255

    GUI, Font, s14 W600
    if (autoMuteEnabled){
        Gui, Add, Text, , AM %title%
    }else{
        Gui, Add, Text, , %title%
    }
    
    GUI, Show, x%x% y%y% AutoSize, AHKSpot
    WinGetPos x, y2, w
    xb := xe - w
    GUI, Show, x%xb% y%y% AutoSize, AHKSpot
    if not (guiopened){
        GUI, Show, Hide
    }
    return
}