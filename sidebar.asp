<!--#include file="calendar.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="22" class="blogTitle">
            <b>&nbsp;日历归档</b></td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td>
            <div id='calendarContent'>
                <%
		Dim blogYear,blogMonth,blogDay
		blogYear=Trim(Request.QueryString("blogYear"))
		blogMonth=Trim(Request.QueryString("blogMonth"))
		blogDay=Trim(Request.QueryString("blogDay"))
		If Not IsInteger(blogYear) Then blogYear=""
		If Not IsInteger(blogMonth) Then blogMonth=""
		If Not IsInteger(blogDay) Then blogDay=""
		Calendar blogYear,blogMonth,blogDay
                %>
            </div>
        </td>
    </tr>
    <tr>
        <td style="height: 3px">
        </td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td height="22" class="blogTitle">
            <b>&nbsp;About Me</b></td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td>
            <table cellspacing="1" cellpadding="1" width="100%" border="0">
                <tbody>
                    <tr class="smallFont">
                        <td width="45" class="blogContentBg">
                            <font class="sidebarInfoFont">&nbsp;Name:</font></td>
                        <td width="144">
                            ZhangSichu</td>
                    </tr>
                    <tr class="smallFont">
                        <td class="blogContentBg">
                            <font class="sidebarInfoFont">&nbsp;Sex:</font></td>
                        <td>
                            Male</td>
                    </tr>
                    <tr class="smallFont">
                        <td class="blogContentBg">
                            <font class="sidebarInfoFont">&nbsp;Age:</font></td>
                        <td>
                            28</td>
                    </tr>
                    <tr class="smallFont">
                        <td class="blogContentBg">
                            <font class="sidebarInfoFont">&nbsp;Email:</font></td>
                        <td>
                            ZhangSichu@gmail.com</td>
                    </tr>
                    <tr class="smallFont">
                        <td class="blogContentBg">
                            <font class="sidebarInfoFont">&nbsp;MSN:</font></td>
                        <td>
                            ZhangSichu@hotmail.com</td>
                    </tr>
                    <tr class="smallFont">
                        <td class="blogContentBg">
                            <font class="sidebarInfoFont">&nbsp;QQ:</font></td>
                        <td>
                            3555683</td>
                    </tr>
                    <tr class="smallFont">
                        <td class="blogContentBg">
                            <font class="sidebarInfoFont">&nbsp;Home:</font></td>
                        <td>
                            ZhangSichu.com</td>
                    </tr>
                    <tr class="smallFont">
                        <td class="blogContentBg">
                            <font class="sidebarInfoFont">&nbsp;T-Blog:</font></td>
                        <td>
                            t.sina.com.cn/zhangsichu</td>
                    </tr>
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td style="height: 3px">
        </td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td height="22" class="blogTitle">
            <b>&nbsp;个人推荐</b></td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td>
                    </td>
                    <td>
                        <iframe name="topiclist" marginheight="auto" src="topiclist.asp" frameborder="0"
                            width="220" height="160"></iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="height: 3px">
        </td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td height="22" class="blogTitle">
            <b>&nbsp;分类归档</b></td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <%
   Set rs=conn.ExeCute("select * from Blog_Class")
   Do While Not rs.Eof
                %>
                <tr>
                    <td onmouseover="javascript:style.backgroundColor='#eaeaea'" onmouseout="javascript:style.backgroundColor=''"
                        valign="bottom" height="23">
                        &nbsp;&nbsp;<b>·<a href="#" onclick="GetClassDisplay('defaultresponse.asp?viewType=byClass&Class_Id=<%=rs("Class_Id")%>');return false;"><%=rs("Class_Name")%></a>(<%=rs("Class_Count")%>)&nbsp;&nbsp;<a
                            href="classrss.asp?Class_Id=<%=rs("Class_Id")%>" target="_blank"><img height="9"
                                src="images/xml.gif" width="18px" border="0px" alt="RSS" /></a></b></td>
                </tr>
                <%
  rs.Movenext
  Loop 
  Set rs=Nothing
                %>
            </table>
        </td>
    </tr>
    <tr>
        <td style="height:3px;"></td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td height="22" class="blogTitle">
            <b>&nbsp;My Friends</b></td>
    </tr>
    <tr>
        <td style="height: 1px;" class="blogLine">
        </td>
    </tr>
    <tr>
        <td valign="top">
            <ul class="friends">
                <li><a href="http://stevenyanglife.spaces.live.com" target="_blank">Steven's Blog</a></li>
                <li><a href="http://xinyuonline.net/blog" target="_blank">Xinyu's Blog</a></li>
                <li><a href="http://www.cnblogs.com/LoveShrek/" target="_blank">JameBo's Blog</a></li>      
                <li><a href="http://recordsome.blogsome.com" target="_blank">AlonePlayer's Record</a></li>
                <li><a href="http://shenguangtao.blogbus.com" target="_blank">ShenGuangtao's 幻城</a></li>
                <li><a href="http://syanyszy.blogbus.com" target="_blank">ZitingLiu 一起去旅行</a></li>
                <li><a href="http://www.cnblogs.com/colorsky" target="_blank">DaBin's ColorSky</a></li>  
                <li><a href="http://bylinn.ycool.com/" target="_blank">LiQin's Blog</a></li>  
                <li><a href="http://www.j2nete.cn" target="_blank">J2.NETe 聪明正直</a></li> 
                <li><a href="http://www.dang-jian.com" target="_blank">DangJian's Blog</a></li>  
                <li><a href="http://powertoolsteam.cnblogs.com/" target="_blank">GrapeCity 控件技术博客</a></li>  
				<li><a href="http://blog.lipengbo.com" target="_blank">Li Pengbo's Blog</a></li>
           </ul>
        </td>
    </tr>
</table>