<!--#include file="conn.asp" -->
<!--#include file="config.asp" -->
<!--#include file="function.asp" -->
<!--#include file="ubbcode.asp" -->
<%
Response.ContentType = "text/html" 
Response.CharSet = "gb2312"
Response.CacheControl = "no-cache"

Dim vbQu
vbQu = chrW(34)
Dim Command
Command = Request.QueryString("Command")
Command = LCase(Command)

If Command = "" Then
    Response.End()
End If

Select Case Command
	Case "help","h","?"
        GetHelp()
        Response.End()	
    Case "ls","dir","list"
        GetAllBlog()
	    Response.End()
	Case "search","find"
	    GetSearchBlog()
	    Response.End()
	Case "read","show"
	    Dim Content_ID
	    Content_ID = Request.QueryString("Content_ID")
        IF Content_ID = "" Then
	        Content_ID = GetCurrentBlog()
	    End If
	    Read(Content_ID)
	    Response.End()
    Case "date"
        Response.Write(FormatDatetime(Date(),1) & " " & FormatDateTime(Now(), 3) & " " & WeekdayName(Weekday(Date())))
        Response.End()
    Case "current", "cursor"
    	Content_ID = Request.QueryString("Content_ID")
        IF Content_ID <> "" AND IsNumeric(Content_ID) Then
            SetCurrentBlog(Content_ID)
        End If
        Response.Write("Current post ID: " & GetCurrentBlog())
        Response.End()
    Case "latest", "last", "l"
        Dim MaxBlog
        MaxBlog = GetMaxBlog()
        Read(MaxBlog)
        SetCurrentBlog(MaxBlog)
        Response.End()
    Case "first", "f"
        Dim MinBlog
        MinBlog = GetMinBlog()
        Read(MinBlog)
        Response.End()
    Case "prev", "p"
        Dim CurrentBlog
        CurrentBlog = GetCurrentBlog()
        MinBlog = GetMinBlog()
        If CurrentBlog - 1 >= MinBlog Then
            CurrentBlog = CurrentBlog - 1
        End If
        Read(CurrentBlog)
        SetCurrentBlog(CurrentBlog)
        Response.End()
    Case "next", "n"
        CurrentBlog = GetCurrentBlog()
        MaxBlog = GetMaxBlog()
        If CurrentBlog + 1 <= MaxBlog Then
            CurrentBlog = CurrentBlog + 1
        End If
        Read(CurrentBlog)
        SetCurrentBlog(CurrentBlog)
        Response.End()
    Case "comments"
        GetComments(GetCurrentBlog())
        Response.End()
    Case "random", "rand", "r"
        Randomize
        CurrentBlog = Int((10 * Rnd) + 1) Mod GetMaxBlog()
        Read(CurrentBlog)
        SetCurrentBlog(CurrentBlog)
        Response.End()
    Case "categories"        
        GetCategories()
        Response.End()
    Case "category"
        GetClassBlog(Request.QueryString("Class_ID"))
        Response.End()
    Case "recommended"
        GetRecommendedBlog()
        Response.End()
    Case "posteddate"
        GetBlogDate()
        Response.End()
    Case Else
        IF IsNumeric(Command) Then
            Read(Command)
        Else
            Response.Write("<p>Unrecognized command. Type 'help' for assistance.</p>")
        End If
	End Select


