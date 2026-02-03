Option Explicit
Dim fso, shell, ip, root, networkSource, logStream, filesDone, totalFiles, runStartTime, totalObjects
Dim selectedObjects, objFolder, colObjects, objKey, userSetup
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

' Argument Check
If WScript.Arguments.Count < 2 Then WScript.Quit
ip = WScript.Arguments(0)
root = WScript.Arguments(1)
If Right(root, 1) <> "\" Then root = root & "\"

' --- READ SETUP FROM INI ---
userSetup = "Seestar S50" 
Dim appPath : appPath = fso.GetParentFolderName(WScript.ScriptFullName)
If fso.FileExists(appPath & "\seestar_settings.ini") Then
    Dim iniF : Set iniF = fso.OpenTextFile(appPath & "\seestar_settings.ini", 1)
    Do While Not iniF.AtEndOfStream
        Dim line : line = iniF.ReadLine
        If InStr(line, "setup=") = 1 Then userSetup = Split(line, "=")(1)
    Loop
    iniF.Close
End If

networkSource = "\\" & ip & "\EMMC Images\MyWorks"
filesDone = 0 : totalObjects = 0 : runStartTime = Now

' --- INITIALIZE DETAILED LOG ---
Dim logFileName : logFileName = root & "Seestar_Log_" & Year(Now) & Month(Now) & Day(Now) & "_" & Hour(Now) & Minute(Now) & ".txt"
Set logStream = fso.CreateTextFile(logFileName, True)
logStream.WriteLine "Started: " & Now & " | Setup: (" & userSetup & ")"
logStream.WriteLine "----------------------------------------------------"

Set selectedObjects = CreateObject("Scripting.Dictionary")

' --- STAGE 1: SMART PRE-SCAN ---
If fso.FolderExists(networkSource) Then
    Set colObjects = fso.GetFolder(networkSource).SubFolders
    For Each objFolder In colObjects
        If LCase(Right(objFolder.Name, 4)) <> "_sub" Then 
            ' Logic to get date from actual telescope files
            Dim fitsDate : fitsDate = GetFitsDate(objFolder.Path & "_sub")
            Dim targetSubFolder : targetSubFolder = fitsDate & " (" & userSetup & ")"
            Dim fullLocalPath : fullLocalPath = root & objFolder.Name & "\" & targetSubFolder
            
            Dim proceed : proceed = True
            If fso.FolderExists(fullLocalPath) Then
                Dim msgText : msgText = "Session already exists for: " & objFolder.Name & " on " & fitsDate & vbCrLf & "Overwrite this specific session?"
                Dim answer : answer = MsgBox(msgText, vbYesNo + vbQuestion + vbSystemModal, "Duplicate Session Detected")
                If answer = vbYes Then 
                    fso.DeleteFolder fullLocalPath, True 
                Else 
                    proceed = False 
                End If
            End If
            
            If proceed Then selectedObjects.Add objFolder.Name, objFolder.Path
        End If
    Next
Else
    MsgBox "Could not connect to Seestar. Check IP.", 16, "Network Error"
    WScript.Quit
End If

' --- STAGE 2: CALCULATE TARGET FILES ---
totalFiles = 0
For Each objKey In selectedObjects.Keys
    totalFiles = totalFiles + CountSelective(selectedObjects(objKey), "fits,jpg")
    If fso.FolderExists(selectedObjects(objKey) & "_sub") Then
        totalFiles = totalFiles + CountSelective(selectedObjects(objKey) & "_sub", "fits")
    End If
Next
WriteSignal "total_files.tmp", totalFiles

' --- STAGE 3: PROCESS ---
For Each objKey In selectedObjects.Keys
    ProcessObject(objKey)
    totalObjects = totalObjects + 1
Next

' Finalize Log
logStream.WriteLine "----------------------------------------------------"
logStream.WriteLine "Summary: " & totalObjects & " Objects | " & filesDone & " Files | Duration: " & DateDiff("s", runStartTime, Now) & "s"
logStream.Close

