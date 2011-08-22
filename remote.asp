<%
Dim Admin_RemoteMark
Admin_RemoteMark = "ADMINREMOTEMARK"

If Request.QueryString("action") = "logoff" Then
    Session("Admin_Remote")=""
    Response.Redirect("remote.asp")
End If

If Request.Form("adminPassword")<>"" Then
	If Request.Form("adminPassword") = "ZessonTest" Then
	    Session("Admin_Remote")=Admin_RemoteMark
		Session.Timeout=50
	Else
	    Session("Admin_Remote")=""
	End If
End If

If Session("Admin_Remote")<>Admin_RemoteMark Then
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

    <script type="text/javascript">
function checkinput(){
    if(document.loginForm.adminPassword.value==0){
        alert("请输入管理员密码");
        return false;
    }
    return true;
}
    </script>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 99%">
        <tr>
            <td valign="middle">
                <form name="loginForm" method="post" onsubmit="return checkinput()" action="">
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tableBlack">
                        <tr>
                            <td align="center" valign="middle" class="loginHeader">
                                管理员登陆</td>
                        </tr>
                        <tr>
                            <td height="24" align="center" valign="middle" class="adminHeader">
                                管理员密码：<input type="password" name="adminPassword" id="adminPassword" />&nbsp;<input
                                    type="submit" name="Submit" id="Submit1" value="登陆" />
                            </td>
                        </tr>
                    </table>
                </form>
            </td>
        </tr>
    </table>
</body>
</html>
<%
Else
    Dim xmlRequest, responseData, url
    url = Request.Form("remoteUrl")
    If url <> "" Then
      Set xmlRequest = Server.CreateObject("MSXML2.ServerXMLHTTP")
      xmlRequest.Open "GET", url, True
      Call xmlRequest.Send()
      On Error Resume Next
      
      If xmlRequest.readyState <> 4 Then
        xmlRequest.waitForResponse 3
      End If
      
      If Err.Number <> 0 Then
        responseData = "Remote server error,please check other similar links. ErrorNumer:" & Err.Number
      Else
        If (xmlRequest.readyState <> 4) Or (xmlRequest.Status <> 200) Then
              xmlRequest.Abort
              responseData = "Problem communicating with remote server..."
         Else
              If Request.Form("transGB2312") = "on" Then
                responseData = BytesToBstr(xmlRequest.ResponseBody,"gb2312")
              ElseIf Request.Form("downloadFile") = "on" Then
                Response.AddHeader "Content-Disposition","attachment;filename=File.rar"
                Response.ContentType = "application/octet-stream"
                Response.BinaryWrite xmlRequest.responseBody
              Else
                responseData = xmlRequest.ResponseText
              End If
         End If
      End If
      Set xmlRequest = Nothing
    End If
%>
<div style="text-align: right; margin: 0px 10px 0px 0px; font-size: 12px; vertical-align: middle;">
<script type="text/javascript">
function checkinput(){
    if(document.remoteForm.remoteUrl.value.length<=7){
        alert("Please input a available Url.");
        return false;
    }
    return true;
}
</script>
    <form name="remoteForm" method="post" onsubmit="return checkinput()" action="" style="vertical-align: middle;">
        URL:<input class="input" id="remoteUrl" name="remoteUrl" style="width: 400px" value="http://" />
        <input type="submit" name="Submit" id="Submit" value="GO" />
        GB2312<input id="transGB2312" name="transGB2312" type="checkbox" /> DownloadFile <input id="downloadFile" name="downloadFile" type="checkbox" />
        <a href="remote.asp?action=logoff">Logoff</a>
    </form>
</div>
<%
    Response.Write(responseData)
End If

Function BytesToBstr(body,Cset)
      Dim objectStream
      set objectStream = Server.CreateObject("adodb.stream")
      objectStream.Type = 1
      objectStream.Mode =3
      objectStream.Open
      objectStream.Write body
      objectStream.Position = 0
      objectStream.Type = 2
      objectStream.Charset = Cset
      BytesToBstr = objectStream.ReadText
      objectStream.Close
      set objectStream = Nothing
End Function
%>
