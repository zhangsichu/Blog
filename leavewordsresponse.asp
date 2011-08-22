<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="function.asp" -->
<!--#include file="md5code.asp" -->
<%
Response.ContentType = "text/html" 
Response.CharSet = "gb2312"
Dim wordAuthor,wordContent,isSaveUser,isNeedSave,userPassword,isUserLogin,isDisplayUser
wordAuthor=trim(replace(Request.Form("wordAuthor"),"'",""))
wordContent=trim(replace(Request.Form("wordContent"),"'",""))
userPassword = trim(replace(Request.Form("userPassword"),"'",""))
isSaveUser = false
isNeedSave = true
isUserLogin = false
isDisplayUser = false
If wordAuthor<>"" And wordContent<>"" Then
    'User name is or not in database.
	openAdmin
	Set rs=conn.ExeCute("SELECT TOP 1 * FROM [User] WHERE User_Name = '" & wordAuthor & "'")
    If rs.Bof And rs.Eof Then
		'This user not in database. New user.
		If Request.Form("rememberMe") = "true" And userPassword <> "" Then
		       sql="SELECT * FROM [User]"
		       Set rs=Nothing
		       Set rs=Server.CreateObject("adodb.recordset")
		       rs.Open sql,conn,1,3
		       rs.AddNew
		       rs("User_Name")=wordAuthor
		       rs("User_Password")=md5(trim(replace(Request.Form("userPassword"),"'","")))
		       rs.Update
		       rs.Close
		       Set rs=Nothing
		       isDisplayUser = true
		       isSaveUser = true
		End If 
	Else
		'This user in database. Not new user.
		'Need login.
		If md5(userPassword) = rs("User_Password") Then
			isDisplayUser = true
            isUserLogin = true
        Else
            isNeedSave = false
        End If
	End If
	
    If isNeedSave Then
        openBlog
        sql="SELECT * FROM Blog_Word"
        Set rs=Server.CreateObject("adodb.recordset")
        rs.Open sql,conn,1,3
        rs.AddNew
        rs("Word_Author")=wordAuthor
        rs("Word_Content")=wordContent
        rs("Word_Homepage")=trim(replace(Request.Form("wordHomepage"),"'",""))
        rs("Word_Email")=trim(replace(Request.Form("wordEmail"),"'",""))
        rs.Update
        
        rs.Close
        Set rs=Nothing
        sql="SELECT * FROM Blog_Count"
        
        Set rs=Server.CreateObject("adodb.recordset")
        rs.Open sql,conn,1,3
        rs("Count_Word")=rs("Count_Word")+1
        rs.Update
        rs.Close
        Set rs=Nothing
    End If
