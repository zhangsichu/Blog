<!--#include file="calendar.asp" -->
<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="function.asp" -->
<!--#include file="ubbcode.asp" -->
<%
        Response.ContentType = "text/html" 
        Response.CharSet = "gb2312"
        openBlog
		Dim blogYear,blogMonth,blogDay
		blogYear=Trim(Request.QueryString("blogYear"))
		blogMonth=Trim(Request.QueryString("blogMonth"))
		blogDay=Trim(Request.QueryString("blogDay"))
		If Not IsInteger(blogYear) Then blogYear=""
		If Not IsInteger(blogMonth) Then blogMonth=""
		If Not IsInteger(blogDay) Then blogDay=""
		Calendar blogYear,blogMonth,blogDay
		closeDataBase
%>
