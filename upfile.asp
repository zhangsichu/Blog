<%
dim oUpFileStream

Class Upload_file

dim Form,File,Err

Private Sub Class_Initialize
Err=-1
end sub

Private Sub Class_Terminate 
'Clear Variables & Objects
if Err < 0 then
oUpFileStream.Close
Form.RemoveAll
File.RemoveAll
set Form=nothing
set File=nothing
set oUpFileStream =nothing
end if
End Sub

Public Sub GetDate(RetSize)
'Define Variables
dim RequestBinDate,sStart,bCrLf,sInfo,iInfoStart,iInfoEnd,tStream,iStart,oFileInfo
dim iFileSize,sFilePath,sFileType,sFormvalue,sFileName
dim iFindStart,iFindEnd
dim iFormStart,iFormEnd,sFormName

If Request.TotalBytes < 1 Then
Err=1
Exit Sub
End If
If RetSize > 0 Then 
If Request.TotalBytes > RetSize then
Err=2
Exit Sub
End If
End If
set Form = Server.CreateObject("Scripting.Dictionary")
set File = Server.CreateObject("Scripting.Dictionary")
set tStream = Server.CreateObject("adodb.stream")
set oUpFileStream = Server.CreateObject("adodb.stream")
oUpFileStream.Type = 1
oUpFileStream.Mode = 3
oUpFileStream.Open 
oUpFileStream.Write Request.BinaryRead(Request.TotalBytes)
oUpFileStream.Position=0
RequestBinDate = oUpFileStream.Read 
iFormEnd = oUpFileStream.Size
bCrLf = chrB(13) & chrB(10)
'Get Seperators
sStart = MidB(RequestBinDate,1, InStrB(1,RequestBinDate,bCrLf)-1)
iStart = LenB (sStart)
iFormStart = iStart+2
'Split Items
Do
iInfoEnd = InStrB(iFormStart,RequestBinDate,bCrLf & bCrLf)+3
tStream.Type = 1
tStream.Mode = 3
tStream.Open
oUpFileStream.Position = iFormStart
oUpFileStream.CopyTo tStream,iInfoEnd-iFormStart
tStream.Position = 0
tStream.Type = 2
tStream.Charset = "utf-8"
sInfo = tStream.ReadText 
'Get form item name
iFormStart = InStrB(iInfoEnd,RequestBinDate,sStart)-1
iFindStart = InStr(22,sInfo,"name=""",1)+6
iFindEnd = InStr(iFindStart,sInfo,"""",1)
sFormName = Mid (sinfo,iFindStart,iFindEnd-iFindStart)
'If it's a file
if InStr (45,sInfo,"filename=""",1) > 0 then
set oFileInfo= new FileInfo
'Get File attributes
iFindStart = InStr(iFindEnd,sInfo,"filename=""",1)+10
iFindEnd = InStr(iFindStart,sInfo,"""",1)
sFileName = Mid (sinfo,iFindStart,iFindEnd-iFindStart)
oFileInfo.FileName = GetFileName(sFileName)
oFileInfo.FilePath = GetFilePath(sFileName)
oFileInfo.FileExt = GetFileExt(sFileName)
iFindStart = InStr(iFindEnd,sInfo,"Content-Type: ",1)+14
iFindEnd = InStr(iFindStart,sInfo,vbCr)
oFileInfo.FileType = Mid (sinfo,iFindStart,iFindEnd-iFindStart)
oFileInfo.FileStart = iInfoEnd
oFileInfo.FileSize = iFormStart -iInfoEnd -2
oFileInfo.FormName = sFormName
file.add sFormName,oFileInfo
else
'If it's form item
tStream.Close
tStream.Type = 1
tStream.Mode = 3
tStream.Open
oUpFileStream.Position = iInfoEnd 
oUpFileStream.CopyTo tStream,iFormStart-iInfoEnd-2
tStream.Position = 0
tStream.Type = 2
tStream.Charset = "utf-8"
sFormvalue = tStream.ReadText 
form.Add sFormName,sFormvalue
end if
tStream.Close
iFormStart = iFormStart+iStart+2
'Exit at end of file
loop until (iFormStart+2) = iFormEnd 
RequestBinDate=""
set tStream = nothing
End Sub

'Get File Path
Private function GetFilePath(FullPath)
If FullPath <> "" Then
GetFilePath = left(FullPath,InStrRev(FullPath, "\"))
Else
GetFilePath = ""
End If
End function

'Get File Name
Private function GetFileName(FullPath)
If FullPath <> "" Then
GetFileName = mid(FullPath,InStrRev(FullPath, "\")+1)
Else
GetFileName = ""
End If
End function

'Get File Extension
Private function GetFileExt(FullPath)
If FullPath <> "" Then
GetFileExt = mid(FullPath,InStrRev(FullPath, ".")+1)
Else
GetFileExt = ""
End If
End function

End Class

'Get File Info
Class FileInfo
dim FormName,FileName,FilePath,FileSize,FileType,FileStart,FileExt
Private Sub Class_Initialize 
FileName = ""
FilePath = ""
FileSize = 0
FileStart= 0
FormName = ""
FileType = ""
FileExt = ""
End Sub

'Save File Method
Public function SaveToFile(FullPath)
dim oFileStream,ErrorChar,i
SaveToFile=1
if trim(fullpath)="" or right(fullpath,1)="/" then exit function
set oFileStream=CreateObject("Adodb.Stream")
oFileStream.Type=1
oFileStream.Mode=3
oFileStream.Open
oUpFileStream.position=FileStart
oUpFileStream.copyto oFileStream,FileSize
oFileStream.SaveToFile FullPath,2
oFileStream.Close
set oFileStream=nothing 
SaveToFile=0
end function

'Get File Content
Public Function GetDate
oUpFileStream.Position =FileStart
GetDate=oUpFileStream.Read(FileSize)
End Function
End Class
%>