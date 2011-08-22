<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="md5code.asp" -->
<%
openAdmin 
If Request.QueryString("action")="Login" And Request.Form("adminPassword")<>"" Then
	Dim Admin_Login
	Set Admin_Login=conn.ExeCute("SELECT Admin_Password FROM Admin WHERE Admin_Password='"&md5(Request.Form("adminPassword"))&"'")
	If Admin_Login.Eof And Admin_Login.Bof Then
		Session("Admin")=""
	Else
		Session("Admin")=Admin_LoginMark
		Session.Timeout=50
		Response.Redirect("admin.asp?position=newBlog")
	End If
	Set Admin_Login=Nothing
End If
closeDataBase
If Request.QueryString("action")="Logout" Then
		Session("Admin")=""
End If
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
                <form name="loginForm" method="post" onsubmit="return checkinput()" action="login.asp?action=Login">
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tableBlack">
                        <tr>
                            <td align="center" valign="middle" class="loginHeader">
                                管理员登陆</td>
                        </tr>
                        <tr>
                            <td height="24" align="center" valign="middle" class="adminHeader">
                                管理员密码：<input type="password" name="adminPassword" id="adminPassword" />&nbsp;<input
                                    type="submit" name="Submit" id="Submit" value="登陆" />
                            </td>
                        </tr>
                    </table>
                </form>
            </td>
        </tr>
    </table>
</body>
</html>
