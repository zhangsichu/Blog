<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="ubbcode.asp" -->
<!--#include file="function.asp" -->
<!--#include file="md5code.asp" -->
<%
Response.ContentType = "text/html" 
Response.CharSet = "gb2312"

If Request.QueryString("Content_Id")="" Or (Not IsNumeric(Request.QueryString("Content_Id"))) Then Response.End() End If

Dim commentAuthor,isSaveUser,isNeedSave,userPassword,isUserLogin,isDisplayUser
isSaveUser = false
isNeedSave = true
isUserLogin = false
isDisplayUser = false
userPassword = trim(replace(Request.Form("userPassword"),"'",""))
commentAuthor = trim(replace(Request.Form("commentAuthor"),"'",""))
If Request.Form("action")="newComment" Then
    'User name is or not in database.
    openAdmin
    Set rs=conn.ExeCute("SELECT TOP 1 * FROM [User] WHERE User_Name = '" & commentAuthor & "'")	
    If rs.Bof And rs.Eof Then
		'This user not in database. New user.
		If Request.Form("rememberMe") = "true" And userPassword <> "" Then
		    sql="SELECT * FROM [User]"
		    Set rs=Nothing
		    Set rs=Server.CreateObject("adodb.recordset")
		    rs.Open sql,conn,1,3
		    rs.AddNew
		    rs("User_Name")=commentAuthor
		    rs("User_Password")=md5(trim(replace(Request.Form("userPassword"),"'","")))
		    rs.Update
		    rs.Close
		    Set rs=Nothing
		    isDisplayUser = true
		    isSaveUser = true
		End If
	Else
		'This user in database.Not a new user.
		If md5(userPassword) = rs("User_Password") Then
            isDisplayUser = true
            isUserLogin = true
        Else
            isNeedSave = false
        End If
	End If
	
    If isNeedSave Then
        openBlog
		sql="SELECT * FROM Blog_Comment"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs.AddNew
		rs("Content_Id")=Request.QueryString("Content_Id")
		rs("Comment_Title")=trim(replace(Request.Form("commentTitle"),"'",""))
		rs("Comment_Author")=trim(replace(Request.Form("commentAuthor"),"'",""))
		rs("Comment_Content")=trim(replace(Request.Form("commentContent"),"'",""))
		rs("Comment_Ip")=replace(Request.ServerVariables("REMOTE_ADDR"),"'","")
		rs.Update
		rs.Close
		Set rs=Nothing
		
		sql="SELECT * FROM Blog_Content WHERE Content_Id = "&Request.QueryString("Content_Id")
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Content_Comment")=rs("Content_Comment")+1
		rs.Update
		rs.Close
		Set rs=Nothing
		
		sql="SELECT * FROM Blog_Count"
		Set rs=Server.CreateObject("adodb.recordset")
		rs.Open sql,conn,1,3
		rs("Count_Comment")=rs("Count_Comment")+1
		rs.Update
		rs.Close
		Set rs=Nothing
	End If
End If
If Request.Form("action")<>"newComment" Then
    openBlog
    sql="SELECT * FROM Blog_Content WHERE Content_Id = "&Request.QueryString("Content_Id")
    Set rs=Server.CreateObject("adodb.recordset")
    rs.Open sql,conn,1,3
    rs("Content_Count")=rs("Content_Count")+1
    rs.Update
    rs.Close
    Set rs=Nothing
