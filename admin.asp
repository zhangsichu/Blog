<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="admin_body.asp" -->
<!--#include file="md5code.asp" -->
<!--#include file="function.asp" -->
<%
If Session("Admin") <> Admin_LoginMark Then Response.Redirect("login.asp") End If
%>
<html>
<head>
    <title>
        <%=Web_Title%>
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link href="images/admin.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <%
openBlog
Select Case Request.Form("action")
	Case "newBlog"
		sql="SELECT * FROM Blog_Content"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs.AddNew
		rs("Content_Title")=trim(replace(Request.Form("contentTitle"),"'",""))
		rs("Content_Content")=trim(replace(Request.Form("contentContent"),"'",""))
		rs("Content_Emotion")=cint(Request.Form("blogEmotion"))
		rs("Content_Weather")=cint(Request.Form("blogWeather"))
		rs("Content_Class")=cint(Request.Form("blogClass"))
		rs("Content_Year")=Year(Now())
		rs("Content_Month")=Month(Now())
		rs("Content_Day")=Cint(Day(Now()))
		If Request.Form("contentTopic")="on" Then rs("Content_Topic") = true End If
		If Request.Form("contentUbb")<>"on" Then rs("Content_Ubb")=false End If
		If Request.Form("contentIsInTop")="on" Then rs("Content_IsInTop")=true End If
		rs.Update
		rs.Close
		Set rs=Nothing
		
		sql="SELECT * FROM Blog_Class WHERE Class_Id = "&cint(Request.Form("blogClass"))
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Class_Count")=rs("Class_Count")+1
		rs.Update
		rs.Close
		Set rs=Nothing
		
		sql="SELECT * FROM Blog_Count"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Count_Content")=rs("Count_Content")+1
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listBlog"
	Case "editBlog"
		sql="SELECT * FROM Blog_Content WHERE Content_Id = "&Request.Form("contentId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Content_Title")=trim(replace(Request.Form("contentTitle"),"'",""))
		rs("Content_Content")=trim(replace(Request.Form("contentContent"),"'",""))
		rs("Content_Emotion")=cint(Request.Form("blogEmotion"))
		rs("Content_Weather")=cint(Request.Form("blogWeather"))
		If rs("Content_Class")<>cint(Request.Form("blogClass")) Then
			sql="SELECT * FROM Blog_Class WHERE Class_Id = "&cint(Request.Form("blogClass"))
			Set rsclass=Server.CreateObject("adodb.recordset")
			rsclass.Open sql,conn,1,3
			rsclass("Class_Count")=rsclass("Class_Count")+1
			rsclass.Update
			rsclass.Close
			Set rsclass=Nothing
			sql="SELECT * FROM Blog_Class WHERE Class_Id = "&rs("Content_Class")
			Set rsclass=Server.CreateObject("adodb.recordset")
			rsclass.Open sql,conn,1,3
			rsclass("Class_Count")=rsclass("Class_Count")-1
			rsclass.Update
			rsclass.Close
			Set rsclass=Nothing	
			rs("Content_Class")=cint(Request.Form("blogClass"))
		End If
		If Request.Form("contentTopic")="on" Then rs("Content_Topic") = true Else rs("Content_Topic") = false End If
		If Request.Form("contentUbb")<>"on" Then rs("Content_Ubb")=false Else rs("Content_Ubb")=true End If
	    If Request.Form("contentIsInTop")="on" Then rs("Content_IsInTop")=true Else rs("Content_IsInTop")=false End If
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listBlog"
	Case "delBlog"
		sql="SELECT * FROM Blog_Content WHERE Content_Id = "&Request.Form("contentId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs.Delete
		rs.Close
		Set rs=Nothing
		
		sql="SELECT * FROM Blog_Class WHERE Class_Id = "&cint(Request.Form("blogClass"))
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Class_Count")=rs("Class_Count")-1
		rs.Update
		rs.Close
		Set rs=Nothing
		
		sql="SELECT * FROM Blog_Count"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Count_Content")=rs("Count_Content")-1
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listBlog"
	Case "newClass"
		sql="SELECT * FROM Blog_Class"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs.AddNew
		rs("Class_Name")=trim(replace(Request.Form("className"),"'",""))
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listClass"
	Case "editClass"
		sql="SELECT * FROM Blog_Class WHERE Class_Id = "&Request.Form("classId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Class_Name")=trim(replace(Request.Form("className"),"'",""))
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listClass"
	Case "delClass"
		sql="SELECT * FROM Blog_Class WHERE Class_Id = "&Request.Form("classId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs.Delete
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listClass"
	Case "editComment"
		sql="SELECT * FROM Blog_Comment WHERE Comment_Id = "&Request.Form("commentId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Comment_Title")=trim(replace(Request.Form("commentTitle"),"'",""))
		rs("Comment_Author")=trim(replace(Request.Form("commentAuthor"),"'",""))
		rs("Comment_Content")=trim(replace(Request.Form("commentContent"),"'",""))
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listComment&Content_Id="&Request.Form("contentId")
	Case "delComment"
		sql="SELECT * FROM Blog_Comment WHERE Comment_Id = "&Request.Form("commentId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs.Delete
		rs.Close
		Set rs=Nothing
		sql="SELECT * FROM Blog_Count"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Count_Comment")=rs("Count_Comment")-1
		rs.Update
		rs.Close
		Set rs=Nothing
		sql="SELECT * FROM Blog_Content WHERE Content_Id = "&Request.Form("contentId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Content_Comment")=rs("Content_Comment")-1
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listComment&Content_Id="&Request.Form("contentId")
	Case "listWord"
		Dim wordIds
		wordIds = Request.Form("wordIds")
		Dim items
		items = Split(wordIds,",")
		Set rs=Server.CreateObject("adodb.recordset")
		For Each item In items
		If item <> "" Then
			sql="DELETE FROM Blog_Word WHERE Word_Id = "&item
			rs.open sql,conn,1,3
		End If
		Next
		'rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listWord"
	Case "editWord"
		sql="SELECT * FROM Blog_Word WHERE Word_Id = "&Request.Form("wordId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Word_Homepage")=trim(replace(Request.Form("wordHomepage"),"'",""))
		rs("Word_Email")=trim(replace(Request.Form("wordEmail"),"'",""))
		rs("Word_Author")=trim(replace(Request.Form("wordAuthor"),"'",""))
		rs("Word_Content")=trim(replace(Request.Form("wordContent"),"'",""))
		If Request.Form("wordShow")="on" Then rs("Word_Show") = true Else rs("Word_Show") = false End If
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listWord"
	Case "delWord"
		sql="SELECT * FROM Blog_Word WHERE Word_Id = "&Request.Form("wordId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs.Delete
		rs.Close
		Set rs=Nothing
		sql="SELECT * FROM Blog_Count"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Count_Word")=rs("Count_Word")-1
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listWord"
	Case "editUser"
	    openAdmin
		sql="SELECT * FROM [User] WHERE User_Id = "&Request.Form("userId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("User_Name")=trim(replace(Request.Form("userName"),"'",""))
		If trim(replace(Request.Form("userPassword"),"'","")) <> "" Then
		    rs("User_Password")=md5(trim(replace(Request.Form("userPassword"),"'","")))
		End If
		rs.Update
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listUser"
	Case "delUser"
		openAdmin
		sql="SELECT * FROM [User] WHERE User_Id = "&Request.Form("userId")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs.Delete
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=listUser"
	Case "changePassword"
		openAdmin
		sql="SELECT * FROM Admin where Admin_Password='"&md5(request.form("oldPassword"))&"'"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		If rs.eof And rs.bof Then
			Response.Redirect "login.asp?action=Logout"
		Else
			rs("Admin_Password")=md5(request.form("newPassword"))
			rs.Update
		End If
		rs.Close
		Set rs=Nothing
		Response.Redirect "admin.asp?position=newBlog"
	Case Else
		call admin_body()
	End Select
closeDataBase
    %>
</body>
</html>