Sub GetHelp()
    Response.Write("<table><tr><td colspan='2'>ZhangSichu's CLI Blog (c) 2006-2007 ZhangSichu<br /><br /></td><td></td></tr><tr><td colspan='2'>command, alias required [optional]: description<br /><br /></td><td></td></tr><tr><td id='frontCell'>help, h, ?:</td><td>Help (this)</td></tr><tr><td>gui, startx:</td><td>Return to GUI (graphical interface) blog</td></tr><tr><td>ls, dir, list:</td><td>List all posts (ordered by ID/date)</td></tr><tr><td>search, find [search terms]:</td><td>Search posts</td></tr><tr><td>read, show [post_id]:</td><td>Read post # (no post_id: read current)</td></tr><tr><td>comments:</td><td>Read comments for current post</td></tr><tr><td>current, cursor [post_id]:</td><td>Show current post_id (set if post_id given, nearest higher if no post matches)</td></tr><tr><td>latest, last, l:</td><td>Move to and show latest post</td></tr><tr><td>next, n:</td><td>Move to and show next post</td></tr><tr><td>prev, p:</td><td>Move to and show previous post</td></tr><tr><td>first, f:</td><td> Move to and show first post</td></tr><tr><td>random, rand, r:</td><td>Show random post</td></tr><tr><td>categories:</td><td>List categories</td></tr><tr><td>category cat_id:</td><td>List posts in category</td></tr><tr><td>post_id:</td><td>Read post</td></tr><tr><td>posteddate:</td><td>List all post posted date.</td></tr><tr><td>recommended:</td><td>List all recommended posts.</td></tr><tr><td>date:</td><td>Current date/time</td></tr><tr><td>cls:</td><td>Clear screen</td></tr><tr><td>google [keyword]:</td><td>Google search</td></tr><tr><td><u>Notes</u></td><td>On listings (ls, find, category, pages) you can click a title to view the relevant post/page.</td></tr></table>")
End Sub

Sub GetAllBlog()
        openBlog
        sql="SELECT * FROM Blog_Content ORDER BY Content_Id DESC"
	    Set rs=conn.ExeCute(sql)
	    
	    If rs.Eof And rs.bof Then
	        Response.Write("No blog here coming soon.")
	    	closeDataBase
	        Exit Sub
	    End If
	    
	    Response.Write("<table>")
	    Do While Not rs.Eof
	        Response.Write("<tr onclick=" & vbQu & "showpost('" & rs("Content_ID") & "')" & vbQu & "><td>" & rs("Content_ID") & "</td><td onmouseover=" & vbQu & "javascript:this.className='linkyHover'" & vbQu &" onmouseout=" & vbQu &"javascript:this.className='linkyNormal'" & vbQu &" class='linkyNormal'>" & rs("Content_Title") &"</td><td>" & rs("Content_Time") &"</td></tr>")
            rs.Movenext
        Loop
        Response.Write("</table>")
        closeDataBase
End Sub

Sub GetSearchBlog()
	    Dim Keyword
	    Keyword = trim(replace(Request.QueryString("Keyword"),"'",""))
	    If Keyword = "" Then
            sql="SELECT * FROM Blog_Content ORDER BY Content_Id DESC"
        Else
            sql="SELECT * FROM Blog_Content WHERE (Content_ID LIKE '%" & Keyword &"%') OR (Content_Title LIKE '%" & Keyword & "%') OR (Content_Content LIKE '%" & Keyword &"%') ORDER BY Content_Id DESC"
	    End If
	    
	    openBlog
	    Set rs=conn.ExeCute(sql)
	    
	    If rs.Eof And rs.bof Then
	        Response.Write("No belog belong this keyword.")
	    	closeDataBase
	        Exit Sub
	    End If
	    Dim count
	    count = 0
	    Response.Write("<table>")
	    Do While Not rs.Eof	        
	        Response.Write("<tr onclick=" & vbQu & "showpost('" & rs("Content_ID") & "')" & vbQu & "><td>" & rs("Content_ID") & "</td><td onmouseover=" & vbQu & "javascript:this.className='linkyHover'" & vbQu &" onmouseout=" & vbQu &"javascript:this.className='linkyNormal'" & vbQu &" class='linkyNormal'>" & rs("Content_Title") &"</td><td>" & rs("Content_Time") &"</td></tr>")
            count = count +  1
            rs.Movenext
        Loop
        Response.Write("<tr><td></td><td></td><td> Count : "& count &"</td></tr>")
        Response.Write("</table>")
        closeDataBase
End Sub

