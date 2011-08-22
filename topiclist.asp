<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<% openBlog %>
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
    <script language="javascript" type="text/javascript" src="prototype.js"></script>

    <script language="javascript" type="text/javascript" src="effects.js"></script>

    <script type="text/javascript" src="blogajax.js"></script>

    <script type="text/javascript" src="default.js"></script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <table height="5" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tbody>
            <tr>
                <td>
                </td>
            </tr>
        </tbody>
    </table>
    <%
   Set rs=conn.ExeCute("select * from Blog_Content Where Content_Topic = true order by Content_Id desc")
   Do While Not rs.Eof
    %>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tbody>
            <tr>
                <td class="postTime" height="8">
                    <%=rs("Content_Month")%>
                    -<%=rs("Content_Day")%>-<%=rs("Content_Year")%></td>
            </tr>
            <tr>
                <td>
                    <%
		     Set rsclass=conn.ExeCute("select * from Blog_Class Where Class_Id = "&rs("Content_Class"))
                    %>
                    [<b><a class="class" href="#" onclick="GetClassDisplay('defaultresponse.asp?viewType=byClass&Class_Id=<%=rsclass("Class_Id")%>'); return false;"><%=rsclass("Class_Name")%></a></b>]
                </td>
            </tr>
            <tr>
                <td height="25">
                    &nbsp;&nbsp;<a href="blogview.asp?Content_Id=<%=rs("Content_Id")%>" target="_blank"><%=rs("Content_Title")%></a></td>
            </tr>
            <tr height="1">
                <td height="1">
                    - - - - - - - - - - - - - - - - - -</td>
            </tr>
        </tbody>
    </table>
    <%
  rs.Movenext
  Loop 
  Set rs=Nothing
    %>
</body>
</html>
<% closeDataBase %>
