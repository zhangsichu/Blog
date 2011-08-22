<%sub admin_body()%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%">
    <tr>
        <td valign="middle">
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tableBlack">
                <tr>
                    <td align="center" class="adminHeader">
                        管理Blog [<a href="login.asp?action=Logout">注销管理员</a>]
                    </td>
                </tr>
                <tr>
                    <td height="24" align="center" class="tableWhite" valign="middle">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="160" align="center" valign="top">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="menu" height="24">
                                                <b>&nbsp;管理列表</b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<b><a href="admin.asp?position=newBlog">新增文章</a></b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<b><a href="admin.asp?position=listBlog">文章管理</a></b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<b><a href="admin.asp?position=blogComment">回复管理</a></b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<b><a href="admin.asp?position=newClass">新增分类</a></b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<b><a href="admin.asp?position=listClass">分类管理</a></b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<b><a href="admin.asp?position=listUser">用户管理</a></b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<b><a href="admin.asp?position=listWord">留言管理</a></b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<b><a href="admin.asp?position=changePassword">更改密码</a></b></td>
                                        </tr>
                                        <tr>
                                            <td class="tableTd">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="22">
                                                &nbsp;·<a href="login.asp?action=Logout"><b>退出</b></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="tableTd">
                                </td>
                                <td valign="top">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <%
			Select Case Request.QueryString("position")
			Case "newBlog"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr style="height:24px">
                                                        <td align="center" class="menu">
                                                            <font class="fontBlack"><b>新增文章</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>

                                                            <script src="blog.js" type="text/javascript"></script>

                                                            <form name="Blogform" method="post" onsubmit="return checkinput()" action="admin.asp">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr style="height:22px" valign="middle">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>分类:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td width="656" align="left">
                                                                            &nbsp;
                                                                            <select name="blogClass" id="blogClass">
                                                                                <option value='0'>- 选择分类 -</option>
                                                                                <%
					Set rsclass=conn.ExeCute("SELECT * FROM Blog_Class")
					Do While Not rsclass.Eof
					Response.Write("<option value='"&rsclass("Class_Id")&"'"&">"&rsclass("Class_Name")&"</option>")					
					rsclass.Movenext
					Loop 
					Set rsclass=Nothing
                                                                                %>
                                                                            </select>
                                                                            &nbsp;&nbsp;|&nbsp;&nbsp; 推荐<input type="checkbox" name="contentTopic" id="contentTopic" style="vertical-align:middle"/>
                                                                            &nbsp;&nbsp;|&nbsp;&nbsp;使用Ubb代码
                                                                            <input name="contentUbb" type="checkbox" id="contentUbb" style="vertical-align:middle" checked />&nbsp;&nbsp;|&nbsp;&nbsp;是否置顶
                                                                            <input name="contentIsInTop" type="checkbox" id="contentIsInTop" style="vertical-align:middle" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd" width="152" >
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>标题:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<input name="contentTitle" type="text" id="contentTitle" size="60" maxlength="255" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>格式:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;
                                                                            <select name="font" onfocus="this.selectedIndex=0" onchange="chfont(this.options[this.selectedIndex].value)"
                                                                                size="1">
                                                                                <option value="">- 选择字体 -</option>
                                                                                <option value="宋体">宋体</option>
                                                                                <option value="黑体">黑体</option>
                                                                                <option value="Arial">Arial</option>
                                                                                <option value="Book Antiqua">Book Antiqua</option>
                                                                                <option value="Century Gothic">Century Gothic</option>
                                                                                <option value="Courier New">Courier New</option>
                                                                                <option value="Georgia">Georgia</option>
                                                                                <option value="Impact">Impact</option>
                                                                                <option value="Tahoma">Tahoma</option>
                                                                                <option value="Times New Roman">Times New Roman</option>
                                                                                <option value="Verdana">Verdana</option>
                                                                            </select>
                                                                            <select name="size" onfocus="this.selectedIndex=0" onchange="chsize(this.options[this.selectedIndex].value)"
                                                                                size="1">
                                                                                <option value="" selected>- 字体大小 -</option>
                                                                                <option value="-2">-2</option>
                                                                                <option value="-1">-1</option>
                                                                                <option value="1">1</option>
                                                                                <option value="2">2</option>
                                                                                <option value="3">3</option>
                                                                                <option value="4">4</option>
                                                                                <option value="5">5</option>
                                                                                <option value="6">6</option>
                                                                                <option value="7">7</option>
                                                                            </select>
                                                                            <select name="color" onfocus="this.selectedIndex=0" onchange="chcolor(this.options[this.selectedIndex].value)"
                                                                                size="1">
                                                                                <option value="" selected>- 字体颜色 -</option>
                                                                                <option value="White" style="background-color: white; color: white;">White</option>
                                                                                <option value="Black" style="background-color: black; color: black;">Black</option>
                                                                                <option value="Red" style="background-color: red; color: red;">Red</option>
                                                                                <option value="Yellow" style="background-color: yellow; color: yellow;">Yellow</option>
                                                                                <option value="Pink" style="background-color: pink; color: pink;">Pink</option>
                                                                                <option value="Green" style="background-color: green; color: green;">Green</option>
                                                                                <option value="Orange" style="background-color: orange; color: orange;">Orange</option>
                                                                                <option value="Purple" style="background-color: purple; color: purple;">Purple</option>
                                                                                <option value="Blue" style="background-color: blue; color: blue;">Blue</option>
                                                                                <option value="Beige" style="background-color: beige; color: beige;">Beige</option>
                                                                                <option value="Brown" style="background-color: brown; color: brown;">Brown</option>
                                                                                <option value="Teal" style="background-color: teal; color: teal;">Teal</option>
                                                                                <option value="Navy" style="background-color: navy; color: navy;">Navy</option>
                                                                                <option value="Maroon" style="background-color: maroon; color: maroon;">Maroon</option>
                                                                                <option value="LimeGreen" style="background-color: limegreen; color: limegreen;">LimeGreen</option>
                                                                            </select>
                                                                            &nbsp; <b>天气: </b>
                                                                            <select name="blogWeather" id="blogWeather">
                                                                                <option value="1">晴天</option>
                                                                                <option value="2">多云</option>
                                                                                <option value="3">阴天</option>
                                                                                <option value="4">下雨</option>
                                                                                <option value="5">下雪</option>
                                                                                <option value="6">台风</option>
                                                                            </select>
                                                                            &nbsp;<b>心情: </b>
                                                                            <select name="blogEmotion" id="blogEmotion">
                                                                                <option value="1">+2</option>
                                                                                <option value="2">+1</option>
                                                                                <option value="3">0</option>
                                                                                <option value="4">-1</option>
                                                                                <option value="5">-2</option>
                                                                            </select>
                                                                            &nbsp;<input type="radio" name="mode" value="2" onclick="chmode('2')" style="vertical-align:middle" checked />
                                                                            基本&nbsp;
                                                                            <input type="radio" name="mode" value="0" onclick="chmode('0')" style="vertical-align:middle" />
                                                                            拓展&nbsp;
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:45px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>媒体:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td valign="middle">
                                                                            &nbsp; <a href="javascript:bold()">
                                                                                <img src="images/ubbcode/bb_bold.gif" border="0" alt="加粗" /></a> <a href="javascript:italicize()">
                                                                                    <img src="images/ubbcode/bb_italicize.gif" border="0" alt="斜体" /></a> <a href="javascript:underline()">
                                                                                        <img src="images/ubbcode/bb_underline.gif" border="0" alt="下划线" /></a>
                                                                            <a href="javascript:strike()">
                                                                                <img src="images/ubbcode/bb_strike.gif" border="0" alt="删除线" /></a> <a href="javascript:superscript()">
                                                                                    <img src="images/ubbcode/bb_sup.gif" border="0" alt="上角标" /></a> <a href="javascript:subscript()">
                                                                                        <img src="images/ubbcode/bb_sub.gif" border="0" alt="下角标" /></a> <a href="javascript:center()">
                                                                                            <img src="images/ubbcode/bb_center.gif" border="0" alt="居中" /></a>
                                                                            <a href="javascript:hyperlink()">
                                                                                <img src="images/ubbcode/bb_url.gif" border="0" alt="超链接" /></a> <a href="javascript:email()">
                                                                                    <img src="images/ubbcode/bb_email.gif" border="0" alt="插入邮件链接" /></a> <a href="javascript:image()">
                                                                                        <img src="images/ubbcode/bb_image.gif" border="0" alt="插入图片" /></a> <a href="javascript:media()">
                                                                                            <img src="images/ubbcode/bb_media.gif" border="0" alt="插入Flash" /></a>
                                                                            <a href="javascript:code()">
                                                                                <img src="images/ubbcode/bb_code.gif" border="0" alt="插入代码" /></a> <a href="javascript:quote()">
                                                                                    <img src="images/ubbcode/bb_quote.gif" border="0" alt="插入引用" /></a> <a href="javascript:list()">
                                                                                        <img src="images/ubbcode/bb_list.gif" border="0" alt="插入自动编号" /></a> <a href="javascript:seperator()">
                                                                                            <img src="images/ubbcode/bb_seperator.gif" border="0" alt="插入分隔符" /></a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>内容：</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<textarea name="contentContent" id="contentContent" rows="17" wrap="virtual"
                                                                                style="width: 98%" onselect="storeCaret(this);" onclick="storeCaret(this);" onkeyup="storeCaret(this);CtrlEnter();"></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px">
                                                                        <td width="152px" align="center">
                                                                            <font class="fontBlack"><b>附件:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td valign="middle" style="vertical-align:middle; padding-left:8px"><iframe border="0" frameborder="0" framespacing="0" height="22px" marginheight="0px"
                                                                                marginwidth="0" noresize scrolling="no" width="100%" src="attachment.asp"></iframe>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            &nbsp;</td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<input type="submit" name="Submit" id="Submit" value="提交" />&nbsp;<input
                                                                                type="reset" name="Reset" id="Reset" value="重填" />
                                                                            <input name="action" type="hidden" value="newBlog" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
			Case "listBlog"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>文章管理</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                <tr align="center" style="height:22px">
                                                                    <td>
                                                                        <font class="fontBlack"><b>标题</b></font></td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150px">
                                                                        <font class="fontBlack"><b>操作</b></font></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150px" class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  Set rs=conn.ExeCute("SELECT * FROM Blog_Content ORDER BY Content_Id DESC")
				  Do While Not rs.Eof
                                                                %>
                                                                <tr align="center" style="height:22px">
                                                                    <td>
                                                                        <%=rs("Content_Title")%>
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150px">
                                                                        <a href="admin.asp?position=editBlog&Content_Id=<%=rs("Content_Id")%>">修改</a> <a
                                                                            href="admin.asp?position=delBlog&Content_Id=<%=rs("Content_Id")%>">删除</a> <a href="admin.asp?position=listComment&Content_Id=<%=rs("Content_Id")%>">
                                                                                回复管理</a></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150" class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  	rs.Movenext
  					Loop 
  					Set rs=Nothing
                                                                %>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%  
            Case "blogComment"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>回复管理</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                <tr align="center" style="height:22px">
                                                                    <td>
                                                                        <font class="fontBlack"><b>标题</b></font></td>
                                                                    <td></td>
                                                                    <td>
                                                                        <font class="fontBlack"><b>操作</b></font></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150px" class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  Set rs=conn.ExeCute("SELECT Comment_Id,Comment_Title FROM Blog_Comment ORDER BY Comment_Time DESC")
				  Do While Not rs.Eof
                                                                %>
                                                                <tr align="center" style="height:22px">
                                                                    <td>
                                                                        <%=HTMLEncode(rs("Comment_Title"))%>
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td>
                                                                        <a href="admin.asp?position=editComment&Comment_Id=<%=rs("Comment_Id")%>">编辑</a>
                                                                        <a href="admin.asp?position=delComment&Comment_Id=<%=rs("Comment_Id")%>">删除</a></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  	rs.Movenext
  					Loop 
  					Set rs=Nothing
                                                                %>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
			Case "editBlog"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>修改文章</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%
			  Set rs=conn.ExeCute("SELECT * FROM Blog_Content WHERE Content_Id ="&Request.QueryString("Content_Id"))
			  If Not rs.Eof Then
                                                            %>

                                                            <script src="blog.js" type="text/javascript"></script>

                                                            <form name="Blogform" method="post" onsubmit="return checkinput()" action="admin.asp">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr height="22" valign="middle">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>分类:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td width="656" align="left">
                                                                            &nbsp;
                                                                            <select name="blogClass" id="blogClass">
                                                                                <option value='0'>- 选择分类 -</option>
                                                                                <%
					Set rsclass=conn.ExeCute("SELECT * FROM Blog_Class")
					Do While Not rsclass.Eof
                                                                                %>
                                                                                <option value='<%=rsclass("Class_Id")%>' <%if rsclass("class_id")=rs("content_class") then %>selected
                                                                                    <%end if%>>
                                                                                    <%=rsclass("Class_Name")%>
                                                                                </option>
                                                                                <%				
					rsclass.Movenext
					Loop 
					Set rsclass=Nothing
                                                                                %>
                                                                            </select>
                                                                            &nbsp;&nbsp;|&nbsp;&nbsp; 推荐<input type="checkbox" name="contentTopic" id="contentTopic"
                                                                                <%if rs("content_topic") then %>checked<%end if%> style="vertical-align:middle" />
                                                                            &nbsp;&nbsp;|&nbsp;&nbsp;使用Ubb代码
                                                                            <input type="checkbox" name="contentUbb" id="contentUbb" <%if rs("content_ubb") then %>checked<%end if%> style="vertical-align:middle" />
                                                                            &nbsp;&nbsp;|&nbsp;&nbsp;是否置顶
                                                                            <input name="contentIsInTop" type="checkbox" id="contentIsInTop" <%if rs("content_isintop") then %>checked<%end if%> style="vertical-align:middle" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>标题:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<input name="contentTitle" type="text" id="contentTitle" size="60" maxlength="255"
                                                                                value="<%=rs("Content_Title")%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>格式:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;
                                                                            <select name="font" onfocus="this.selectedIndex=0" onchange="chfont(this.options[this.selectedIndex].value)"
                                                                                size="1">
                                                                                <option value="" selected>- 选择字体 -</option>
                                                                                <option value="宋体">宋体</option>
                                                                                <option value="黑体">黑体</option>
                                                                                <option value="Arial">Arial</option>
                                                                                <option value="Book Antiqua">Book Antiqua</option>
                                                                                <option value="Century Gothic">Century Gothic</option>
                                                                                <option value="Courier New">Courier New</option>
                                                                                <option value="Georgia">Georgia</option>
                                                                                <option value="Impact">Impact</option>
                                                                                <option value="Tahoma">Tahoma</option>
                                                                                <option value="Times New Roman">Times New Roman</option>
                                                                                <option value="Verdana">Verdana</option>
                                                                            </select>
                                                                            <select name="size" onfocus="this.selectedIndex=0" onchange="chsize(this.options[this.selectedIndex].value)"
                                                                                size="1">
                                                                                <option value="" selected>- 字体大小 -</option>
                                                                                <option value="-2">-2</option>
                                                                                <option value="-1">-1</option>
                                                                                <option value="1">1</option>
                                                                                <option value="2">2</option>
                                                                                <option value="3">3</option>
                                                                                <option value="4">4</option>
                                                                                <option value="5">5</option>
                                                                                <option value="6">6</option>
                                                                                <option value="7">7</option>
                                                                            </select>
                                                                            <select name="color" onfocus="this.selectedIndex=0" onchange="chcolor(this.options[this.selectedIndex].value)"
                                                                                size="1">
                                                                                <option value="" selected>- 字体颜色 -</option>
                                                                                <option value="White" style="background-color: white; color: white;">White</option>
                                                                                <option value="Black" style="background-color: black; color: black;">Black</option>
                                                                                <option value="Red" style="background-color: red; color: red;">Red</option>
                                                                                <option value="Yellow" style="background-color: yellow; color: yellow;">Yellow</option>
                                                                                <option value="Pink" style="background-color: pink; color: pink;">Pink</option>
                                                                                <option value="Green" style="background-color: green; color: green;">Green</option>
                                                                                <option value="Orange" style="background-color: orange; color: orange;">Orange</option>
                                                                                <option value="Purple" style="background-color: purple; color: purple;">Purple</option>
                                                                                <option value="Blue" style="background-color: blue; color: blue;">Blue</option>
                                                                                <option value="Beige" style="background-color: beige; color: beige;">Beige</option>
                                                                                <option value="Brown" style="background-color: brown; color: brown;">Brown</option>
                                                                                <option value="Teal" style="background-color: teal; color: teal;">Teal</option>
                                                                                <option value="Navy" style="background-color: navy; color: navy;">Navy</option>
                                                                                <option value="Maroon" style="background-color: maroon; color: maroon;">Maroon</option>
                                                                                <option value="LimeGreen" style="background-color: limegreen; color: limegreen;">LimeGreen</option>
                                                                            </select>
                                                                            &nbsp; <b>天气: </b>
                                                                            <select name="blogWeather" id="blogWeather">
                                                                                <option value="1" <%if rs("content_weather")=1 then response.write("selected") end if%>>
                                                                                    晴天</option>
                                                                                <option value="2" <%if rs("content_weather")=2 then response.write("selected") end if%>>
                                                                                    多云</option>
                                                                                <option value="3" <%if rs("content_weather")=3 then response.write("selected") end if%>>
                                                                                    阴天</option>
                                                                                <option value="4" <%if rs("content_weather")=4 then response.write("selected") end if%>>
                                                                                    下雨</option>
                                                                                <option value="5" <%if rs("content_weather")=5 then response.write("selected") end if%>>
                                                                                    下雪</option>
                                                                                <option value="6" <%if rs("content_weather")=6 then response.write("selected") end if%>>
                                                                                    台风</option>
                                                                            </select>
                                                                            &nbsp;<b>心情: </b>
                                                                            <select name="blogEmotion" id="blogEmotion">
                                                                                <option value="1" <%if rs("content_emotion")=1 then response.write("selected") end if%>>
                                                                                    +2</option>
                                                                                <option value="2" <%if rs("content_emotion")=2 then response.write("selected") end if%>>
                                                                                    +1</option>
                                                                                <option value="3" <%if rs("content_emotion")=3 then response.write("selected") end if%>>
                                                                                    0</option>
                                                                                <option value="4" <%if rs("content_emotion")=4 then response.write("selected") end if%>>
                                                                                    -1</option>
                                                                                <option value="5" <%if rs("content_emotion")=5 then response.write("selected") end if%>>
                                                                                    -2</option>
                                                                            </select>
                                                                            &nbsp;<input type="radio" name="mode" value="2" onclick="chmode('2')" style="vertical-align:middle" checked />
                                                                            基本&nbsp;
                                                                            <input type="radio" name="mode" value="0" onclick="chmode('0')" style="vertical-align:middle"/>
                                                                            拓展&nbsp;
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:45px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>媒体:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td valign="middle">
                                                                            &nbsp; <a href="javascript:bold()">
                                                                                <img src="images/ubbcode/bb_bold.gif" border="0" alt="加粗" /></a> <a href="javascript:italicize()">
                                                                                    <img src="images/ubbcode/bb_italicize.gif" border="0" alt="斜体" /></a> <a href="javascript:underline()">
                                                                                        <img src="images/ubbcode/bb_underline.gif" border="0" alt="下划线" /></a>
                                                                            <a href="javascript:strike()">
                                                                                <img src="images/ubbcode/bb_strike.gif" border="0" alt="删除线" /></a> <a href="javascript:superscript()">
                                                                                    <img src="images/ubbcode/bb_sup.gif" border="0" alt="上角标" /></a> <a href="javascript:subscript()">
                                                                                        <img src="images/ubbcode/bb_sub.gif" border="0" alt="下角标" /></a> <a href="javascript:center()">
                                                                                            <img src="images/ubbcode/bb_center.gif" border="0" alt="居中" /></a>
                                                                            <a href="javascript:hyperlink()">
                                                                                <img src="images/ubbcode/bb_url.gif" border="0" alt="超链接" /></a> <a href="javascript:email()">
                                                                                    <img src="images/ubbcode/bb_email.gif" border="0" alt="插入邮件链接" /></a> <a href="javascript:image()">
                                                                                        <img src="images/ubbcode/bb_image.gif" border="0" alt="插入图片" /></a> <a href="javascript:media()">
                                                                                            <img src="images/ubbcode/bb_media.gif" border="0" alt="插入Flash" /></a>
                                                                            <a href="javascript:code()">
                                                                                <img src="images/ubbcode/bb_code.gif" border="0" alt="插入代码" /></a> <a href="javascript:quote()">
                                                                                    <img src="images/ubbcode/bb_quote.gif" border="0" alt="插入引用" /></a> <a href="javascript:list()">
                                                                                        <img src="images/ubbcode/bb_list.gif" border="0" alt="插入自动编号" /></a> <a href="javascript:seperator()">
                                                                                            <img src="images/ubbcode/bb_seperator.gif" border="0" alt="插入分隔符" /></a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>内容：</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<textarea name="contentContent" id="contentContent" rows="17" wrap="virtual"
                                                                                style="width: 98%" onselect="storeCaret(this);" onclick="storeCaret(this);" onkeyup="storeCaret(this);CtrlEnter();"><%=rs("Content_Content")%></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:28px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>附件:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td valign="middle" style="vertical-align:middle; padding-left:8px"><iframe border="0" frameborder="0" framespacing="0" height="22px" marginheight="0"
                                                                                marginwidth="0" noresize scrolling="no" width="100%" src="attachment.asp"></iframe>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            &nbsp;</td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<input type="submit" name="Submit" id="Submit" value="提交" />&nbsp;<input
                                                                                type="reset" name="Reset" id="Reset" value="重填" />
                                                                            <input name="action" type="hidden" value="editBlog" /><input name="contentId" type="hidden"
                                                                                value="<%=rs("Content_Id")%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </form>
                                                            <%
			Set rs=Nothing
			End If
                                                            %>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
			Case "delBlog"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>删除文章</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%
			  Set rs=conn.ExeCute("SELECT * FROM Blog_Content WHERE Content_Id ="&Request.QueryString("Content_Id"))
			  If Not rs.Eof Then
                                                            %>
                                                            <form name="delBlogform" method="post" action="admin.asp">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr style="height:22px" valign="middle">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>分类:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td width="656" align="left">
                                                                            &nbsp;
                                                                            <%
					Set rsclass=conn.ExeCute("SELECT * FROM Blog_Class WHERE Class_Id="&rs("Content_Class"))
					If Not rsclass.Eof Then
					Response.Write(rsclass("Class_Name"))					
					Set rsclass=Nothing
					End If
                                                                            %>
                                                                            &nbsp;&nbsp;|&nbsp;&nbsp; 推荐<input type="checkbox" name="contentTopic" id="contentTopic"
                                                                                <%if rs("content_topic") then %>checked<%end if%> style="vertical-align:middle" />
                                                                            &nbsp;&nbsp;|&nbsp;&nbsp;使用Ubb代码
                                                                            <input type="checkbox" name="contentUbb" id="contentUbb" <%if rs("content_ubb") then %>checked<%end if%> style="vertical-align:middle" />
                                                                            &nbsp;&nbsp;|&nbsp;&nbsp;是否置顶
                                                                            <input name="contentIsInTop" type="checkbox" id="contentIsInTop" <%if rs("content_isintop") then %>checked<%end if%> style="vertical-align:middle" />
                                                                            &nbsp; <b>天气: </b>
                                                                            <select name="blogWeather" id="blogWeather">
                                                                                <option value="1" <%if rs("content_weather")=1 then response.write("selected") end if%>>
                                                                                    晴天</option>
                                                                                <option value="2" <%if rs("content_weather")=2 then response.write("selected") end if%>>
                                                                                    多云</option>
                                                                                <option value="3" <%if rs("content_weather")=3 then response.write("selected") end if%>>
                                                                                    阴天</option>
                                                                                <option value="4" <%if rs("content_weather")=4 then response.write("selected") end if%>>
                                                                                    下雨</option>
                                                                                <option value="5" <%if rs("content_weather")=5 then response.write("selected") end if%>>
                                                                                    下雪</option>
                                                                                <option value="6" <%if rs("content_weather")=6 then response.write("selected") end if%>>
                                                                                    台风</option>
                                                                            </select>
                                                                            &nbsp;<b>心情: </b>
                                                                            <select name="blogEmotion" id="blogEmotion">
                                                                                <option value="1" <%if rs("content_emotion")=1 then response.write("selected") end if%>>
                                                                                    +2</option>
                                                                                <option value="2" <%if rs("content_emotion")=2 then response.write("selected") end if%>>
                                                                                    +1</option>
                                                                                <option value="3" <%if rs("content_emotion")=3 then response.write("selected") end if%>>
                                                                                    0</option>
                                                                                <option value="4" <%if rs("content_emotion")=4 then response.write("selected") end if%>>
                                                                                    -1</option>
                                                                                <option value="5" <%if rs("content_emotion")=5 then response.write("selected") end if%>>
                                                                                    -2</option>
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>标题:</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<%=rs("Content_Title")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            <font class="fontBlack"><b>内容：</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<textarea name="contentContent" id="contentContent" rows="17" wrap="virtual"
                                                                                style="width: 98%"><%=rs("Content_Content")%></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:22px">
                                                                        <td width="152" align="center">
                                                                            &nbsp;</td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;<input type="submit" name="Submit" id="Submit" value="删除" /><input name="action"
                                                                                type="hidden" value="delBlog" /><input name="contentId" type="hidden" value="<%=rs("Content_Id")%>" /><input
                                                                                    name="blogClass" type="hidden" value="<%=rs("Content_Class")%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="152" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </form>
                                                            <%
				Set rs=Nothing
				End If
                                                            %>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
		  	Case "listComment"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>回复管理</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                <tr align="center" style="height:22px">
                                                                    <td>
                                                                        <font class="fontBlack"><b>标题</b></font></td>
                                                                    <td></td>
                                                                    <td>
                                                                        <font class="fontBlack"><b>操作</b></font></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150px" class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  Set rs=conn.ExeCute("SELECT * FROM Blog_Comment WHERE Content_Id = "&Request.QueryString("Content_Id") &" ORDER BY Comment_Id DESC")
				  Do While Not rs.Eof
                                                                %>
                                                                <tr align="center" style="height:22px">
                                                                    <td>
                                                                        <%=HTMLEncode(rs("Comment_Title"))%>
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td>
                                                                        <a href="admin.asp?position=editComment&Comment_Id=<%=rs("Comment_Id")%>">编辑</a>
                                                                        <a href="admin.asp?position=delComment&Comment_Id=<%=rs("Comment_Id")%>">删除</a></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  	rs.Movenext
  					Loop 
  					Set rs=Nothing
                                                                %>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
		  Case "editComment"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>修改回复</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%
			  Set rs=conn.ExeCute("SELECT * FROM Blog_Comment WHERE Comment_Id ="&Request.QueryString("Comment_Id"))
			  If Not rs.Eof Then
                                                            %>
                                                            <form name="editCommentform" method="post" action="admin.asp">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            标题&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<input type="text" size="50" name="commentTitle" id="commentTitle" value="<%=HTMLEncode(rs("Comment_Title"))%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            作者&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<input type="text" name="commentAuthor" id="commentAuthor" value="<%=HTMLEncode(rs("Comment_Author"))%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            内容&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<textarea name="commentContent" id="commentContent" rows="10" cols="60"><%=rs("Comment_Content")%></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            作者来源&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=rs("Comment_Ip")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            &nbsp;</td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td valign="middle">&nbsp;
                                                                            <input type="submit" name="Submit" id="Submit" value="修改" />&nbsp;&nbsp;<input type="reset"
                                                                                name="Reset" id="Reset" value="重填" /><input name="action" type="hidden" value="editComment" /><input
                                                                                    name="commentId" type="hidden" value="<%=rs("Comment_Id")%>" /><input name="contentId"
                                                                                        type="hidden" value="<%=rs("Content_Id")%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </form>
                                                            <%
			Set rs=Nothing
			End If
                                                            %>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
		  Case "delComment"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>删除回复</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%
			  Set rs=conn.ExeCute("SELECT * FROM Blog_Comment WHERE Comment_Id ="&Request.QueryString("Comment_Id"))
			  If Not rs.Eof Then
                                                            %>
                                                            <form name="delCommentform" method="post" action="admin.asp">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr height="22">
                                                                        <td width="220" align="center" valign="middle">
                                                                            标题&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=HTMLEncode(rs("Comment_Title"))%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            作者&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=HTMLEncode(rs("Comment_Author"))%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            内容&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=HTMLEncode(rs("Comment_Content"))%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            作者来源&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=rs("Comment_Ip")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="247" class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td width="561" class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            &nbsp;</td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left" valign="middle">
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="Submit" id="Submit" value="确定删除" /><input
                                                                                name="action" type="hidden" value="delComment" /><input name="commentId" type="hidden"
                                                                                    value="<%=rs("Comment_Id")%>" /><input name="contentId" type="hidden" value="<%=rs("Content_Id")%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </form>
                                                            <%
			Set rs=Nothing
			End If
                                                            %>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
		  Case "listWord"
                                        %>
                                        <tr>
                                            <td>
                                                <form name="listWord" method="post" action="admin.asp" onsubmit="return checkselected()">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <font class="fontBlack"><b>留言管理</b></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr align="center" height="22">
                                                                        <td colspan="3">
                                                                            <font class="fontBlack"><b>标题</b></font></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td width="150">
                                                                            <font class="fontBlack"><b>操作</b></font></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td width="150" class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <%
				  Set rs=conn.ExeCute("SELECT * FROM Blog_Word ORDER BY Word_Id DESC")
				  Do While Not rs.Eof
                                                                    %>
                                                                    <tr align="center" height="22">
                                                                        <td>
                                                                            <input type="checkbox" name="<%=rs("Word_Id")%>" value="on" id="<%=rs("Word_Id")%>"
                                                                                onclick="modifywordids('<%=rs("Word_Id")%>')" /></td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td>
                                                                            <%=HTMLEncode(rs("Word_Author"))%>
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td width="150">
                                                                            <a href="admin.asp?position=editWord&Word_Id=<%=rs("Word_Id")%>">编辑</a> <a href="admin.asp?position=delWord&Word_Id=<%=rs("Word_Id")%>">
                                                                                删除</a></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd" width="100">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td width="150" class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <%
				  	rs.Movenext
  					Loop 
  					Set rs=Nothing
                                                                    %>
                                                                    <tr valign="middle">
                                                                        <td colspan="5" height="30px" align="center" valign="bottom">
                                                                            <input name="Submit" type="Submit" class="button" value="删除选中的留言" /><input name="action"
                                                                                type="hidden" value="listWord" /><input name="wordIds" type="hidden" value="" id="wordIds" /></td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </form>

                                                <script type="text/javascript">
				function checkselected()
				{
					var wordIds = document.getElementById("wordIds");
					if (wordIds.value == "")
					{
						alert("请选择一个删除留言");
						return false;
					}
					return true;
				}
				function modifywordids(wordId)
				{
					var wordIds = document.getElementById("wordIds");
					var wordCheckBox = document.getElementById(wordId);
					if (wordCheckBox!=null)
					{
						if(wordCheckBox.checked)
						{
							wordIds.value = wordIds.value + wordId;
							wordIds.value = wordIds.value + ",";
						}
						else
						{
							wordIds.value = wordIds.value.substring(0,wordIds.value.indexOf(wordId)) + wordIds.value.substring(wordIds.value.indexOf(wordId)+wordId.length+1,wordIds.value.length);
						}
					}	
				}
                                                </script>

                                            </td>
                                        </tr>
                                        <%
		  Case "editWord"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>修改留言</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%
			  Set rs=conn.ExeCute("SELECT * FROM Blog_Word WHERE Word_Id ="&Request.QueryString("Word_Id"))
			  If Not rs.Eof Then
                                                            %>
                                                            <form name="editWordform" method="post" action="admin.asp">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            留言人&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<input type="text" name="wordAuthor" id="wordAuthor" value="<%=HTMLEncode(rs("Word_Author"))%>" />&nbsp;&nbsp;显示<input
                                                                                name="wordShow" type="checkbox" id="wordShow" <%if rs("word_show") then %>checked<%end if%> /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            Email&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<input type="text" size="50" name="wordEmail" id="wordEmail" value="<%=HTMLEncode(rs("Word_Email"))%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            Homepage&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<input type="text" size="50" name="wordHomepage" id="wordHomepage" value="<%=HTMLEncode(rs("Word_Homepage"))%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            内容&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<textarea name="wordContent" id="wordContent" rows="10" cols="60"><%=rs("Word_Content")%></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            &nbsp;</td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td valign="middle">&nbsp;
                                                                            <input type="submit" name="Submit" id="Submit" value="修改" />&nbsp;&nbsp;<input type="reset"
                                                                                name="Reset" id="Reset" value="重填" /><input name="action" type="hidden" value="editWord" /><input
                                                                                    name="wordId" type="hidden" value="<%=rs("Word_Id")%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </form>
                                                            <%
			Set rs=Nothing
			End If
                                                            %>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
		  Case "delWord"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>删除留言</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%
			  Set rs=conn.ExeCute("SELECT * FROM Blog_Word WHERE Word_Id ="&Request.QueryString("Word_Id"))
			  If Not rs.Eof Then
                                                            %>
                                                            <form name="delWordform" method="post" action="admin.asp">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle" width="180px">
                                                                            留言人&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=HTMLEncode(rs("Word_Author"))%>&nbsp;&nbsp;<%If rs("Word_Show") Then %><font
                                                                                class="fontAlert"><b>此留言是被显示的留言</b></font><%End If%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            Email&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=HTMLEncode(rs("Word_Email"))%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            Homepage&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=HTMLEncode(rs("Word_Homepage"))%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            内容&nbsp;
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left">
                                                                            &nbsp;<%=HTMLEncode(rs("Word_Content"))%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                    <tr height="22">
                                                                        <td align="center" valign="middle">
                                                                            &nbsp;</td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td align="left" valign="middle">
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="Submit" id="Submit" value="确定删除" /><input
                                                                                name="action" type="hidden" value="delWord" /><input name="wordId" type="hidden" value="<%=rs("Word_Id")%>" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                        <td class="tableTd">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </form>
                                                            <%
			Set rs=Nothing
			End If
                                                            %>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
		  Case "changePassword"
                                        %>

                                        <script type="text/javascript">
			function checkinput()
			{
				if(document.changePasswordform.newPassword.value ==0||document.changePasswordform.againPassword.value==0)
				{
					alert("请输入新的密码");
					return false;
				}			
				if(document.changePasswordform.newPassword.value != document.changePasswordform.againPassword.value)
				{
					alert("两次输入的新密码不一致");
					return false;
				}
				if(document.changePasswordform.oldPassword.value == 0)
				{
					alert("请输入的旧密码");
					return false;
				}
				return true;
			}
                                        </script>

                                        <tr>
                                            <td>
                                                <form name="changePasswordform" onsubmit="return checkinput()" method="post" action="admin.asp">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <font class="fontBlack"><b>更改密码</b></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" valign="middle" height="22">
                                                                旧密码：<input type="password" name="oldPassword" id="oldPassword" />&nbsp;新密码：<input type="password"
                                                                    name="newPassword" id="newPassword" />&nbsp;新密码：<input type="password" name="againPassword"
                                                                        id="againPassword" />
                                                                <input type="submit" name="Submit" id="Submit" value="确定" />&nbsp;<input type="reset"
                                                                    name="Reset" id="Reset" value="重填" />
                                                                <input name="action" type="hidden" value="changePassword" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
		  Case "listClass"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>分类管理</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                <tr align="center" height="22">
                                                                    <td>
                                                                        <font class="fontBlack"><b>分类名称</b></font></td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150">
                                                                        <font class="fontBlack"><b>操作</b></font></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150" class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  Set rs=conn.ExeCute("SELECT * FROM Blog_Class ORDER BY Class_Id DESC")
				  Do While Not rs.Eof
                                                                %>
                                                                <tr align="center" height="22">
                                                                    <td>
                                                                        <%=rs("Class_Name")%>
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150">
                                                                        <a href="admin.asp?position=editClass&Class_Id=<%=rs("Class_Id")%>">修改</a> <a href="admin.asp?position=delClass&Class_Id=<%=rs("Class_Id")%>">
                                                                            删除</a>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150" class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  	rs.Movenext
  					Loop 
  					Set rs=Nothing
                                                                %>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
		  Case "newClass"
                                        %>

                                        <script type="text/javascript">
			function checkinput()
			{
				if(document.newClassform.className.value ==0)
				{
					alert("请输入新增类的名称");
					return false;
				}
				return true;
			}
                                        </script>

                                        <tr>
                                            <td>
                                                <form name="newClassform" onsubmit="return checkinput()" method="post" action="admin.asp">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <font class="fontBlack"><b>新增分类</b></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <tr height="22">
                                                            <td align="center" valign="middle">
                                                                分类名称&nbsp;<input type="text" name="className" id="className" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <tr height="22">
                                                            <td align="center" valign="middle">
                                                                <input type="submit" name="Submit" id="Submit" value="确定" />&nbsp;&nbsp;&nbsp;<input
                                                                    type="reset" name="Reset" id="Reset" value="重填" />
                                                                <input name="action" type="hidden" value="newClass" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
		  Case "editClass"
                                        %>

                                        <script type="text/javascript">
			                            function checkinput()
			                            {
				                            if(document.editClassform.className.value ==0)
				                            {
					                            alert("请输入这个类的名称");
					                            return false;
				                            }
				                            return true;
			                            }
                                        </script>

                                        <tr>
                                            <td>
                                                <form name="editClassform" onsubmit="return checkinput()" method="post" action="admin.asp">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <font class="fontBlack"><b>修改分类</b></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <%
			  Set rs=conn.ExeCute("SELECT * FROM Blog_Class WHERE Class_Id ="&Request.QueryString("Class_Id"))
			  If Not rs.Eof Then
                                                        %>
                                                        <tr height="22">
                                                            <td align="center" valign="middle">
                                                                分类名称&nbsp;<input type="text" name="className" id="className" value="<%=rs("Class_Name")%>" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <tr height="22">
                                                            <td align="center" valign="middle">
                                                                <input type="submit" name="Submit" id="Submit" value="确定" />&nbsp;&nbsp;&nbsp;<input
                                                                    type="reset" name="Reset" id="Reset" value="重填" />
                                                                <input name="action" type="hidden" value="editClass" /><input name="classId" type="hidden"
                                                                    value="<%=rs("Class_Id")%>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <%
			Set rs=Nothing
			End If
                                                        %>
                                                    </table>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
		  Case "delClass"
                                        %>
                                        <tr>
                                            <td>
                                                <form name="delClassform" method="post" action="admin.asp">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <font class="fontBlack"><b>删除分类</b></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <%
			  Set rs=conn.ExeCute("SELECT * FROM Blog_Class WHERE Class_Id ="&Request.QueryString("Class_Id"))
			  If Not rs.Eof Then
                                                        %>
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <font class="fontBlack"><b>分类名称</b></font> <font class="fontAlert"><b>
                                                                    <%=rs("Class_Name")%>
                                                                </b></font>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <input name="Submit" type="Submit" class="button" id="Submit" value="确定删除" /><input
                                                                    name="action" type="hidden" value="delClass" /><input name="classId" type="hidden"
                                                                        value="<%=rs("Class_Id")%>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tableTd">
                                                            </td>
                                                        </tr>
                                                        <%
			Set rs=Nothing
			End If
                                                        %>
                                                    </table>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
		  Case "listUser"
                                        %>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="24" align="center" class="menu">
                                                            <font class="fontBlack"><b>用户管理</b></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tableTd">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                <tr align="center" height="22">
                                                                    <td style="width:70px">
                                                                        <font class="fontBlack"><b>用户ID</b></font>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                    <td>
                                                                        <font class="fontBlack"><b>用户名</b></font>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                    <td>
                                                                        <font class="fontBlack"><b>操作</b></font>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150" class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
                  openAdmin
				  Set rs=conn.ExeCute("SELECT * FROM [User] ORDER BY User_Id DESC")
				  Do While Not rs.Eof
                                                                %>
                                                                <tr align="center" height="22">
                                                                    <td>
                                                                        <%=rs("User_Id")%>
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td>
                                                                        <%=rs("User_Name")%>
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150">
                                                                        <a href="admin.asp?position=editUser&User_Id=<%=rs("User_Id")%>">修改</a> <a href="admin.asp?position=delUser&User_Id=<%=rs("User_Id")%>">
                                                                            删除</a>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td class="tableTd">
                                                                    </td>
                                                                    <td width="150" class="tableTd">
                                                                    </td>
                                                                </tr>
                                                                <%
				  	rs.Movenext
  					Loop
  					Set rs=Nothing
                                                                %>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%
		  Case "editUser"
                                        %>

                                        <script type="text/javascript">
			                            function checkinput()
			                            {
				                            if(document.editUserform.userName.value ==0)
				                            {
					                            alert("请输入用户的名称");
					                            return false;
				                            }
				                            return true;
			                            }
                                        </script>

                                        <tr>
                                            <td>
                                                <form name="editUserform" onsubmit="return checkinput()" method="post" action="admin.asp">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <font class="fontBlack"><b>修改用户</b></font></td>
                                                        </tr>
                                                        <tr class="tableTd">
                                                            <td width="1">
                                                            </td>
                                                        </tr>
                                                        <%
              openAdmin
			  Set rs=conn.ExeCute("SELECT * FROM [User] WHERE User_Id ="&Request.QueryString("User_Id"))
			  If Not rs.Eof Then
                                                        %>
                                                        <tr height="22">
                                                            <td align="center" valign="middle">
                                                                用户ID:&nbsp;<%=rs("User_Id")%>&nbsp;&nbsp;&nbsp; 用户名称:&nbsp;<input type="text" name="userName"
                                                                    id="userName" value="<%=rs("User_Name")%>" />&nbsp;&nbsp;&nbsp; 重置密码:&nbsp;<input type="password"
                                                                        name="userPassword" id="userPassword" value="" />&nbsp;&nbsp;&nbsp;
                                                                <input type="submit" name="Submit" id="Submit" value="确定" />&nbsp;&nbsp;&nbsp;<input
                                                                    type="reset" name="Reset" id="Reset" value="重填" />
                                                                <input name="action" type="hidden" value="editUser" /><input name="userId" type="hidden"
                                                                    value="<%=rs("User_Id")%>" />
                                                            </td>
                                                        </tr>
                                                        <tr class="tableTd">
                                                            <td width="1">
                                                            </td>
                                                        </tr>
                                                        <%
			Set rs=Nothing
			End If
                                                        %>
                                                    </table>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
		  Case "delUser"
                                        %>
                                        <tr>
                                            <td>
                                                <form name="delUserform" method="post" action="admin.asp">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td height="24" align="center" class="menu">
                                                                <font class="fontBlack"><b>删除用户</b></font></td>
                                                        </tr>
                                                        <tr class="tableTd">
                                                            <td width="1">
                                                            </td>
                                                        </tr>
                                                        <%
              openAdmin
			  Set rs=conn.ExeCute("SELECT * FROM [User] WHERE User_Id ="&Request.QueryString("User_Id"))
			  If Not rs.Eof Then
                                                        %>
                                                        <tr height="22">
                                                            <td align="center" valign="middle">
                                                                用户ID:&nbsp;<%=rs("User_Id")%>&nbsp;&nbsp;&nbsp; 用户名称:&nbsp;<%=rs("User_Name")%>&nbsp;&nbsp;&nbsp;
                                                                用户密码:&nbsp;<%=rs("User_Password")%>&nbsp;&nbsp;&nbsp;
                                                                <input type="submit" name="Submit" id="Submit" value="确定" />
                                                                <input name="action" type="hidden" value="delUser"><input name="userId" type="hidden"
                                                                    value="<%=rs("User_Id")%>" />
                                                            </td>
                                                        </tr>
                                                        <tr class="tableTd">
                                                            <td width="1">
                                                            </td>
                                                        </tr>
                                                        <%
			Set rs=Nothing
			End If
                                                        %>
                                                    </table>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
		    Case Else
                                        %>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <tr align="center" valign="middle">
                                            <td>
                                                <font class="fontAlert"><b>请选择管理列表中操作功能</b></font></td>
                                        </tr>
                                        <%
			End Select
                                        %>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%end sub%>