Sub Read(Content_ID)
        If Not IsNumeric(Content_ID) Then
            Response.Write("<p>Please input a post ID.</p>")
            Exit Sub
        End If
        openBlog
        sql="SELECT * FROM Blog_Content WHERE Content_ID = "& Content_ID &" ORDER BY Content_Id DESC"
	    Set rs=conn.ExeCute(sql)
	    If rs.Eof And rs.bof Then
	        Response.Write("<p>No post with that ID.</p>")
	        closeDataBase
	        Exit Sub
	    End If
        Response.Write("<h1>"& rs("Content_Title") &"</h1>")
        Response.Write("<div class='blogContent'>" & UbbCode(HTMLEncode(rs("Content_Content")),(Not rs("Content_Ubb")),"") & "</div>")
        Dim CommentTitle
        CommentTitle = "Comment"
        If rs("Content_Comment") > 0 Then
            CommentTitle = "Comments"
        End If
        Response.Write("<div class='blogFooter'>Posted @ " & rs("Content_Time") & " | Hits (<font color='#ff0000'> "& rs("Content_Count") &" </font>) | <a href='blogview.asp?Content_Id=" & rs("Content_Id") & "' target='_blank'> " & CommentTitle & " (<font color='#ff0000'>" & rs("Content_Comment") & "</font>)</a>" & "</div>")
        SetCurrentBlog(rs("Content_ID"))
        closeDataBase
End Sub

Sub GetComments(Content_ID)
        If Not IsNumeric(Content_ID) Then
            Response.Write("<p>This post no comment.</p>")
            Exit Sub
        End If
        
        openBlog
        Set rs=conn.ExeCute("SELECT * FROM Blog_Comment WHERE Content_Id = "& Content_ID &" ORDER BY Comment_Id DESC")
		If rs.Eof And rs.Bof Then
            Response.Write("<p>This post no comment.</p>")
            closeDataBase
            Exit Sub
        End If
        
        count = 0
        Response.Write("<table>")
        Do While Not rs.Eof
            count = count +  1
	        Response.Write("<tr><td>" & count & "</td><td>" & rs("Comment_Time") &" "& rs("Comment_Author") & "</td></tr>")
            Response.Write("<tr><td></td><td>" & HTMLEncode(rs("Comment_Content")) & "<br /><br /></td></tr>")
            rs.Movenext
        Loop
        Response.Write("</table>")
        closeDataBase
End Sub

Sub GetBlogDate()
        openBlog
        Set rs=conn.ExeCute("SELECT Content_Year,Content_Month,Content_Day,Count(*) AS Content_Date_Count FROM Blog_Content GROUP BY Content_Year,Content_Month,Content_Day ORDER BY Content_Year ASC, Content_Month ASC, Content_Day ASC")
        
        If rs.Eof And rs.Bof Then
            Response.Write("<p>There is no post coming soon.</p>")
            closeDataBase
            Exit Sub
        End If
        count = 0
        Response.Write("<table>")
        Do While Not rs.Eof
          count = count + 1
          Response.Write("<tr><td>" & count & "</td><td>" & rs("Content_Year") & "Äê" & rs("Content_Month")& "ÔÂ" & rs("Content_Day") & "ÈÕ" &"</td><td>(" & rs("Content_Date_Count") &")</td></tr>")
          rs.Movenext
        Loop
        Response.Write("<tr><td></td><td></td><td>Count : " & count &"</td></tr>")      
        Response.Write("</table>")
        closeDataBase
End Sub

Sub GetCategories()
        openBlog
        Set rs=conn.ExeCute("select * from Blog_Class")
        
        If rs.Eof And rs.Bof Then
            Response.Write("<p>There is no category.</p>")
            closeDataBase
            Exit Sub
        End If
        count = 0
        Response.Write("<table>")
        Do While Not rs.Eof
          Response.Write("<tr onclick=" & vbQu & "showcategory('" & rs("Class_Id") & "')" & vbQu & "><td>" & rs("Class_Id") & "</td><td onmouseover=" & vbQu & "javascript:this.className='linkyHover'" & vbQu &" onmouseout=" & vbQu &"javascript:this.className='linkyNormal'" & vbQu &" class='linkyNormal'>" & rs("Class_Name") &"</td><td>(" & rs("Class_Count") &")</td></tr>")
          count = count + 1
          rs.Movenext
        Loop
        Response.Write("<tr><td></td><td></td><td>Count : " & count &"</td></tr>")      
        Response.Write("</table>")
        closeDataBase