End If
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="800" align="center" valign="top">
            <br />
            <table height="24" cellspacing="0" cellpadding="0" width="97%" border="0">
                <tbody>
                    <tr>
                        <td class="content" valign="top">
                            <b>留言</b></td>
                    </tr>
                </tbody>
            </table>
            <table height="1" cellspacing="0" cellpadding="0" width="97%" class="blogLine" border="0">
                <tbody>
                    <tr>
                        <td>
                        </td>
                    </tr>
                </tbody>
            </table>
            <%
             openBlog
			 Set rs=conn.ExeCute("SELECT * FROM Blog_Word WHERE Word_Show = true Order By Word_Time")
			 Do While Not rs.Eof
            %>
            <table cellspacing="2" cellpadding="2" width="97%" border="0">
                <tbody>
                    <tr>
                        <td valign="bottom" class="blogTitle" height="23">
                            &nbsp;留言人：<%=HTMLEncode(rs("Word_Author"))%>&nbsp;&nbsp;&nbsp;留言时间：<%=rs("Word_Time")%></td>
                    </tr>
                    <tr>
                        <td valign="bottom" class="blogContentBg">
                            <table cellspacing="0" cellpadding="8" width="100%" border="0">
                                <tbody>
                                    <tr>
                                        <td height="20">
                                            <%=HTMLEncode(rs("Word_Content"))%>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <%
			rs.Movenext
  			Loop 
			Set rs=Nothing
			
  			If isSaveUser Then
  			    message = "您已经成功注册Blog. 用户名为:" & wordAuthor &". 您可以一直使用这个名字留言和评论."
  			ElseIf isUserLogin Then
  			    message = wordAuthor &" 欢迎您回来."
  			End If
			%>
			<div id="userWelcomeMessage" visible="false">
                <table cellspacing="2" cellpadding="2" width="97%" border="0">
                    <tbody>
                        <tr>
                            <td valign="bottom" class="blogTitle" height="23" style="padding-left:6px">
                                <%=message %>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <%
            If Not isNeedSave Then
                message = "本用户名:" & wordAuthor &" 已经被注册.<br />如果您以前已经成功注册了这个用户. 本次留言您所输入密码不正确.<br />如果您想注册成新用户.本用户名已经被使用.请您换一个新的用户名在尝试.<br />非常抱歉本次留言没能成功提交."
            %>
            <table cellspacing="2" cellpadding="2" width="97%" border="0">
                    <tbody>
                        <tr>
                            <td valign="bottom" class="blogTitle" height="23" style="padding-left:6px">
                                <%=message %>
                            </td>
                        </tr>
                    </tbody>
            </table>
            <%
			End If
            %>
            <table cellpadding="0" cellspacing="0" border="0" width="97%">
                <tr>
                    <td style="height: 3px">
                    </td>
                </tr>
                <tr>
                    <td style="height: 1px;" class="blogLine">
                    </td>
                </tr>
            </table>
            <table cellspacing="1" cellpadding="0" width="97%" border="0">
                <tbody>
                    <tr>
                        <td width="120" height="22" align="center" class="blogTitle">
                            大名</td>
                        <td height="22" class="blogContentBg" valign="middle">
                            <input class="input" id="wordAuthor" name="wordAuthor" />*</td>
                    </tr>
                    <tr>
                        <td width="120" height="22" align="center" class="blogTitle">
                            密码</td>
                        <td height="22" class="blogContentBg" valign="middle">
                            <input class="input" id="userPassword" name="userPassword" type="password" onkeypress="javascript:document.getElementById('rememberMe').checked = true"/> 记住我 <input id="rememberMe" type="checkbox" style="vertical-align:middle" checked /></td>
                    </tr>
                    <tr>
                        <td align="center" class="blogTitle" height="22">
                            主页</td>
                        <td class="blogContentBg" height="22">
                            <input class="input" id="wordHomepage" size="50" name="wordHomepage" /></td>
                    </tr>
                    <tr>
                        <td align="center" class="blogTitle" height="22">
                            Email</td>
                        <td class="blogContentBg" height="22">
                            <input class="input" id="wordEmail" size="50" name="wordEmail" /></td>
                    </tr>
                    <tr>
                        <td align="center" class="blogTitle" height="22">
                            留言</td>
                        <td class="blogContentBg" height="22">
                            <textarea class="input" id="wordContent" name="wordContent" rows="10" cols="60"></textarea>
                            *</td>
                    </tr>
                    <tr>
                        <td align="center" class="blogTitle" height="22">
                            &nbsp;</td>
                        <td class="blogContentBg" height="22">
                            <input type="button" name="Button" value="留言" onclick="SaveLeavewords();" />&nbsp;&nbsp;
                            <input type="button" name="Button" value="重填" onclick= "ResetLeaveworsInput()"; />
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <br />
            <input id="isDisplayUser" name="isDisplayUser" type="hidden" value="<%= LCase(isDisplayUser)%>"/>
            <input id="displayUserName" name="displayUserName" type="hidden" value="<%= wordAuthor%>"/>          
        </td>
    </tr>
</table>
<% closeDataBase %>