End If
openBlog
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="950" valign="top" align="center">
            <br />
            <table cellspacing="2" cellpadding="2" width="97%" border="0">
                <tbody>
                    <tr>
                        <%Set rs=conn.ExeCute("SELECT * FROM Blog_Content WHERE Content_Id = "&Request.QueryString("Content_Id"))
			Dim commentTitle
			commentTitle=rs("Content_Title")
                        %>
                        <td valign="bottom" height="28" class="blogTitle">
                            &nbsp;&nbsp;<b class="content"><font class="contentTitle"><%=rs("Content_Title")%></font></b>
                        </td>
                    </tr>
                    <tr>
                        <td valign="bottom" class="blogContentBg" height="5">
                            <table cellspacing="0" cellpadding="8" width="100%" align="center" border="0">
                                <tbody>
                                    <tr>
                                        <td>
                                            <table cellspacing="1" cellpadding="1" width="100%" border="0">
                                                <tbody>
                                                    <tr>
                                                        <td width="36" height="25">
                                                            <img src="images/emotions/<%=rs("Content_Emotion")%>.gif" /></td>
                                                        <td width="304" height="25">
                                                            <img src="images/weather/<%=rs("Content_Weather")%>.gif" /></td>
                                                        <td align="right">
                                                            字体大小 [<a href="javascript:FontZoom(16)">大</a> <a href="javascript:FontZoom(14)">中</a>
                                                            <a href="javascript:FontZoom(12)">小</a>]
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table height="1" cellspacing="0" cellpadding="0" width="100%" class="blogTitle"
                                                border="0">
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <br />
                                            <span class="content" id="fontzoom">
                                                <%=UbbCode(HTMLEncode(rs("Content_Content")),(Not rs("Content_Ubb")),"")%>
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="postFoot blogTitle" valign="bottom" align="right" height="20">
                            <table height="20" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tbody>
                                    <tr>
                                        <td width="7%">
                                            &nbsp;</td>
                                        <td class="postFoot" align="right" width="93%">
                                            <%
                                        CommentLine = "Comment"
                                            If rs("Content_Comment") > 0 Then
                                            CommentLine = "Comments"
                                        End If
                                            %>
                                            Posted @
                                            <%=rs("Content_Time")%>
                                            | Hits (<font class="blogAlertFont"><%=rs("Content_Count")%></font>) |
                                            <%=CommentLine %>
                                            (<font class="blogAlertFont"><%=rs("Content_Comment")%></font>)&nbsp;
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <%Set rs=Nothing
			Set rs=conn.ExeCute("SELECT * FROM Blog_Comment WHERE Content_Id = "&Request.QueryString("Content_Id") &" ORDER BY Comment_Id DESC")
			If Not rs.Eof And Not rs.Bof Then
            %>
            <table height="24" cellspacing="0" cellpadding="0" width="97%" border="0">
                <tbody>
                    <tr>
                        <td class="content" valign="top">
                            <b>&nbsp;&nbsp;Comment</b></td>
                    </tr>
                </tbody>
            </table>
            <table height="1" cellspacing="0" cellpadding="0" width="97%" class="blogTitle" border="0">
                <tbody>
                    <tr>
                        <td>
                        </td>
                    </tr>
                </tbody>
            </table>
            <%
			End If
			Do While Not rs.Eof
            %>
            <table cellspacing="2" cellpadding="2" width="97%" border="0">
                <tbody>
                    <tr>
                        <td valign="bottom" height="23" class="blogTitle">
                            &nbsp;<%=HTMLEncode(rs("Comment_Title"))%>&nbsp;&nbsp;<%=rs("Comment_Time")%>&nbsp;&nbsp;<%=HTMLEncode(rs("Comment_Author"))%>
                        </td>
                    </tr>
                    <tr>
                        <td valign="bottom" class="blogContentBg">
                            <table cellspacing="0" cellpadding="8" width="100%" border="0">
                                <tbody>
                                    <tr>
                                        <td height="20">
                                            <%=HTMLEncode(rs("Comment_Content"))%>
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
  			    message = "您已经成功注册Blog. 用户名为:" & commentAuthor &". 您可以一直使用这个名字留言和评论."
  			ElseIf isUserLogin Then
  			    message = commentAuthor &" 欢迎您回来."
  			End If
            %>
            <div id="userWelcomeMessage" visible="false">
                <table cellspacing="2" cellpadding="2" width="97%" border="0">
                    <tbody>
                        <tr>
                            <td valign="bottom" class="blogTitle" height="23" style="padding-left: 6px">
                                <%=message %>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <%
            If Not isNeedSave Then
                message = "本用户名:" & commentAuthor &" 已经被注册.<br />如果您以前已经成功注册了这个用户. 本次评论您所输入密码不正确.<br />如果您想注册成新用户.本用户名已经被使用.请您换一个新的用户名在尝试.<br />非常抱歉本次评论没能成功提交."
            %>
            <div id="userErrorMessage">
                <table cellspacing="2" cellpadding="2" width="97%" border="0">
                    <tbody>
                        <tr>
                            <td valign="bottom" class="blogTitle" height="23" style="padding-left: 6px">
                                <%=message %>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <%
			End If
            %>
            <table height="24" cellspacing="0" cellpadding="0" width="97%" border="0">
                <tbody>
                    <tr>
                        <td class="content" valign="top">
                            <a name="postComment"></a>&nbsp;&nbsp;<b>Post Comment</b></td>
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
            <table cellspacing="1" cellpadding="0" width="97%" border="0">
                <tbody>
                    <tr>
                        <td width="20%" height="22" align="center" class="blogTitle">
                            标题</td>
                        <td width="80%" height="22" class="blogContentBg">
                            <input type="text" size="50" name="commentTitle" id="commentTitle" value="#re:<%=commentTitle%>" />*</td>
                    </tr>
                    <tr>
                        <td align="center" class="blogTitle" height="22">
                            作者</td>
                        <td class="blogContentBg" height="22">
                            <input type="text" name="commentAuthor" id="commentAuthor" />*</td>
                    </tr>
                    <tr>
                        <td align="center" class="blogTitle" height="22">
                            密码</td>
                        <td class="blogContentBg" height="22">
                            <input class="input" id="userPassword" name="userPassword" type="password" />
                            记住我
                            <input id="rememberMe" type="checkbox" style="vertical-align: middle" checked /></td>
                    </tr>
                    <tr>
                        <td align="center" class="blogTitle" height="22">
                            评论</td>
                        <td class="blogContentBg" height="22">
                            <textarea name="commentContent" id="commentContent" rows="10" cols="60"></textarea>*</td>
                    </tr>
                    <tr>
                        <td align="center" class="blogTitle" height="22">
                            &nbsp;</td>
                        <td class="blogContentBg" height="22">
                            <input type="button" value="发表" onclick="SaveComment(); return false;" />&nbsp;&nbsp;<input
                                type="button" value="重填" onclick="ResetCommentInput(); return false;" /><input id="contentId"
                                    type="hidden" value="<% =Request.QueryString("Content_Id")%>" />
                        </td>
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
            <br />
            <br />
            <input id="isDisplayUser" name="isDisplayUser" type="hidden" value="<%= LCase(isDisplayUser)%>" />
            <input id="displayUserName" name="displayUserName" type="hidden" value="<%= commentAuthor%>" />
        </td>
    </tr>
</table>
<%
closeDataBase
%>
