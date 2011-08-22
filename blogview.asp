<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="function.asp" -->
<!--#include file="ubbcode.asp" -->
<!--#include file="md5code.asp" -->
<%
If Request.QueryString("Content_Id")="" Then 
    Response.Redirect("default.asp") 
End If

Dim commentTitle
openBlog
sql="SELECT * FROM Blog_Content WHERE Content_Id = "&cint(Request.QueryString("Content_Id"))
Set rs=Server.CreateObject("adodb.recordset")
rs.Open sql,conn,1,3
rs("Content_Count")=rs("Content_Count")+1
commentTitle=rs("Content_Title")
rs.Update
rs.Close
Set rs=Nothing
%>
<html>
<head>
    <title>
        <%=commentTitle%>
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link href="images/blog.css" type="text/css" rel="stylesheet" />
    <%
        skinCss = "<link id=""skinCss"" type=""text/css"" rel=""stylesheet"" href=""" & Default_StyleSheet &""" />" 
        If Request.Cookies("CurrentSkin") <> "" Then
            skinCss = "<link id=""skinCss"" type=""text/css"" rel=""stylesheet"" href="""& Request.Cookies("CurrentSkin") &""" />" 
        End If
        Response.Write(skinCss)
    %>

    <script language="javascript" type="text/javascript" src="blogajax.js"></script>

    <script language="javascript" type="text/javascript" src="prototype.js"></script>

    <script language="javascript" type="text/javascript" src="effects.js"></script>

    <script language="javascript" type="text/javascript" src="function.js"></script>

    <script language="javascript" type="text/javascript" src="history.js"></script>

    <script language="javascript" type="text/javascript" src="default.js"></script>

    <script type="text/javascript">
    function InitialEnvironment()
    {
        //Initial all global elements.
        SetGlobalVariable();
        
        //Set blog view history.
        BlogHistory.add(GetBlogViewDisplayProcess,'blogviewresponse.asp?Content_Id=<%=Request.QueryString("Content_Id")%>');
        SetHistoryControlStatus();
        
        //Check the loading content.
        ModifyLoadingContent();
        
        //Display user name from cookie.
        DisplayUser();
        
        //CloseLoading.
        FadeLoadingContent();
     }
    </script>

</head>
<body>
    <div id="loadingContent" class="loadingContent">
        <table width="100%">
            <tr align="center" valign="middle">
                <td>
                    <div class="loadingImage">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                <!--#include file="header.asp"-->
            </td>
        </tr>
        <tr>
            <td>
                <table height="4" cellspacing="0" cellpadding="0" width="100%" class="blogLine" border="0">
                    <tbody>
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" width="203">
                            <!--#include file="sidebar.asp"-->
                        </td>
                        <td width="1" class="blogLine">
                        </td>
                        <td valign="top">
                            <table cellpadding="0" cellspacing="0" border="0" width="97%" style="height: 33">
                                <tr style="height: 10px;">
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle">
                                        <!--#include file="controlbar.asp"-->
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="1000px" valign="top" align="center">
                                        <div id="mainContent">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td height="950" valign="top" align="center">
                                                        <br />
                                                        <table cellspacing="2" cellpadding="2" width="97%" border="0">
                                                            <tbody>
                                                                <tr>
                                                                    <%
                                                                    Set rs=conn.ExeCute("SELECT * FROM Blog_Content WHERE Content_Id = "&cint(Request.QueryString("Content_Id")))
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
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table height="4" cellspacing="0" cellpadding="0" width="100%" class="blogLine" border="0">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <div style="text-align: right; margin-top: 10px; margin-right: 10px">
                    <img src="images/firefox_ok.gif" alt="Stable in Firefox 1.5 2.0" /><img src="images/ie_ok.gif"
                        alt="Stable in IE6 IE7" /><img src="images/mozilla_ok.gif" alt="Stable in Mozilla" /><img
                            src="images/netscape_ok.gif" alt="Stable in Netscape" /></div>
            </td>
        </tr>
        <tr>
            <td>
                <!--#include file="footer.asp"-->
            </td>
        </tr>
    </table>
    <script type="text/javascript">
      InitialEnvironment();
    </script>
</body>
</html>
<% closeDataBase %>
