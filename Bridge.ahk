#NoEnv
#SingleInstance, force

EnvGet, ProgramFilesx86, ProgramFiles(x86)

; Set the Adobe Bridge executable path
bridgePath := ProgramFilesx86 . "\Adobe\Adobe Bridge CS5\Bridge.exe"

; Check if Adobe Bridge is installed at the specified path
if !(FileExist(bridgePath))
{
    MsgBox, Adobe Bridge CS5 is not installed or the path to Bridge is incorrect.
    ExitApp
}

; Fix encoding (make sure that this script is saved with UTF8-BOMB!)
For n, param in A_Args
{
    param := StrReplace(param, "%E4", "ä")
    param := StrReplace(param, "%F6", "ö")
    param := StrReplace(param, "%FC", "ü")
    param := StrReplace(param, "%C4", "Ä")
    param := StrReplace(param, "%D6", "ö")
    param := StrReplace(param, "%DC", "ü")
    param := StrReplace(param, "%DF", "ß")
    param := StrReplace(param, "%A7", "§")
    param := StrReplace(param, "%A4", "€")
    sParam = %sParam% %param%
}
; Remove trailing backslash, which confuses Bridge
sParam := SubStr(sParam, 1, -1)

; Enable the following line to debug which additional characters might be needed
; MsgBox, The following path will be used: %sParam%, DEBUG
; Start Adobe Bridge
Run %bridgePath% `"%sParam%`"
