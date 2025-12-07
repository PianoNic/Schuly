' Silent Starter for Python GUI Application
Option Explicit

Dim objShell, fso, strScriptDir, strPythonScript

Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

strScriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
strPythonScript = strScriptDir & "\db_script.py"

If Not fso.FileExists(strPythonScript) Then
    MsgBox "Cannot find: " & strPythonScript, vbCritical, "Error"
    WScript.Quit
End If

objShell.CurrentDirectory = strScriptDir
objShell.Run "cmd /c pythonw """ & strPythonScript & """", 0, False

Set objShell = Nothing
Set fso = Nothing