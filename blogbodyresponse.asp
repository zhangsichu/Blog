<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="ubbcode.asp" -->
<!--#include file="function.asp" -->
<%
Response.ContentType = "text/html" 
Response.CharSet = "gb2312"
Response.CacheControl = "no-cache"
If Request.QueryString("Content_Id")="" Then Response.End() End If
openBlog
sql="SELECT * FROM Blog_Content WHERE Content_Id = "&Request.QueryString("Content_Id")
Set rs=Server.CreateObject("adodb.recordset")
rs.Open sql,conn,1,3
rs("Content_Count")=rs("Content_Count")+1
rs.Update
rs.Close

Set rs=conn.ExeCute("SELECT * FROM Blog_Content WHERE Content_Id = "&Request.QueryString("Content_Id"))
Response.Write("<div>"&UbbCode(HTMLEncode(rs("Content_Content")),(Not rs("Content_Ubb")),"")&"</div>")
closeDataBase
%>
