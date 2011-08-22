<%
	Dim conn
	Dim connstr
	
function openBlog
	Set conn = Server.CreateObject("ADODB.Connection")
	connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(DB_Blog)
    conn.Open connstr
End Function

function openAdmin
	Set conn = Server.CreateObject("ADODB.Connection")
	connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(DB_Admin)
    conn.Open connstr
End Function
      
function closeDataBase
	conn.close
	Set conn = Nothing
End Function
%>