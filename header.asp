<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="66" class="headerBack">
            <div class="headerSlogan">
                There can be no Triumph without Loss,No Victory without Suffering,No Freedom without
                Sacrifice.<br />
                All you have to decide is what to do with the time that is given to you.<br />
                Get busy Living, or Get busy Dying?<br />
				</div>
        </td>
    </tr>
    <tr>
        <td>
            <table height="2" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="headerSplitLine">
                    <td>
                    </td>
                </tr>
                <tr class="headerBottomLine">
                    <td>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="headerTitleLine">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <%
	Set rs=conn.ExeCute("SELECT * FROM Blog_Count")
	If Not rs.Eof Then
                %>
                <tr>
                    <td height="19" align="left">
                        &nbsp;&nbsp;<a href="#" onclick="GetClassDisplay('defaultresponse.asp'); return false;">Ê×Ò³</a>
                        | <a href="#" onclick="GetLeavewordsDisplay('leavewordsresponse.asp'); return false;">
                            ÁôÑÔ¸øÎÒ</a> | <a href="blogrss.asp" target="_blank">¶©ÔÄ Rss
                                <img height="9" src="images/xml.gif" width="18" border="0"></a> | <a href="#" onclick='javascript:OpenCLIWindow(); return false;'>
                                    CLI
                                    <img src="images/clismall.gif" border="0" /></a> | <a href="#" onclick="javascript:OpenOldPart(); return false;">
                                        »Æ°×Ö®Áµ</a>
                        <%
                        If Is_ListByYear Then
                            For startYear =  Web_StartYear To Year(Date())
                                Response.Write(" | <a href=""#"" onclick=""GetClassDisplay('defaultresponse.asp?viewType=byYear&blogYear=" & startYear & "'); return false;"">" & startYear &"</a>")
                            Next
                        End If
                        %>
                    </td>
                    <td align="right">
                        Posts:<%=rs("Count_Content")%>&nbsp;&nbsp;&nbsp;Hits:
                        <%=rs("Count_Hit")%>
                        &nbsp;&nbsp;&nbsp;Comments:
                        <%=rs("Count_Comment")%>
                        &nbsp;&nbsp;&nbsp;</td>
                </tr>
                <%
	Set rs=Nothing
	End If
                %>
            </table>
        </td>
    </tr>
</table>
