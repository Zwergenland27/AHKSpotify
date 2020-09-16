#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey, 2
^m::
toggle := !toggle
If (toggle){
    MsgBox, 0, Spotify Hack, muting advertisements enabled
}
Else{
     MsgBox, 0, Spotify Hack, muting advertisements disabled
}
    Loop {
        if (toggle){
            WinGetTitle, title, A
            WinGet, id, list, ahk_exe spotify.exe
                Loop, %id%{
                    this_ID := id%A_Index%
                    WinGetTitle, title2, ahk_id %this_ID%
                    if (title2 != "" && title2 != "G" && title2 != "CspNotify Notify Window" && title2 != "MSCTFIME UI" && title2 != "Default IME"){ ;some other random titles in spotify.exe
                        nowtitle = %title2%
                    }
                }
            If (oldtitle != nowtitle){
                WinGet, pid, PID, ahk_exe spotify.exe
                If (pid != 0){
                    if WinExist("Spotify Free") || WinExist("Advertisement") || WinExist("Spotify"){
                        WinActivate
                        WinGetTitle, title2, A
                        Send, {CtrlDown} {ShiftDown} {Down} {ShiftUp} {CtrlUp}
                        Sleep, 1
                        WinActivate, %title%
                    }
                    Else{
                        WinActivate, %title2%
                        Send, {CtrlDown} {ShiftDown} {UP} {ShiftUp} {CtrlUp}
                        Sleep, 50                                               ;dont know why, but spotify seems to be slow when unmuting, song is still muted but show thats its unmuted -> timeout, little volume change will fix it
                        Send, {CtrlDown} {DOWN} {CtrlUp}
                        Sleep, 50
                        Send, {CtrlDown} {UP} {CtrlUp}
                        Sleep, 1
                        WinActivate, %title%
                    }
                }
                oldtitle = %title2%
            }
        }else{
            break
        }
    }
return
^+m::
    If (toggle){
        MsgBox, 0, Spotify Hack, muting advertisements enabled
    }
    Else{
        MsgBox, 0, Spotify Hack, muting advertisementse disabled
    }
return