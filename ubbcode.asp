<%
dim ubbCode_temp_,text,ltext,text2,rid,ubbCode_temp_l,wh

'UBBCode process function - Recreated by SiC/CYAN
Function ubbCode(strContent,DisUBB,baseURL)
  If ScriptEngineMajorVersion<5 Or ScriptEngineMinorVersion<5 Then
		ubbCode=ubbCodeL(strContent,DisUBB,baseURL)
		Exit Function
	End If

	Dim re, strMatches, strMatch, tmpStr1, tmpStr2, tmpStr3, tmpStr4
  Set re=new RegExp
	re.IgnoreCase =true
	re.Global=True

	'Remove [#seperator#]
	strContent=replace(strContent,"[#seperator#]","")

	'AutoURL
    re.Pattern="([^=\]][\s]*?|^)(http|https|rstp|ftp|mms|ed2k)://([^\s\<\}\{]*)"
		Set strMatches=re.Execute(strContent)
		For Each strMatch in strMatches
			tmpStr1=CheckLinkStr(strMatch.SubMatches(2))
			strContent=replace(strContent,strMatch.Value,strMatch.SubMatches(0)&"<a target='_blank' href='"&strMatch.SubMatches(1)&"://"&tmpStr1&"'>"&strMatch.SubMatches(1)&"://"&tmpStr1&"</a>",1,-1,1)
		Next
		Set strMatches=nothing

	if Not DisUBB then
		'[code]
		re.Pattern="\[code\](<br>)+"
		strContent=re.Replace(strContent,"[code]")
		strContent=formatCode(strContent,baseURL)

		'[quote]
		re.Pattern="\[/quote\](<br>)+"
		strContent=re.Replace(strContent,"[/quote]")
		strContent=replace(strContent,"[quote]","[quote=Unkown]",1,-1,1)
		strContent=formatQuote(strContent,baseURL)

		'[url]
		re.Pattern = "\[url=([^<>]*?)\]([^<>]*?)\[\/url\]"
		Set strMatches=re.Execute(strContent)
		For Each strMatch in strMatches
			tmpStr1=CheckLinkStr(strMatch.SubMatches(0))
			tmpStr2=CheckLinkStr(strMatch.SubMatches(1))
			strContent=replace(strContent,strMatch.Value,"<a target='_blank' href='"&tmpStr1&"'>"&tmpStr2&"</a>",1,-1,1)
		Next
		Set strMatches=nothing
		re.Pattern = "\[url\]([^<>]*?)\[\/url\]"
		Set strMatches=re.Execute(strContent)
			For Each strMatch in strMatches
			tmpStr1=CheckLinkStr(strMatch.SubMatches(0))
			strContent=replace(strContent,strMatch.Value,"<a target='_blank' href='"&tmpStr1&"'>"&tmpStr1&"</a>",1,-1,1)
		Next
		Set strMatches=nothing

		'[email]
		re.Pattern = "\[email=([^<>]*?)\]([^<>]*?)\[\/email\]"
		Set strMatches=re.Execute(strContent)
			For Each strMatch in strMatches
			tmpStr1=CheckLinkStr(strMatch.SubMatches(0))
			tmpStr2=CheckLinkStr(strMatch.SubMatches(1))
			strContent=replace(strContent,strMatch.Value,"<a href='mailto:"&tmpStr1&"'>"&tmpStr2&"</a>",1,-1,1)
		Next
		Set strMatches=nothing
		re.Pattern = "\[email\]([^<>]*?)\[\/email\]"
		Set strMatches=re.Execute(strContent)
			For Each strMatch in strMatches
			tmpStr1=CheckLinkStr(strMatch.SubMatches(0))
			strContent=replace(strContent,strMatch.Value,"<a href='mailto:"&tmpStr1&"'>"&tmpStr1&"</a>",1,-1,1)
		Next
		Set strMatches=nothing

		'[file]
		re.Pattern="\[file=([^<>]*?)\]([^<>]*?)\[\/file\]"
		Set strMatches=re.Execute(strContent)
		For Each strMatch in strMatches
			tmpStr1=CheckLinkStr(strMatch.SubMatches(0))
			tmpStr2=CheckLinkStr(strMatch.SubMatches(1))
			strContent=replace(strContent,strMatch.Value,"<a href='"&tmpStr1&"'><img src='"&baseURL&"images/icon_save.gif' border='0' align='absmiddle' /> <b>File:</b> "&tmpStr2&"</a>",1,-1,1)
		Next
		Set strMatches=nothing
		re.Pattern="\[file\]([^<>]*?)\[\/file\]"
		Set strMatches=re.Execute(strContent)
		For Each strMatch in strMatches
			tmpStr1=CheckLinkStr(strMatch.SubMatches(0))
			strContent=replace(strContent,strMatch.Value,"<a href='"&tmpStr1&"'><img src='"&baseURL&"images/icon_save.gif' border='0' align='absmiddle' /> <b>File:</b> "&tmpStr1&"</a>",1,-1,1)
		Next
		Set strMatches=nothing

		'font style
		re.Pattern="\[font=([^<>\]]*?)\]"
		strContent=re.Replace(strContent,"<font face='$1'>")
		strContent=replace(strContent,"[/font]","</font>",1,-1,1)
		re.Pattern="\[color=([^<>\]]*?)\]"
		strContent=re.Replace(strContent,"<font color='$1'>")
		strContent=replace(strContent,"[/color]","</font>",1,-1,1)
		re.Pattern="\[align=([^<>\]]*?)\]"
		strContent=re.Replace(strContent,"<div align=$1>")
		strContent=replace(strContent,"[/align]","</div>",1,-1,1)
		re.Pattern="\[i\](.*?)\[\/i\]"
		strContent=re.Replace(strContent,"<i>$1</i>")
		re.Pattern="\[u\](.*?)\[\/u\]"
		strContent=re.Replace(strContent,"<u>$1</u>")
		re.Pattern="\[b\](.*?)\[\/b\]"
		strContent=re.Replace(strContent,"<b>$1</b>")
		re.Pattern="\[s\](.*?)\[\/s\]"
		strContent=re.Replace(strContent,"<s>$1</s>")
		re.Pattern="\[sub\](.*?)\[\/sub\]"
		strContent=re.Replace(strContent,"<sub>$1</sub>")
		re.Pattern="\[sup\](.*?)\[\/sup\]"
		strContent=re.Replace(strContent,"<sup>$1</sup>")
		re.Pattern="\[size=(\d*?)\]"
		strContent=re.Replace(strContent,"<font size='$1'>")
		strContent=replace(strContent,"[/size]","</font>",1,-1,1)

		'[list]
		re.Pattern="\[list\](.*?)\[\/list\]"
		strContent=re.Replace(strContent,"<ol>$1</ol>")
		re.Pattern="\[\*\]([^<>\[]*?)"
		strContent=re.Replace(strContent,"<li>$1</li>")

			'[img]
			re.Pattern="\[img\]([^<>]*?)\[\/img\]"
			Set strMatches=re.Execute(strContent)
			For Each strMatch in strMatches
				tmpStr1=CheckLinkStr(strMatch.SubMatches(0))
				strContent=replace(strContent,strMatch.Value,"<a href="""& tmpStr1 &""" target='_blank'><img src="""&baseURL&tmpStr1&""" onload='javascript:if(this.width>screen.width-300)this.width=screen.width-300' border='0' alt='Click to Open in New Window' /></a>",1,-1,1)
			Next
			Set strMatches=nothing
			re.Pattern="\[img=(left|right|center|absmiddle)\]([^<>]*?)\[\/img\]"
			Set strMatches=re.Execute(strContent)
			For Each strMatch in strMatches
				tmpStr1=strMatch.SubMatches(0)
				tmpStr2=CheckLinkStr(strMatch.SubMatches(1))
				strContent=replace(strContent,strMatch.Value,"<a href="""& tmpStr2 &""" target='_blank'><img src="""&baseURL&tmpStr2&""" align="""&tmpStr1&"""  onload='javascript:if(this.width>screen.width-300)this.width=screen.width-300' border='0' alt='Click to Open in New Window' /></a>",1,-1,1)
			Next
			Set strMatches=nothing
			re.Pattern="\[img=(\d*|),(\d*|)(,left|,right|,center|,absmiddle|)\]([^<>]*?)\[\/img\]"
			Set strMatches=re.Execute(strContent)
			For Each strMatch in strMatches
				tmpStr1=strMatch.SubMatches(0)
				tmpStr2=strMatch.SubMatches(1)
				tmpStr3=strMatch.SubMatches(2)
				If tmpStr3<>"" Then tmpStr3=Right(tmpStr3,Len(tmpStr3)-1)
				tmpStr4=CheckLinkStr(strMatch.SubMatches(3))
				strContent=replace(strContent,strMatch.Value,"<a href=""" & tmpStr4 & """ target='_blank'><img src="""&baseURL&tmpStr4&""" width="""&tmpStr1&""" height="""&tmpStr2&""" align="""&tmpStr3&""" onload='javascript:if(this.width>screen.width-300)this.width=screen.width-300' border='0' alt='Click to Open in New Window' /></a>",1,-1,1)
			Next
			Set strMatches=nothing
			'[swf][wmp][rm][qt]
			strContent=replace(strContent,"[swf]","[swf=500,350]",1,-1,1)
			strContent=replace(strContent,"[wmp]","[wmp=400,300]",1,-1,1)
			strContent=replace(strContent,"[rm]","[rm=400,300]",1,-1,1)
			strContent=replace(strContent,"[qt]","[qt=400,300]",1,-1,1)
			re.Pattern="\[(swf|wmp|rm|qt)=(\d*?|),(\d*?|)\]([^<>]*?)\[\/(swf|wmp|rm|qt)\]"
			Dim rStr
			Set strMatches=re.Execute(strContent)
			For Each strMatch in strMatches
				rStr=RandomStr(6)
				tmpStr1=CheckLinkStr(strMatch.SubMatches(3))
				strContent=replace(strContent,strMatch.Value,"<table border='0' cellpadding='4' cellspacing='1' class='ubb_showobj'><tr><td><input id='bubbobj"&rStr&"' type='hidden' value='-1' /><a href=""javascript:ubbShowObj('"&strMatch.SubMatches(0)&"','ubbobj"&rStr&"','"&strMatch.SubMatches(3)&"','"&strMatch.SubMatches(1)&"','"&strMatch.SubMatches(2)&"');"" onFocus=""if(this.blur)this.blur()""><img src='"&baseURL&"images/icon_media.gif' border='0'' align='absmiddle' /> <b>Click Here To Show/Hide Media</b></a></td></tr><tr><td id='ubbobj"&rStr&"'>Source URL: "&strMatch.SubMatches(3)&"</td></tr></table>",1,-1,1)
			Next
			Set strMatches=nothing

	End If	

	set re=nothing
 	ubbCode=DecUBB(strContent)
End Function

'UBBCode process function for ScriptEngine 5.5 below - created by SiC/CYAN
Function ubbCodeL(strContent,DisUBB,baseURL)
	Dim re, strMatches, strMatch, tmpStr1, tmpStr2
  Set re=new RegExp
	re.IgnoreCase =true
	re.Global=True

	'Remove [#seperator#]
	strContent=replace(strContent,"[#seperator#]","")

	'AutoURL
    re.Pattern="([^=\]][\s]*|^)(http|https|rstp|ftp|mms|ed2k)://([^\s\<\}\{]*)"
    strContent=re.Replace(strContent,"$1<a href='$2://$3' target='_blank'>$2://$3</a>")

	if Not DisUBB then
		'[code]
		re.Pattern="\[code\](<br>)+"
		strContent=re.Replace(strContent,"[code]")
		strContent=formatCode(strContent,baseURL)

		'[quote]
		re.Pattern="\[/quote\](<br>)+"
		strContent=re.Replace(strContent,"[/quote]")
		strContent=replace(strContent,"[quote]","[quote=Unkown]",1,-1,1)
		strContent=formatQuote(strContent,baseURL)

		'[url] - need link check
		re.Pattern = "\[url=([^<>]*)\]([^<>]*)\[\/url\]"
		strContent=re.replace(strContent,"<a target='_blank' href='$1'>$2</a>")
		re.Pattern = "\[url\]([^<>]*)\[\/url\]"
		strContent=re.replace(strContent,"<a target='_blank' href='$1'>$1</a>")

		'[email]
		re.Pattern = "\[email=([^<>]*)\]([^<>]*)\[\/email\]"
		strContent=re.replace(strContent,"<a href='mailto:$1'>$2</a>")
		re.Pattern = "\[email\]([^<>]*)\[\/email\]"
		strContent=re.replace(strContent,"<a href='mailto:$1'>$1</a>")

		'[file]
		re.Pattern="\[file=([^<>]*)\]([^<>]*)\[\/file\]"
		strContent=re.replace(strContent,"<a href='$1'><img src='"&baseURL&"images/icon_save.gif' border='0' align='absmiddle' /> <b>File:</b> $2</a>")
		re.Pattern="\[file\]([^<>]*)\[\/file\]"
		strContent=re.replace(strContent,"<a href='$1'><img src='"&baseURL&"images/icon_save.gif' border='0' align='absmiddle' /> <b>File:</b> $2</a>")

		'font style
		re.Pattern="\[font=([^<>\]]*)\]"
		strContent=re.Replace(strContent,"<font face='$1'>")
		strContent=replace(strContent,"[/font]","</font>",1,-1,1)
		re.Pattern="\[color=([^<>\]]*)\]"
		strContent=re.Replace(strContent,"<font color='$1'>")
		strContent=replace(strContent,"[/color]","</font>",1,-1,1)
		re.Pattern="\[align=([^<>\]]*)\]"
		strContent=re.Replace(strContent,"<div align=$1>")
		strContent=replace(strContent,"[/align]","</div>",1,-1,1)
		strContent=replace(strContent,"[i]","<i>",1,-1,1)
		strContent=replace(strContent,"[/i]","</i>",1,-1,1)
		strContent=replace(strContent,"[b]","<b>",1,-1,1)
		strContent=replace(strContent,"[/b]","</b>",1,-1,1)
		strContent=replace(strContent,"[u]","<u>",1,-1,1)
		strContent=replace(strContent,"[/u]","</u>",1,-1,1)
		strContent=replace(strContent,"[s]","<s>",1,-1,1)
		strContent=replace(strContent,"[/s]","</s>",1,-1,1)
		strContent=replace(strContent,"[sub]","<sub>",1,-1,1)
		strContent=replace(strContent,"[/sub]","</sub>",1,-1,1)
		strContent=replace(strContent,"[sup]","<sup>",1,-1,1)
		strContent=replace(strContent,"[/sup]","</sup>",1,-1,1)
		strContent=re.Replace(strContent,"<sup>$1</sup>")
		re.Pattern="\[size=(\d*)\]"
		strContent=re.Replace(strContent,"<font size='$1'>")
		strContent=replace(strContent,"[/size]","</font>",1,-1,1)

		'[list]
		re.Pattern="\[list\](.*)\[\/list\]"
		strContent=re.Replace(strContent,"<ol>$1</ol>")
		re.Pattern="\[\*\]([^<>\[]*)"
		strContent=re.Replace(strContent,"<li>$1</li>")

			'[img]
			re.Pattern="\[img\]([^<>]*)\[\/img\]"
			strContent=re.replace(strContent,"<a href=""$1"" target='_blank'><img src="""&baseURL&"$1"" onLoad='javascript:if(this.width>screen.width-300)this.width=screen.width-300' border='0' alt='Click to Open in New Window' /></a>")
			re.Pattern="\[img=(left|right|center|absmiddle)\]([^<>]*)\[\/img\]"
			strContent=re.replace(strContent,"<a href=""$2"" target='_blank'><img src="""&baseURL&"$2"" align=""$1"" onLoad='javascript:if(this.width>screen.width-300)this.width=screen.width-300' border='0' alt='Click to Open in New Window' /></a>")
			re.Pattern="\[img=(\d*|),(\d*|)\]([^<>]*)\[\/img\]"
			strContent=re.replace(strContent,"<a href=""$3"" target='_blank'><img src="""&baseURL&"$3"" width=""$1"" hiehgt=""$2"" onLoad='javascript:if(this.width>screen.width-300)this.width=screen.width-300' border='0' alt='Click to Open in New Window' /></a>")
			re.Pattern="\[img=(\d*|),(\d*|),(left|right|center|absmiddle)\]([^<>]*)\[\/img\]"
			strContent=re.replace(strContent,"<a href=""$4"" target='_blank'><img src="""&baseURL&"$4"" width=""$1"" hiehgt=""$2"" align=""$3"" onLoad='javascript:if(this.width>screen.width-300)this.width=screen.width-300' border='0' alt='Click to Open in New Window' /></a>")

			'[swf][wmp][rm][qt]
			strContent=replace(strContent,"[swf]","[swf=500,350]",1,-1,1)
			strContent=replace(strContent,"[wmp]","[wmp=400,300]",1,-1,1)
			strContent=replace(strContent,"[rm]","[rm=400,300]",1,-1,1)
			strContent=replace(strContent,"[qt]","[qt=400,300]",1,-1,1)
			re.Pattern="\[(swf|wmp|rm|qt)=(\d*|),(\d*|)\]([^<>]*)\[\/(swf|wmp|rm|qt)\]"
			Dim rStr
			re.Global=False
			Do while re.Test(strContent)
				rStr=RandomStr(6)
				strContent=re.replace(strContent,"<table border='0' cellpadding='4' cellspacing='1' class='ubb_showobj'><tr><td><input id='bubbobj"&rStr&"' type='hidden' value='-1' /><a href=""javascript:ubbShowObj('$1','ubbobj"&rStr&"','$4','$2','$3');"" onFocus=""if(this.blur)this.blur()""><img src='"&baseURL&"images/icon_media.gif' border='0'' align='absmiddle' /> <b>Click Here To Show/Hide Media</b></a></td></tr><tr><td id='ubbobj"&rStr&"'>Source URL: $4</td></tr></table>")
			Loop
			re.Global=True
	End If	

	set re=nothing
 	ubbCodeL=DecUBB(strContent)
