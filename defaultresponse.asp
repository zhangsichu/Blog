<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="function.asp" -->
<!--#include file="ubbcode.asp" -->
<%
Response.ContentType = "text/html" 
Response.CharSet = "gb2312"
%>
<% openBlog %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="800" valign="top" align="center">
            <%
			Select Case Request.QueryString("viewType")
			Case "byClass"
			sql="SELECT * FROM Blog_Content WHERE Content_Class = "&cint(Request.QueryString("Class_Id"))&" ORDER BY Content_IsInTop ASC, Content_Id DESC"
			Case "byYear"
			sql="SELECT * FROM Blog_Content WHERE Content_Year = "&cint(Request.QueryString("blogYear"))&" ORDER BY Content_IsInTop ASC, Content_Id DESC"
			Case "byMonth"
			sql="SELECT * FROM Blog_Content WHERE Content_Year = "&cint(Request.QueryString("blogYear"))&" AND Content_Month = "&cint(Request.QueryString("blogMonth"))&" ORDER BY Content_IsInTop ASC, Content_Id DESC"
			Case "byDay"
			sql="SELECT * FROM Blog_Content WHERE Content_Year = "&cint(Request.QueryString("blogYear"))&" AND Content_Month = "&cint(Request.QueryString("blogMonth"))&" AND Content_Day = "&cint(Request.QueryString("blogDay"))&" ORDER BY Content_IsInTop ASC, Content_Id DESC"
			Case Else
			If Is_ListByYear Then
      	  sql="SELECT * FROM Blog_Content WHERE Content_Year BETWEEN " & Year(Date()) & " AND " & Year(Date())-3 & " ORDER BY Content_IsInTop ASC, Content_Id DESC"
			Else
			    sql="SELECT * FROM Blog_Content ORDER BY Content_IsInTop ASC, Content_Id DESC"
			End If
			End Select
			Set rs=conn.ExeCute(sql)
			Do While Not rs.Eof
            %>
            <table height="5" cellspacing="0" cellpadding="0" width="97%" border="0">
                <tbody>
                    <tr>
                        <td>
                        </td>
                    </tr>
                </tbody>
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
        </td>
    </tr>
</table>
<% closeDataBase %>
