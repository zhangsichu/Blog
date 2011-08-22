<%
Function IsInteger(byVal Para)
	IsInteger=False
	If Not (IsNull(Para) Or Trim(Para)="" Or Not IsNumeric(Para)) Then
		IsInteger=True
	End If
End Function

ReDim Link_Days(2,0)'存所有有连接的天

Sub Calendar(C_Year,C_Month,C_Day)  'BLOG Calendar
    Dim ToUrl
    Dim SelfUrl
	Dim This_Year,This_Month,This_Day,RS_Month,Link_TF,Is_Weeked
	IF Not IsInteger(C_Year) Then C_Year=Year(Now()) End If
	IF Not IsInteger(C_Month) Then C_Month=Month(Now()) End If
	IF Not IsInteger(C_Day) Then C_Day=Cint(Day(Now())) End If
	C_Year=Cint(C_Year)
	C_Month=Cint(C_Month)
	C_Day=Cint(C_Day)
	This_Year=C_Year
	This_Month=C_Month
	This_Day=C_Day
	Dim To_Day,To_Month,To_Year
	To_Day=Cint(Day(Now()))
	To_Month=Cint(Month(Now()))
	To_Year=Cint(Year(Now()))
    ToUrl = "defaultresponse.asp"
    SelfUrl = "calendarresponse.asp"
    
	Dim Month_Name(12)
	Month_Name(1)="01"
	Month_Name(2)="02"
	Month_Name(3)="03"
	Month_Name(4)="04"
	Month_Name(5)="05"
	Month_Name(6)="06"
	Month_Name(7)="07"
	Month_Name(8)="08"
	Month_Name(9)="09"
	Month_Name(10)="10"
	Month_Name(11)="11"
	Month_Name(12)="12"
	
	Dim Month_Days(12)
	Month_Days(1)=31
	Month_Days(2)=28
	Month_Days(3)=31
	Month_Days(4)=30
	Month_Days(5)=31
	Month_Days(6)=30
	Month_Days(7)=31
	Month_Days(8)=31
	Month_Days(9)=30
	Month_Days(10)=31
	Month_Days(11)=30
	Month_Days(12)=31
	
	sql="SELECT Content_Year,Content_Month,Content_Day FROM Blog_Content WHERE Content_Year="&C_Year&" AND Content_Month="&C_Month&" ORDER BY Content_Day"
	Set RS_Month=conn.Execute(sql)
	Dim the_Day
	the_Day=0
	Do While NOT RS_Month.EOF
		IF RS_Month("Content_Day")<>the_Day Then
			the_Day=RS_Month("Content_Day")
			ReDim PreServe Link_Days(2,Link_Count)
			Link_Days(0,Link_Count)=RS_Month("Content_Month")
			Link_Days(1,Link_Count)=RS_Month("Content_Day")
			Link_Days(2,Link_Count)=ToUrl&"?viewType=byDay&blogYear="&RS_Month("Content_Year")&"&blogMonth="&RS_Month("Content_Month")&"&blogDay="&RS_Month("Content_Day")
			Link_Count=Link_Count+1
		End IF
		RS_Month.MoveNext
	Loop
	Set RS_Month=Nothing

	If IsDate("February 29, " & This_Year) Then Month_Days(2)=29 End If
	
	Dim Start_Week
	Start_Week=WeekDay(C_Month&"-1-"&C_Year)-1
	
	Dim Next_Month,Next_Year,Pro_Month,Pro_Year
	Next_Month=C_Month+1
	Next_Year=C_Year
	IF Next_Month>12 then 
		Next_Month=1
		Next_Year=Next_Year+1
	End IF
	Pro_Month=C_Month-1
	Pro_Year=C_Year
	IF Pro_Month<1 then 
		Pro_Month=12
		Pro_Year=Pro_Year-1
	End IF
	
	Dim vbQu
	vbQu = ChrW(34)
	Response.Write("<table width='99%' border='0' align='center' cellpadding='3' cellspacing='1' class='panel'><tr class='calendar'><td align='center' colspan='7'><a href='#' onclick="& vbQu &"GetClassDisplay('"&ToUrl&"?viewType=byYear&blogYear="&C_Year-1&"&blogMonth="&C_Month&"'); GetCalendarDisplay('"&SelfUrl&"?viewType=byYear&blogYear="&C_Year-1&"&blogMonth="&C_Month&"'); return false;"& vbQu &" title='Previous Year'>&lt;&lt;</a>&nbsp;&nbsp;")
	Response.Write("<a href='#' onclick="& vbQu &"GetClassDisplay('"&ToUrl&"?viewType=byMonth&blogYear="&Pro_Year&"&blogMonth="&Pro_Month&"'); GetCalendarDisplay('"&SelfUrl&"?viewType=byMonth&blogYear="&Pro_Year&"&blogMonth="&Pro_Month&"'); return false;"& vbQu &" title='Previous Month'>&lt;</a>&nbsp;&nbsp;<b>")
	Response.Write("<a href='#' onclick="& vbQu &"GetClassDisplay('"&ToUrl&"?viewType=byYear&blogYear="&C_Year&"'); GetCalendarDisplay('"&SelfUrl&"?viewType=byYear&blogYear="&C_Year&"'); return false;" &vbQu &" >"&C_Year&"</a>")
	Response.Write(" - <a href='#' onclick="& vbQu &"GetClassDisplay('"& ToUrl&"?viewType=byMonth&blogYear="&C_Year&"&blogMonth="&C_Month&"'); GetCalendarDisplay('"&SelfUrl&"?viewType=byMonth&blogYear="&C_Year&"&blogMonth="&C_Month&"'); return false;"& vbQu &">"&Month_Name(C_Month)&"</a></b>&nbsp;&nbsp;")
	Response.Write("<a href='#' onclick="& vbQu &"GetClassDisplay('"& ToUrl&"?viewType=byMonth&blogYear="&Next_Year&"&blogMonth="&Next_Month&"'); GetCalendarDisplay('"& SelfUrl&"?viewType=byMonth&blogYear="&Next_Year&"&blogMonth="&Next_Month&"'); return false;"& vbQu &" title='Next Month'>&gt;</a>&nbsp;&nbsp;")
	Response.Write("<a href='#' onclick="& vbQu &"GetClassDisplay('"& ToUrl&"?viewType=byYear&blogYear="&C_Year+1&"&blogMonth="&C_Month&"'); GetCalendarDisplay('"& SelfUrl&"?viewType=byYear&blogYear="&C_Year+1&"&blogMonth="&C_Month&"'); return false;"& vbQu &" title='Next Year'>&gt;&gt;</a></td></tr>")
	
	Response.Write("<tr class='calendar-weekdays'><td>Su</td><td>Mo</td><td>Tu</td><td>We</td><td>Th</td><td>Fr</td><td>Sa</td></tr><tr>")
	
	Dim i,j,k,l,m
	
	For  i=0 TO Start_Week-1
		Response.Write("<td>&nbsp;</td>")
	Next
	
	Dim ThisDayStyle
	
	j=1
	
	While j<=Month_Days(This_Month)
	 	For k=start_Week To 6
			IF j<=Month_Days(This_Month) Then 
				ThisDayStyle=" class='calendar-day'"
				Is_Weeked=Weekday(This_Month&"-"&j&"-"&This_Year)
				IF Is_Weeked=1 or Is_Weeked=7 then ThisDayStyle=" class='calendar-weeked'" End If
				IF j=This_Day Then ThisDayStyle=" class='calendar-thisday'" End If
				IF j=To_Day AND This_Year=To_Year AND This_Month=To_Month Then ThisDayStyle=" class='calendar-today'" End If
				Response.Write("<td"&ThisDayStyle&">")
				
				Link_TF=False
				For l=0 TO Ubound(Link_Days,2)
				IF Link_Days(0,l)<>"" Then
					IF Link_Days(0,l)=This_Month AND Link_Days(1,l)=j Then
						Response.Write("<a href='#' onclick="& vbQu &"GetClassDisplay('"&Link_Days(2,l)&"'); return false;"& vbQu &" class='calendar-link'>")
						Link_TF=True
					End IF
				End IF
				Next
				
				Response.Write(j)
				
				IF Link_TF=True then 
					Response.Write("<img src='images/attached.gif' width='7' height='10' border='0'></a>")
					Link_TF=False
				End If
				Response.Write("</td>")
			End If
			j=j+1
		Next
	Start_Week=0
	Response.Write("</tr>")
	Wend
	
	Response.Write("</table>")
End Sub
%>