End Function

'--- Helper Functions Below ---
Function EncUBB(strContent)
  strContent=Replace(strContent,"[","$[$",1,-1,1)
  strContent=Replace(strContent,"]","$]$",1,-1,1)
  EncUBB=strContent
End Function

Function DecUBB(strContent)
  strContent=Replace(strContent,"$[$","[",1,-1,1)
  strContent=Replace(strContent,"$]$","]",1,-1,1)
  DecUBB=strContent
End Function

Function RandomStr(Length)
	Dim i, tempS
	tempS = "abcdefghijklmnopqrstuvwxyz1234567890" 
	RandomStr = ""
	If isNumeric(Length) = False Then 
		Exit Function 
	End If 
	For i = 1 to Length 
		Randomize 
		RandomStr = RandomStr & Mid(tempS,Int((Len(tempS) * Rnd) + 1),1)
	Next 
End Function 

'format [quote]
Function formatQuote(strContent,baseURL)
	Dim strAuthor,strText,intStart,intEnd,strResult,strSource
	Do While InStr(1, strContent, "[QUOTE=", 1) > 0 AND InStr(1, strContent, "[/QUOTE]", 1) > 0
		intStart = InStr(1, strContent, "[QUOTE=", 1) + 7
		intEnd = InStr(intStart, strContent, "]", 1)
		If intStart > 6 AND intEnd > 0 Then
			strAuthor = Trim(Mid(strContent, intStart, intEnd-intStart))
		End If
		intStart = intStart + Len(strAuthor) + 1
		intEnd = InStr(intStart, strContent, "[/QUOTE]", 1)
		If intEnd - intStart =< 0 Then intEnd = intStart + Len(strAuthor)
		If intEnd > intStart Then
			strText = Trim(Mid(strContent, intStart, intEnd-intStart))
			strAuthor = Replace(strAuthor, """", "", 1, -1, 1)
			strResult = "<table width=""90%"" border=""0"" cellpadding=""0"" cellspacing=""1"" class=""ubb_quote"">" & vbCrLf & "<tr><td class='ubb_quote_title'>Quoted from " & strAuthor & ":</td></tr>" & vbCrLf & "<tr>" & vbCrLf & "<td>" & ubbcode(strText,false,false,true,false,baseURL) & "</td>" & vbCrLf & "</tr>" & vbCrLf & "</table>"
		End If
		intStart = InStr(1, strContent, "[QUOTE=", 1)
		intEnd = InStr(intStart, strContent, "[/QUOTE]", 1) + 8
		If intEnd - intStart =< 7 Then intEnd = intStart + Len(strAuthor) + 8
		strSource = Trim(Mid(strContent, intStart, intEnd-intStart))
		If strResult <> "" Then
			strContent = Replace(strContent, strSource, strResult, 1, -1, 1)
		Else
			strContent = Replace(strContent, strSource, Replace(strSource, "[", "&#91;", 1, -1, 1), 1, -1, 1)
		End If
	Loop
	formatQuote = strContent
End Function

'format [code]
Function formatCode(strContent,baseURL)
	Dim strAuthor,strText,intStart,intEnd,strResult,strSource
	Do While InStr(1, strContent, "[CODE]", 1) > 0 AND InStr(1, strContent, "[/CODE]", 1) > 0
		intStart = InStr(1, strContent, "[CODE]", 1) + 6
		intEnd = InStr(intStart, strContent, "[/CODE]", 1)
		If intEnd - intStart =< 0 Then intEnd = intStart
		If intEnd > intStart Then
			strText = Trim(Mid(strContent, intStart, intEnd-intStart))
			strResult = "<table width=""97%"" border=""0"" cellpadding=""0"" cellspacing=""1"" class=""ubb_code"">" & vbCrLf & "<tr>" & vbCrLf & "<td>" & EncUBB(strText) & "</td>" & vbCrLf & "</tr>" & vbCrLf & "</table>"
		End If
		intStart = InStr(1, strContent, "[CODE]", 1)
		intEnd = InStr(intStart, strContent, "[/CODE]", 1) + 7
		If intEnd - intStart =< 7 Then intEnd = intStart + 7
		strSource = Trim(Mid(strContent, intStart, intEnd-intStart))
		If strResult <> "" Then
			strContent = Replace(strContent, strSource, strResult, 1, -1, 1)
		Else
			strContent = Replace(strContent, strSource, Replace(strSource, "[", "&#91;", 1, -1, 1), 1, -1, 1)
		End If
	Loop
	formatCode = strContent
End Function

'Remove malicous charcters from links and images
Function CheckLinkStr(Str)
	Str = Replace(Str, "document.cookie", ".", 1, -1, 1)
	Str = Replace(Str, "document.write", ".", 1, -1, 1)
	Str = Replace(Str, "javascript:", "javascript ", 1, -1, 1)
	Str = Replace(Str, "vbscript:", "vbscript ", 1, -1, 1)
	Str = Replace(Str, "javascript :", "javascript ", 1, -1, 1)
	Str = Replace(Str, "vbscript :", "vbscript ", 1, -1, 1)
	Str = Replace(Str, "[", "&#91;", 1, -1, 1)
	Str = Replace(Str, "]", "&#93;", 1, -1, 1)
	Str = Replace(Str, "<", "&#60;", 1, -1, 1)
	Str = Replace(Str, ">", "&#62;", 1, -1, 1)
	Str = Replace(Str, "{", "&#123;", 1, -1, 1)
	Str = Replace(Str, "}", "&#125;", 1, -1, 1)
	Str = Replace(Str, "|", "&#124;", 1, -1, 1)
	Str = Replace(Str, "script", "&#115;cript", 1, -1, 0)
	Str = Replace(Str, "SCRIPT", "&#083;CRIPT", 1, -1, 0)
	Str = Replace(Str, "Script", "&#083;cript", 1, -1, 0)
	Str = Replace(Str, "script", "&#083;cript", 1, -1, 1)
	Str = Replace(Str, "object", "&#111;bject", 1, -1, 0)
	Str = Replace(Str, "OBJECT", "&#079;BJECT", 1, -1, 0)
	Str = Replace(Str, "Object", "&#079;bject", 1, -1, 0)
	Str = Replace(Str, "object", "&#079;bject", 1, -1, 1)
	Str = Replace(Str, "applet", "&#097;pplet", 1, -1, 0)
	Str = Replace(Str, "APPLET", "&#065;PPLET", 1, -1, 0)
	Str = Replace(Str, "Applet", "&#065;pplet", 1, -1, 0)
	Str = Replace(Str, "applet", "&#065;pplet", 1, -1, 1)
	Str = Replace(Str, "embed", "&#101;mbed", 1, -1, 0)
	Str = Replace(Str, "EMBED", "&#069;MBED", 1, -1, 0)
	Str = Replace(Str, "Embed", "&#069;mbed", 1, -1, 0)
	Str = Replace(Str, "embed", "&#069;mbed", 1, -1, 1)
	Str = Replace(Str, "document", "&#100;ocument", 1, -1, 0)
	Str = Replace(Str, "DOCUMENT", "&#068;OCUMENT", 1, -1, 0)
	Str = Replace(Str, "Document", "&#068;ocument", 1, -1, 0)
	Str = Replace(Str, "document", "&#068;ocument", 1, -1, 1)
	Str = Replace(Str, "cookie", "&#099;ookie", 1, -1, 0)
	Str = Replace(Str, "COOKIE", "&#067;OOKIE", 1, -1, 0)
	Str = Replace(Str, "Cookie", "&#067;ookie", 1, -1, 0)
	Str = Replace(Str, "cookie", "&#067;ookie", 1, -1, 1)
	Str = Replace(Str, "event", "&#101;vent", 1, -1, 0)
	Str = Replace(Str, "EVENT", "&#069;VENT", 1, -1, 0)
	Str = Replace(Str, "Event", "&#069;vent", 1, -1, 0)
	Str = Replace(Str, "event", "&#069;vent", 1, -1, 1)
	Str = Replace(Str, "on", "&#111;n", 1, -1, 0)
	Str = Replace(Str, "ON", "&#079;N", 1, -1, 0)
	Str = Replace(Str, "On", "&#079;n", 1, -1, 0)
	Str = Replace(Str, "on", "&#111;n", 1, -1, 1)
	CheckLinkStr = Str
End Function

%>