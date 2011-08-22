<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="function.asp" -->
<!--#include file="ubbcode.asp" -->

<%

openBlog
%>
<html>
<head>
    <title>
        <%=Web_Title%>
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

    <script language="javascript" type="text/javascript">
    function InitialEnvironment()
    {
        //Initial all global elements
        SetGlobalVariable();
        
        //Set defualt process.
        BlogHistory.add(GetClassDisplayProcess,'defaultresponse.asp'); // means default loaded.
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
                                            <%
			If Is_ListByYear AND Request.QueryString("Blog_Year") <> "" Then
			    sql="SELECT * FROM Blog_Content WHERE Content_Year = " & cint(Request.QueryString("Blog_Year")) &" ORDER BY Content_IsInTop ASC, Content_Id DESC"
			Else
			    sql="SELECT * FROM Blog_Content ORDER BY Content_IsInTop ASC, Content_Id DESC"
			End If
			Set rs=conn.ExeCute(sql)
			Do While Not rs.Eof
                                            %>
                                            <table cellpadding="0" cellspacing="0" border="0" width="97%">
                                                <tr style="height: 5px">
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table height="24" cellspacing="0" cellpadding="0" width="97%" border="0">
                                                <tbody>
                                                    <tr>
                                                        <td class="content" valign="bottom">
                                                            <b>&nbsp;&nbsp;<%=rs("Content_Year")%>年<%=rs("Content_Month")%>月<%=rs("Content_Day")%>日</b>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table height="5" cellspacing="0" cellpadding="0" width="97%" border="0">
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table cellspacing="2" cellpadding="2" width="97%" border="0">
                                                <tbody>
                                                    <tr>
                                                        <td class="content blogTitle" valign="middle" height="28">
                                                            &nbsp;
                                                            <%
                                                                If rs("Content_IsInTop") Then
                                                                    Response.Write("<img src=""images/show_top.gif"" border=""0"" alt=""置顶""/> <b class=""showInTop"">[置顶]</b>")
                                                                End If
                                                            %>
                                                            <a href="blogview.asp?Content_Id=<%=rs("Content_Id")%>" target="_blank"><b>
                                                                <%
                                                                Response.Write(rs("Content_Title"))
                                                                %>
                                                            </b></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="bottom" class="blogContentBg" height="5">
                                                            <table cellspacing="0" cellpadding="4" width="100%" align="center" border="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>
                                                                            <div id="blogBody_<%=rs("Content_Id")%>">
                                                                                <%=UbbCode(HTMLEncode(left(rs("Content_Content"),instr(110,rs("Content_Content"),"。"))),(Not rs("Content_Ubb")),"")%>
                                                                                ......</div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr align="right">
                                                                        <td>
                                                                            <img src="images/attached.gif" width="7" height="10" />点击<a href="#" onclick="GetBlogBodyDisplay('blogbodyresponse.asp?Content_Id=<%=rs("Content_Id")%>','blogBody_<%=rs("Content_Id")%>',<%=rs("Content_Id")%>,'ClickInfo_<%=rs("Content_Id")%>'); return false;"><font
                                                                                class="blogAlertFont">此处</font></a><span id="ClickInfo_<%=rs("Content_Id")%>">阅读全文<img
                                                                                    src="images/content_unfold.gif" /></span>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div id="blogComment_<%=rs("Content_Id")%>">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="postFoot blogTitle" valign="bottom" align="right" height="21">
                                                            <%
                                                        CommentTitle = "Comment"
                                                            If rs("Content_Comment") > 0 Then
                                                            CommentTitle = "Comments"
                                                        End If
                                                            %>
                                                            Posted @
                                                            <%=rs("Content_Time")%>
                                                            | Hits (<font class="blogAlertFont"><%=rs("Content_Count")%></font>) | <a href="#"
                                                                onclick="GetBlogViewDisplay('blogviewresponse.asp?Content_Id=<%=rs("Content_Id")%>'); return false;">
                                                                <%=CommentTitle%>
                                                                (<font class="blogAlertFont"><%=rs("Content_Comment")%></font>)</a>&nbsp;
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <br />
                                            <%
			rs.Movenext
  			Loop 
  			Set rs=Nothing
                                            %>
                                            &nbsp;
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
