<%
Function HTMLEncode(byVal reString)
	Dim Str:Str=reString
	IF Not isnull(Str) Then
		Str=UnCheckStr(Str)
		Str = replace(Str, "&", "&amp;", 1, -1, 1)
		Str = replace(Str, ">", "&gt;", 1, -1, 1)
		Str = replace(Str, "<", "&lt;", 1, -1, 1)
	  Str = Replace(Str, CHR(9), "&nbsp;&nbsp;", 1, -1, 1)
		Str = Replace(Str, CHR(34), "&quot;", 1, -1, 1)
		Str = Replace(Str, CHR(39), "&#39;", 1, -1, 1)
		Str = Replace(Str, CHR(13), "", 1, -1, 1)
		Str = Replace(Str, CHR(10), "<br>", 1, -1, 1)
		HTMLEncode = Str
	End IF
End Function

Function UnCheckStr(Str)
		Str=Replace(Str, "sel&#101;ct", "select", 1, -1, 1)
		Str=Replace(Str, "jo&#105;n", "join", 1, -1, 1)
		Str=Replace(Str, "un&#105;on", "union", 1, -1, 1)
		Str=Replace(Str, "wh&#101;re", "where", 1, -1, 1)
		Str=Replace(Str, "ins&#101;rt", "insert", 1, -1, 1)
		Str=Replace(Str, "del&#101;te", "delete", 1, -1, 1)
		Str=Replace(Str, "up&#100;ate", "update", 1, -1, 1)
		Str=Replace(Str, "lik&#101;", "like", 1, -1, 1)
		Str=Replace(Str, "dro&#112;", "drop", 1, -1, 1)
		Str=Replace(Str, "cr&#101;ate", "create", 1, -1, 1)
		Str=Replace(Str, "mod&#105;fy", "modify", 1, -1, 1)
		Str=Replace(Str, "ren&#097;me", "rename", 1, -1, 1)
		Str=Replace(Str, "alt&#101;r", "alter", 1, -1, 1)
		Str=Replace(Str, "ca&#115;t", "cast", 1, -1, 1)
		UnCheckStr=Str
End Function
%>