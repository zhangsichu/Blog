<!--#include file="config.asp" -->
<!--#include file="upfile.asp" -->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link href="images/admin.css" rel="stylesheet" type="text/css" />
    <title>Attachment</title>
</head>
<body style="background-image: none;
    background-color: #ffffff">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <%
If Session("Admin") <> Admin_LoginMark Then
	Response.Write "你不能上传文件"
Else
	If Request.QueryString("action")="upLoad" Then
	  Response.Write("<td>")
		Dim upObject
		Set upObject=Server.CreateObject("Scripting.FileSystemObject")
		Dim D_Name,F_Name
		D_Name="month_"&DateToStr(Now(),"YYYYMM","")
		If upObject.FolderExists(Server.MapPath(Attachment_Path&D_Name))=False Then
			upObject.CreateFolder Server.MapPath(Attachment_Path&D_Name)
		End If
		Dim FileUP
		Set FileUP=New Upload_File
		FileUP.GetDate(-1)
		Dim F_File
		Set F_File=FileUP.File("File")
		F_Name=Left(DateToStr(Now(),"DD_hhmmss","")&"_"&RandomString(4)&RemoveSpecialChars(F_File.FileName),120)
		IF F_File.FileSize > Int(UP_FileSize) Then
			Response.Write("<a href='javascript:history.go(-1);'>文件大小超标 返回</a>")
		ElseIF IsvalidFile(UCase(F_File.FileExt)) = False Then
			Response.Write("<a href='javascript:history.go(-1);'>不支持的文件格式 返回</a>")
		Else
			F_File.SaveToFile Server.MapPath(Attachment_Path&D_Name&"/"&F_Name)
			Select Case F_File.FileExt
			Case "gif","jpg","bmp","png","tif","GIF","JPG","BMP","PNG","TIF"
				Response.Write("<script language=""javascript"" type=""text/javascript"">top.document.Blogform.contentContent.value+='\n[img]"&Attachment_Path&D_Name&"/"&F_Name&"[/img]'</script>")
			Case "swf","SWF"
				Response.Write("<script language=""javascript"" type=""text/javascript"">top.document.Blogform.contentContent.value+='\n[swf]"&Attachment_Path&D_Name&"/"&F_Name&"[/swf]'</script>")
			Case "wma","mp3","avi","wmv","asf","WMA","MP3","AVI","WMV","ASF"
				Response.Write("<script language=""javascript"" type=""text/javascript"">top.document.Blogform.contentContent.value+='\n[wmp]"&Attachment_Path&D_Name&"/"&F_Name&"[/wmp]'</script>")
			Case "ra","rm","rmvb","RA","RM","RMVB"
				Response.Write("<script language=""javascript"" type=""text/javascript"">top.document.Blogform.contentContent.value+='\n[rm]"&Attachment_Path&D_Name&"/"&F_Name&"[/rm]'</script>")
			Case "mov","MOV"
				Response.Write("<script language=""javascript"" type=""text/javascript"">top.document.Blogform.contentContent.value+='\n[qt]"&Attachment_Path&D_Name&"/"&F_Name&"[/qt]'</script>")
			Case Else
				Response.Write("<script language=""javascript"" type=""text/javascript"">top.document.Blogform.contentContent.value+='\n[file="&Attachment_Path&D_Name&"/"&F_Name&"]Click to Download[/file]'</script>")
			End Select
			Response.Write("<a href='javascript:history.go(-1);'>文件已上传 返回</a>")
		End IF
		Set FileUP=Nothing
		Set upObject=Nothing
		Response.Write("</td>")
	Else
		Response.Write("<form enctype='multipart/form-data' method='post' action='attachment.asp?action=upLoad'><td><input name='File' type='file' style='font-size:12px;' size='50'>&nbsp;<input type='submit' name='Submit' value=' 上传 '></td></form>")
	end if
End IF

Function RandomString(Length)
	Dim i, tempS
	tempS = "abcdefghijklmnopqrstuvwxyz1234567890" 
	RandomString = ""
	If isNumeric(Length) = False Then 
		Exit Function 
	End If 
	For i = 1 to Length 
		Randomize 
		RandomString = RandomString & Mid(tempS,Int((Len(tempS) * Rnd) + 1),1)
	Next 
End Function 

Function DateToStr(byRef DateTime,byVal ShowType, byVal TimeZone)
	Dim DateYear,DateMonth,DateDay,DateHour,DateMinute,DateSecond,DateAMPM
	DateToStr=ShowType
	DateYear=Year(DateTime)
	DateMonth=Month(DateTime)
	DateDay=Day(DateTime)
	DateHour=Hour(DateTime)
	DateMinute=Minute(DateTime)
	DateSecond=Second(DateTime)
	IF Len(DateMonth)<2 Then DateMonth="0"&DateMonth
	IF Len(DateDay)<2 Then DateDay="0"&DateDay
	If instr(ShowType,"AMPM")>0Then
		If DateHour>12 Then
			DateToStr=Replace(DateToStr,"AMPM","PM")
			DateHour=DateHour-12
		Else
			DateToStr=Replace(DateToStr,"AMPM","AM")
		End IF
	ElseIF Len(DateHour)<2 Then
		DateHour="0"&DateHour	
	End IF
	IF Len(DateMinute)<2 Then DateMinute="0"&DateMinute
	IF Len(DateSecond)<2 Then DateSecond="0"&DateSecond

	DateToStr=Replace(DateToStr,"YYYY",DateYear)
	DateToStr=Replace(DateToStr,"YY",Right(DateYear,2))
	DateToStr=Replace(DateToStr,"MM",DateMonth)
	DateToStr=Replace(DateToStr,"DD",DateDay)
	DateToStr=Replace(DateToStr,"hh",DateHour)
	DateToStr=Replace(DateToStr,"mm",DateMinute)
	DateToStr=Replace(DateToStr,"ss",DateSecond)
	DateToStr=Replace(DateToStr,"TZD",TimeZone)

End Function

'Check File name
Function RemoveSpecialChars(str)
	Dim re
	Set re=new RegExp
	re.IgnoreCase =true
	re.Global=True
	re.Pattern="[^_\.a-zA-Z\d]"
	RemoveSpecialChars=re.Replace(str,"")
	set re=nothing
End Function

'Check upload file types
Function IsvalidFile(File_Type)
	Dim GName,UP_FileType
	UP_FileType=Split(UP_FileTypes,",")
	IsvalidFile = False
	For Each GName in UP_FileType
		If File_Type = GName Then
			IsvalidFile = True
			Exit For
		End If
	Next
End Function
            %>
        </tr>
    </table>
</body>
</html>
