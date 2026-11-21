Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
appDir = fso.GetParentFolderName(WScript.ScriptFullName)
htmlPath = appDir & "\mohsen_desktop.html"
fileUrl = "file:///" & Replace(htmlPath, "\", "/")

browsers = Array( _
  shell.ExpandEnvironmentStrings("%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"), _
  shell.ExpandEnvironmentStrings("%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"), _
  shell.ExpandEnvironmentStrings("%ProgramFiles%\Google\Chrome\Application\chrome.exe"), _
  shell.ExpandEnvironmentStrings("%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"), _
  shell.ExpandEnvironmentStrings("%LocalAppData%\Google\Chrome\Application\chrome.exe") _
)

launched = False
For Each b In browsers
  If fso.FileExists(b) Then
    shell.Run """" & b & """ --app=""" & fileUrl & """ --start-maximized", 1, False
    launched = True
    Exit For
  End If
Next

If Not launched Then
  shell.Run """" & htmlPath & """", 1, False
End If
