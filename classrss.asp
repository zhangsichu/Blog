<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="function.asp" -->
<!--#include file="ubbcode.asp" -->
<%If Request.QueryString("Class_Id")="" Then Response.End() End If%>
<%
Dim vbQu
vbQu = chrW(34)
%>
<%Response.Write("<?xml version=" & vbQu &"1.0" & vbQu & " encoding="& vbQu &"gb2312"& vbQu &"?>") %>
<rss version='2.0' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:trackback='http://madskills.com/public/xml/rss/module/trackback/'
    xmlns:wfw='http://wellformedweb.org/CommentAPI/' xmlns:slash='http://purl.org/rss/1.0/modules/slash/'>
<%
openBlog
Set rsclass=conn.ExeCute("SELECT Class_Name FROM Blog_Class WHERE Class_Id = "&cint(Request.QueryString("Class_Id")))
%>
<channel>
<title> <![CDATA[<%=rsclass("Class_Name")%>]]> </title>
<link>http://<%=Request.ServerVariables("SERVER_NAME")%>/default.asp</link>
<language>zh-cn</language>
<docs><%=Web_Owner%>'s Blog</docs>
<generator>Rss Generator By ZhangSichu.com</generator>
<%
Set rsclass=Nothing
Set rs=conn.ExeCute("SELECT * FROM Blog_Content WHERE Content_Class = "&Request.QueryString("Class_Id")&" ORDER BY Content_Id DESC")
Do While Not rs.Eof
%>
<item>
<title> <![CDATA[<%=rs("Content_Title")%>]]></title>
<link> http://<%=Request.ServerVariables("SERVER_NAME")%>/blogview.asp?Content_Id=<%=rs("Content_Id")%> </link>
<author> <%=Web_Owner%> </author>
<pubDate> <%=rs("Content_Time")%> </pubDate>
<description> <![CDATA[<%=UbbCode(HTMLEncode(left(rs("Content_Content"),instr(110,rs("Content_Content"),"¡£"))),(Not rs("Content_Ubb")),"")%>]]>
 </description>
</item>
<%
rs.Movenext
Loop 
Set rs=Nothing
closeDataBase
%>
</channel></rss>