On Error Resume Next
fso.DeleteFile root & "files_done.txt"
fso.DeleteFile root & "current_object.tmp"
fso.DeleteFile root & "total_files.tmp"

' --- CORE FUNCTIONS ---

Sub ProcessObject(objName)
    Dim objStart : objStart = Now
    WriteSignal "current_object.tmp", objName
    Dim netObj : netObj = networkSource & "\" & objName
    ' FIXED: Added missing equals sign
    Dim netSub : netSub = netObj & "_sub"
    Dim firstFitsDate : firstFitsDate = GetFitsDate(netSub)

    Dim baseDir : baseDir = root & objName
    Dim datedDir : datedDir = baseDir & "\" & firstFitsDate & " (" & userSetup & ")"
    Dim procDir : procDir = datedDir & "\Processed\Internally Processed"
    Dim lightDir : lightDir = datedDir & "\Originals\Lights"

    If Not fso.FolderExists(baseDir) Then fso.CreateFolder(baseDir)
    If Not fso.FolderExists(datedDir) Then fso.CreateFolder(datedDir)
    If Not fso.FolderExists(datedDir & "\Processed") Then fso.CreateFolder(datedDir & "\Processed")
    If Not fso.FolderExists(procDir) Then fso.CreateFolder(procDir)
    If Not fso.FolderExists(datedDir & "\Originals") Then fso.CreateFolder(datedDir & "\Originals")
    If Not fso.FolderExists(lightDir) Then fso.CreateFolder(lightDir)

    Dim pCount : pCount = CopySelective(netObj, procDir, "fits,jpg")
    Dim lCount : lCount = 0
    If fso.FolderExists(netSub) Then lCount = CopySelective(netSub, lightDir, "fits")
    
    logStream.WriteLine "Object: " & objName & " [" & firstFitsDate & "] | Lights: " & lCount & " | Processed: " & pCount
End Sub

Function GetFitsDate(path)
    ' Fallback to today if no files found
    GetFitsDate = Year(Now) & "-" & Right("0" & Month(Now), 2) & "-" & Right("0" & Day(Now), 2)
    On Error Resume Next
    If fso.FolderExists(path) Then
        Dim fl
        For Each fl In fso.GetFolder(path).Files
            ' Extracts the date from the first file found in the subfolder
            GetFitsDate = Year(fl.DateLastModified) & "-" & Right("0" & Month(fl.DateLastModified), 2) & "-" & Right("0" & Day(fl.DateLastModified), 2)
            Exit For
        Next
    End If
End Function

Function CountSelective(path, extList)
    Dim count : count = 0 : On Error Resume Next
    If fso.FolderExists(path) Then
        Dim f
        For Each f In fso.GetFolder(path).Files
            Dim e : e = LCase(fso.GetExtensionName(f.Name))
            If InStr(extList, e) > 0 And InStr(LCase(f.Name), "_thn.jpg") = 0 Then count = count + 1
        Next
    End If
    CountSelective = count
End Function

Function CopySelective(src, dest, extList)
    Dim count : count = 0 : On Error Resume Next
    If fso.FolderExists(src) Then
        Dim f
        For Each f In fso.GetFolder(src).Files
            Dim e : e = LCase(fso.GetExtensionName(f.Name))
            If InStr(extList, e) > 0 And InStr(LCase(f.Name), "_thn.jpg") = 0 Then
                fso.CopyFile f.Path, dest & "\", True
                filesDone = filesDone + 1 : count = count + 1
                WriteSignal "files_done.txt", filesDone
            End If
        Next
    End If
    CopySelective = count
End Function

Sub WriteSignal(name, val)
    On Error Resume Next
    Dim t : Set t = fso.CreateTextFile(root & name, True) : t.Write val : t.Close
End Sub