End Sub

Sub GetClassBlog(Class_ID)
        If Not IsNumeric(Class_ID) OR Class_ID="" Then
            Response.Write("<p>Please input a category ID.</p>")
            Exit Sub
        End If 
        
        openBlog
        Set rs=conn.ExeCute("SELECT * FROM Blog_Content WHERE Content_Class = "& Class_ID &" ORDER BY Content_Id DESC")
        
        If rs.Eof And rs.Bof Then
            Response.Write("<p>The category no post.</p>")
            closeDataBase
            Exit Sub
        End If
        
	    count = 0
	    Response.Write("<table>")
	    Do While Not rs.Eof	        
	        Response.Write("<tr onclick=" & vbQu & "showpost('" & rs("Content_ID") & "')" & vbQu & "><td>" & rs("Content_ID") & "</td><td onmouseover=" & vbQu & "javascript:this.className='linkyHover'" & vbQu &" onmouseout=" & vbQu &"javascript:this.className='linkyNormal'" & vbQu &" class='linkyNormal'>" & rs("Content_Title") &"</td><td>" & rs("Content_Time") &"</td></tr>")
            count = count +  1
            rs.Movenext
        Loop
        Response.Write("<tr><td></td><td></td><td> Count : "& count &"</td></tr>")
        Response.Write("</table>")
        closeDataBase
        
End Sub

Sub GetRecommendedBlog()
        openBlog
        sql="SELECT * FROM Blog_Content WHERE Content_Topic = TRUE ORDER BY Content_Id DESC"
	    Set rs=conn.ExeCute(sql)
	    
	    If rs.Eof And rs.bof Then
	        Response.Write("No blog here coming soon.")
	    	closeDataBase
	        Exit Sub
	    End If
        
        count = 0
	    Response.Write("<table>")
	    Do While Not rs.Eof
	        Response.Write("<tr onclick=" & vbQu & "showpost('" & rs("Content_ID") & "')" & vbQu & "><td>" & rs("Content_ID") & "</td><td onmouseover=" & vbQu & "javascript:this.className='linkyHover'" & vbQu &" onmouseout=" & vbQu &"javascript:this.className='linkyNormal'" & vbQu &" class='linkyNormal'>" & rs("Content_Title") &"</td><td>" & rs("Content_Time") &"</td></tr>")
            count = count +  1
            rs.Movenext
        Loop
        Response.Write("<tr><td></td><td></td><td> Count : "& count &"</td></tr>")
        Response.Write("</table>")
        closeDataBase
End Sub

Function GetCurrentBlog()
        If Session("CurrentBlog") = "" Then
	        Session("CurrentBlog") = GetMaxBlog()
	    End If
	    GetCurrentBlog = Session("CurrentBlog")
End Function

Function GetMaxBlog()
        If Session("MaxBlog") = "" Then
            openBlog
            sql="SELECT Top 1 Content_ID FROM Blog_Content ORDER BY Content_Id DESC"
	        Set rs=conn.ExeCute(sql)
	        Session("MaxBlog") = rs("Content_ID")
	        closeDataBase
	    End If
	    GetMaxBlog = Session("MaxBlog")
End Function

Function GetMinBlog()
        If Session("MinBlog") = "" Then
            openBlog
            sql="SELECT Top 1 Content_ID FROM Blog_Content ORDER BY Content_Id ASC"
	        Set rs=conn.ExeCute(sql)
	        Session("MinBlog") = rs("Content_ID")
	        closeDataBase
	    End If
	    GetMinBlog = Session("MinBlog")
End Function

Sub SetCurrentBlog(Content_ID)
        Session("CurrentBlog") = Content_ID
End Sub
%>
