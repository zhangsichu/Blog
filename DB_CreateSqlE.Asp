<% @ LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Option Explicit
response.buffer=true
	Response.Expires = -1
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "cache-ctrol","no-cache"

'build2004-11-20 V1.05
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>CooSel2.0 Access to SQLserver 数据库生迁脚本编写器 V1.05(V37 PaintBlue.Net 2004 Acp Code)</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="V37">
<META NAME="Keywords" CONTENT="PaintBlue.Net,PaintBlue">
<META NAME="Description" CONTENT="PaintBlue.Net">
<style>
table{	color: #000000;
		font-size: 9pt;
		FONT-FAMILY: "Tahoma","MS Shell Dlg";
		}
td	{	color: #000000;
		font-size: 9pt;
		}table{	color: #000000;
		font-size: 9pt;
		FONT-FAMILY: "Tahoma","MS Shell Dlg";
		}
body	{	color: #000000;
		font-size: 9pt;
		}
</style>
</HEAD>
<body bgCOLOR=eeeeee text="#000000" leftmargin="0" marginwidth="100%" topmargin="0" bottommargin="20">
<%
'2004-11-18/
'fix exec=0 =1 type
'fix conv now() date() time() type
'fix binary ole conv 不做导入
'fix Asp代码生成

dim enMode,UniCodeMode
dim DB_Name,ExtName,FileName
dim rs,CONN,CONNstr
	DB_Name=questStr("DB_Name")
	FileName=questStr("DB_Name")
	enMode=questStr("enMode")
	UniCodeMode=questStr("UniCodeMode")
	if not isnumeric(enMode) then enMode=0
'2004-11-18
	dim databaseName,darr,errinfo
	dim loginName
	dim loginPassword
	dim sapass
		errinfo=""
		databaseName=questStr("databaseName")
		loginName=questStr("loginName")
		loginPassword=questStr("loginPassword")
		sapass=questStr("sapass")
	if not checkchar(loginName) then
		errinfo=errinfo & "要生成的SQL数据库登陆名称含不合法字符\n"
	end if
	if not checkchar(databaseName) then
		errinfo=errinfo & "要生成的SQL数据库名称含不合法字符\n"
	end if
	if errinfo<>"" then GetAlert errinfo
	if databaseName="" and DB_Name<>"" then
		darr=split(DB_Name,"\")
		databaseName=split(darr(ubound(darr)),".")(0)
	end if
'--------/	
	if DB_Name<>"" then 	
		enMode=clng(enMode)
		if enMode=0 then
			ExtName=".Sql"
		else
			ExtName=".Asp"
		end if
		Call openDB(DB_Name)
		Call CreateSQL(DB_Name,enMode)
	else
		if DB_Name="" then DB_Name="data/mydb.mdb"
		Call Main()
	end if
'2004-11-18
Function CheckChar(testchar) 
	CheckChar=true 
	dim chars,i,j,charlen
	chars=testchar
	dim ichar
		ichar=array("=","\","(",")","/","%",chr(32),"?"," & ","$",";",",","'",chr(34),chr(9),chr(0),"*",">","<","|",":","#")
	charlen=len(chars)
	for i=0 to ubound(ichar)
		if instr(chars,ichar(i))>0 then
			CheckChar=false
			exit function
		end if
	next
End function

SUB GetAlert(errinfo)
	%>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<HTML><HEAD><TITLE>CooSel GetAlert Error</TITLE>
	<META NAME="Generator" CONTENT="EditPlus">
	<META NAME="Author" CONTENT="V37"></head>
	<body leftmargin="0" rightmargin="0" topmargin="0" bgcolor="#D4D0C8">
	</BODY>
	</HTML>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		alert("<%=errinfo%>");
		window.history.back();
	//-->
	</SCRIPT><%
	if isObject(CONN) then closeDB
	response.end
End SUB

Sub CloseDB
	CONN.close
	Set CONN=nothing
End Sub

Sub MAIN()
%>
	<style>
	.titlebar {
		FONT-WEIGHT: bold; FONT-SIZE: 12pt; FILTER: dropshadow(color=#333333, offx=1, offy=2); WIDTH: 100%; COLOR: #ffffff; FONT-FAMILY: Tahoma,Verdana, Arial, sans-serif; POSITION: relative; TOP: 1px
	}
	</style>
	<FORM METHOD=POST ACTION="?action=1" Name=DBform>
	<TABLE width="100%" cellspacing=0 border=0>
		<TR bgcolor=#D4D0C8>
			<TD  align=center height=32><a href=http://www.paintblue.net/ target=_blank><img src=http://www.paintblue.net/bbs/images/TitleLogo.gif border=0></a></td><td><span class=titlebar><font color=#ffffff><b>MiniAccess Editor V1.0 P3 (Access To SQLserver 数据升迁 脚本编写器)</b></font></span></TD>
		<td></td></TR>
	<TABLE align=center width="100%" cellspacing=1 cellpadding=3 border=0>
	</TABLE>
	<TABLE align=center width="100%" cellspacing=1 cellpadding=3 border=0>
	<TR  bgcolor=#667766><TD align=right  height=10></TD><TD></TD></TR>
	<TR bgcolor=#D4D0C8>
		<TD align=right><span id=a>编写模式</span></TD>
		<TD>
		<INPUT TYPE="radio" NAME="enMode" value="0" <%if enMode=0 then response.write "checked" end if%> >Sql文本
		<INPUT TYPE="radio" NAME="enMode" value="1" <%if enMode=1 then response.write "checked" end if%> >Asp代码
		<!-- <INPUT TYPE="radio" NAME="enMode" value="2" <%if enMode=2 then response.write "checked" end if%> >编写完后直接运行 -->
		&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="UniCodeMode" value="1" checked> 文本和备注按Unicode导入
		</TD>
	</TR>
	<TR bgcolor=#D4D0C8>
		<TD align=right width=250>MDB数据库路径</TD>
		<TD><INPUT TYPE="text" NAME="DB_Name" value="<%=DB_Name%>" style="width:70%;"> </TD>
	</TR>
	<TR bgcolor=#D4D0C8>
		<TD align=right width=250>SQLserver登陆帐号(sa)</TD>
		<TD><INPUT TYPE="password" NAME="sapass" value="" style="width:30%;"> SQL数据库(sa)登陆密码,可以不用输入,生成完脚本再提供</TD>
	</TR>
	<TR bgcolor=#D4D0D8>
		<TD align=right width=250>导入SQL的后的数据库名</TD>
		<TD><INPUT TYPE="text" NAME="databasename" value="<%="myDatabase"%>" style="width:30%;"> </TD>
	</TR>
	<TR bgcolor=#D4D0D8>
		<TD align=right width=250>导入SQL的数据库登陆帐号</TD>
		<TD><INPUT TYPE="text" NAME="loginName" value="<%="my_login"%>" style="width:30%;"> </TD>
	</TR>
	<TR bgcolor=#D4D0D8>
		<TD align=right width=250>导入SQL的数据库登陆密码</TD>
		<TD><INPUT TYPE="password" NAME="loginPassword" value="<%="my_pass"%>" style="width:30%;"> </TD>
	</TR>
	<TR  bgcolor=#667766><TD align=right  height=10></TD><TD></TD></TR>
	<TR >
		<TD height=38></TD>
		<TD bgcolor=#D4D0C8> &nbsp; &nbsp;<INPUT TYPE="submit" value=" 确 定 " style="width:80;"></TD>
	</TR>
	<TR >
		<TD height=38></TD>
		<TD bgcolor=#D4D0C8> &nbsp; &nbsp;
		<li><<简介>>
		<li>For Access 数据库导入 SQLserver 的版本，生成的在SQL2000下执行的 SQL脚本，<br> &nbsp; &nbsp; &nbsp; &nbsp;除了还原库结构，还同时将Access的数据导入 SQLserver
			<br> &nbsp; &nbsp; &nbsp; &nbsp;由于SQLserver的视图不一样，Access能自动处理同名列，<br> &nbsp; &nbsp; &nbsp; &nbsp;脚本生成对含Select *有同名列的联合查询作了自动转换，有可能需要对照重修改一下
		<li>功能:可编写Access数据库的常用的主要对象,包括 <br> &nbsp; &nbsp; &nbsp; &nbsp;<b>表,视图,索引,约束,包括 默认值,主键,自动编号,外键</b>(表关系)
		<li>编写完自动保存为原数据库名+相应扩展的文件
		<li>Asp模式可直接生成带表单输入的可执行的Asp文件,用生成的Asp文件即可生成新的数据库
		<li>Sql模式可直接生成纯Sql语句文本</li><br><br></TD>
	</TR>
	</Table>
	</FORM>
<%
End SUB
'====MiniAcces Editor1.0part2 Access SQL脚本编写器(V37 PaintBlue.Net 2004 Acp Code)=========

SUB openDB(DB_Name)
		if inStr(DB_Name,":/")=0 and inStr(DB_Name,":\")=0 then 
			DB_Name=server.mappath(DB_Name)
		end if
		Set CONN = Server.CreateObject("ADODB.CONNection")
	on error resume next	
		CONN.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DB_Name
		if err.number<>0 then
			rw "数据库打开失败,错误为:" & err.description,0
			err.clear
		else
			Set rs=Server.CreateObject("adodb.recordSet")
		end if
End SUB

SUB CreateSQL(DB_Name,exec)
	'创建模式
	'exec = 0 : 生成SQL语句
	'exec = 1 : 生成Asp程序
	dim tbls,tabsArr,ub,I,TtempStr,TtempStrHead,remchar
	dim TableStr
	if exec=1 then
		TtempStrHead="<" & "% @ LANGUAGE=""VBSCRIPT""%" & ">" & vbcrlf
		TtempStrHead=TtempStrHead & "<" & "%Option Explicit" & vbcrlf
		TtempStrHead=TtempStrHead & "response.buffer=true" & vbcrlf & vbcrlf
		TtempStrHead=TtempStrHead & "'=========================================================================" & vbcrlf & "'Access 数据库 SQL 脚本生成 by MiniAccess Edit V1.0 P2(V37 PaintBlue.Net 2004 Asp Code)" & vbcrlf & "'=========================================================================" & vbcrlf & vbcrlf
	end if
	if instr(DB_Name,":\")=0 and instr(DB_Name,":/")=0 then
			DB_Name=Server.MapPath(DB_Name)
	end if 
			CONNstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DB_Name
		Set CONN = Server.CreateObject("ADODB.Connection")
			CONN.Open CONNstr	
	
	'rs.open "[查询3]",CONN
	'for i=0 to rs.fields.count-1
	'	rw rs(i).name,1
	'next
	'response.end
	
	'编写CONN对象 
	if exec=1 then
		TtempStr=TtempStr & "SUB CreateDB(DB_Name,NewDB_Name,loginName,loginPassword,sapass,DTS)" & vbcrlf
		TtempStr=TtempStr & "DIM CONN,CONNstr" & vbcrlf
		'TtempStr=TtempStr & "CONNStr=""Provider=Microsoft.Jet.OLEDB.4.0;Data Source="" & DB_Name" & vbcrlf
		TtempStr=TtempStr & "CONNStr=""Provider=SQLOLEDB.1;Password='"" & sapass & ""';Persist Security InFso=true;User ID='sa';Initial Catalog='Master';Data Source='(local)';CONNect Timeout=30""" & vbcrlf
		TtempStr=TtempStr & "Set CONN=Server.CreateObject(""ADODB.Connection"")" & vbcrlf
		TtempStr=TtempStr & "CONN.open CONNStr" & vbcrlf & vbcrlf
			
		'2004-11-18 
		TtempStr=TtempStr & "CONN.execute(""Create Database ["" & NewDB_Name & ""]"")" & vbcrlf
		
		TtempStr=TtempStr & "CONN.close" & vbcrlf
		TtempStr=TtempStr & "CONNStr=""Provider=SQLOLEDB.1;Password='"" & sapass & ""';Persist Security InFso=true;User ID='sa';Initial Catalog='"" & NewDB_Name & ""';Data Source='(local)';CONNect Timeout=30""" & vbcrlf
		TtempStr=TtempStr & "CONN.open CONNStr" & vbcrlf & vbcrlf
		'2004-11-18 
		TtempStr=TtempStr & "CONN.execute(""exec sp_addlogin '"" & loginName & ""','"" & loginPassword & ""','"" & NewDB_Name & ""'"")" & vbcrlf
		TtempStr=TtempStr & "CONN.execute(""exec sp_adduser '"" & loginName & ""','"" & loginName & ""','db_owner'"")" & vbcrlf
		'-----/
	elseif exec=0 then
		TtempStr=TtempStr & "Create Database [" & databaseName & "]" & vbcrlf & " go" & vbcrlf
		TtempStr=TtempStr & "use [" & databaseName & "]" & vbcrlf & " go" & vbcrlf & vbcrlf
	
		'2004-11-18 
		TtempStr=TtempStr & "exec sp_addlogin '" & loginName & "','" & loginPassword & "','" & databaseName & "'" & vbcrlf & " go" & vbcrlf
		TtempStr=TtempStr & "exec sp_adduser '" & loginName & "','" & loginName & "','db_owner'" & vbcrlf & " go" & vbcrlf
		'-----/
	end if


	'编写表/索引对象
	Set tbls=CONN.openSchema(20) 'adSchemaPrimaryKeys  
		tbls.Filter =" TABLE_TYPE='TABLE' " '筛选出有默认值，但允许null的列
	while Not tbls.eof
		TableStr=TableStr & "|" & tbls("TABLE_Name")
		tbls.movenext
	wend
		tbls.filter=0
		tbls.close
		set tbls=nothing
		TableStr=mid(TableStr,2)
		if exec=1 then
			remchar="'"
		elseif exec=0 then 
			remchar="--"
		end if
	if TableStr<>"" then
		tabsArr=split(TableStr,"|")
		ub=ubound(tabsArr)
		for I=0 to ub
			TtempStr=TtempStr & remchar & "[" & tabsArr(I) & "]:" &  vbcrlf
			TtempStr=TtempStr & CreatTableSql(tabsArr(I),exec) & vbcrlf & vbcrlf
		next
	end if
	'编写数据导入

	if exec=1 then TtempStr=TtempStr &  "If DTS=1 then " &  vbcrlf

	TtempStr=TtempStr & CreateOpenDataSource(TableStr,DB_Name,exec)
	
	if exec=1 then TtempStr=TtempStr &  "End iF " &  vbcrlf

	'编写表关系
	if TableStr<>"" then TtempStr=TtempStr & CreatForeignSql(exec)
	'编写视图
	TtempStr=TtempStr & CreatViewSql(exec) & vbcrlf
	
	if exec=1 then 
		TtempStr=replace(TtempStr,">",""" & chr(62) & """)
		TtempStr=replace(TtempStr,"<",""" & chr(60) & """)
		TtempStr=TtempStr & "End SUB" &  vbcrlf & vbcrlf
		
		TtempStr=TtempStr & Add_aspExec()

		TtempStr=TtempStrHead & TtempStr & vbcrlf & "%" & ">"
	
	elseif exec=0 then 
		TtempStr=TtempStr & "--=========================================================================" & vbcrlf & "--Access To SQL 数据库升迁脚本 by MiniAccess Edit V1.0 P2(V37 PaintBlue.Net 2004)" & vbcrlf & "--=========================================================================" & vbcrlf & vbcrlf
        TtempStr = TtempStr & vbCrLf & "--连接字串:CONNstr=""Provider=SQLOLEDB.1;Persist Security InFso=true;Data Source='(local)';Initial Catalog='" & databaseName & "';User ID='" & loginName & "';Password='" & loginPassword & "';CONNect Timeout=30""" & vbCrLf & vbCrLf
	end if
		call Ados_Write(TtempStr,DB_Name & ExtName,"gb2312")
		rw "<br><img width=100 height=0>" & DB_Name & "的SQL脚本编写完成",1
		rw "<img width=100 height=0>已经保存文件为<b><font color=blue>" & DB_Name & ExtName & "</font></b>[<a href=?>返回</a>]:",1
		rw "<center><textarea style=""width:70%;height:500px;"" wrap=""off"">" & server.Htmlencode(TtempStr) & "</textarea></center>",1
End SUB

function CreatViewSql(exec)
	dim cols
	dim FKtable,PK_cols,FK_cols,tmpStr,tmpStr1,VIEW_DEFINITION
	Set cols=CONN.openSchema(23)
	cols.filter=0
	while not cols.eof
			tmpStr1=""

			VIEW_DEFINITION=replace(cols("VIEW_DEFINITION"),chr(13),"")
			VIEW_DEFINITION=replace(VIEW_DEFINITION,chr(10)," ")
			VIEW_DEFINITION=left(VIEW_DEFINITION,len(VIEW_DEFINITION)-1)
			VIEW_DEFINITION=TransView(cols("TABLE_NAME"),VIEW_DEFINITION)
			tmpStr1="Create view [dbo].[" & cols("TABLE_NAME") & "] As " & VIEW_DEFINITION & ""
			if exec=1 then tmpStr1="CONN.execute(""" & tmpStr1 & """)"
			tmpStr=tmpStr & vbcrlf & tmpStr1
			if exec=0 then tmpStr=tmpStr & vbcrlf & " go"
		cols.movenext
	wend
	cols.close
	set cols=nothing
	CreatViewSql=tmpStr
End Function

Function TransView(viewName,Str)
	dim S
	S=lcase(Str)
	S=replace(S,chr(9)," ")
	S=replace(S,chr(32)," ")
	S=replace(S,chr(10)," ")
	S=replace(S,chr(13),"")
	S=replace(S,";"," ")
	do while instr(S,"  ")>0
		S=replace(S,"  "," ")
	loop
	S=replace(S,"count(*)","count(*) as count_x")
	if instr(lcase(S),"* from")=0 then
		TransView=S
	else
		TransView=replace(S,"* from",GetviewColumnStr(viewName) & " from")
	end if
	'rw GetviewColumnStr(viewName),1
	'rw instr(lcase(S),"* from"),1
End Function

function GetviewColumnStr(viewName)
	dim rs,i,tmpstr,arr,j,chg
	chg=false
	'rw "[" & viewName & "]",0
	set rs=server.createobject("adodb.recordset")
	'rw "select * from [" & tablename & "] where 1=0",1
	rs.open "[" & viewName & "]",conn
	dim tmp
	if rs.fields.count>0 then
		tmpstr=rs(0).name
		for i=1 to rs.fields.count-1
			tmpstr=tmpstr & "," & rs(i).name
		next
			tmpstr=lcase(tmpstr)
		arr=split(tmpstr,",")
		for i=0 to ubound(arr)
			tmp=arr(i)
			arr(i)="[" & arr(i) & "]"
			if instr(arr(i),".")>0 then
				arr(i)=replace(arr(i),".","].[")
				arr(i)=arr(i) & " as " & replace(tmp,".","_")
				chg=true
			end if
		next
		if chg then
			GetviewColumnStr=join(arr,",")
		else
			GetviewColumnStr="*"
		end if
	else
		GetviewColumnStr=""
	end if
end function

function CreatTableSql(byval tableName,exec)
	dim cols
	dim TmpStr,TmpStr1
	Set cols=CONN.openSchema(4)
	dim splitchar,splitchar1
	if exec=1 then 
		splitchar=""""
		splitchar1=""" & _"
	elseif exec=0 then 
		splitchar=""
		splitchar1=""
	end if
	cols.filter="Table_name='" & tableName & "'"
	if cols.eof then
	   exit function
	end if
	dim cat,autoclumn,n,chkPrimaryKey
	n=0

' 编写表脚本
	autoclumn=GetAutoincrementCoulmnT(tableName)
	
	tmpStr1="CREATE TABLE [dbo].[" & tableName & "] (" &  splitchar1 & vbcrlf
	dim autoclumnStr,columnStr
	if autoclumn<>"" then
		autoclumnStr=  "	" & splitchar & "[" &  autoclumn  & "] integer IDENTITY (1," & GetIncrement(tableName,autoclumn) & ") not null"
	end if
	
	n=0 
	do 
		n=n+1
		cols.filter="Table_name='" & tableName & "' and ORDINAL_POSITION=" & n
		if cols.eof  then exit do
		if n>1 then tmpStr1=tmpStr1 & "," & splitchar1 & vbcrlf
		if autoclumn=cols("Column_name") then
			tmpStr1=tmpStr1 & autoclumnStr 
		else
			tmpStr1=tmpStr1 & "	" & splitchar & "[" &  cols("Column_name")  & "] " &  lcase(datatypeStr(cols("DATA_TYPE"),cols("CHARACTER_MAXIMUM_LENGTH"))) &  defaultStr(cols("DATA_TYPE"),cols("COLUMN_DEFAULT"),exec) & nullStr(cols("IS_NULLABLE"), tablename, cols("Column_name")) 
		end if
		cols.movenext
	loop
		tmpStr1=tmpStr1 & splitchar1 & vbcrlf  & "	" & splitchar & ") ON [Primary]"
	cols.close
		if exec=0 then tmpStr1=tmpStr1 & splitchar1 & vbcrlf  & "" & splitchar & " go"
	if exec=1 then 
		TmpStr1="CONN.execute(""" & TmpStr1 & """)"
	end if
		tmpStr=tmpStr & vbcrlf & tmpStr1

' 编写索引脚本
	dim InxArr,i,kstr,j
	InxArr=split(getInxArr(tableName),",")
	Set cols=CONN.openSchema(12)

	for i=0 to ubound(InxArr)
		cols.filter="Table_name='" & tableName & "' and index_name='" & InxArr(i) & "'"
		kstr=""
		tmpStr1=""
		if Not isForeignIndex(tableName,InxArr(i)) then '外键索引不进行编写
			while not cols.eof
				kstr=kstr & ",[" & cols("column_name") & "] " & GetInxDesc(TableName,InxArr(i),cols("column_name"))
				cols.movenext
			wend
			if isPrimaryKey(TableName,InxArr(i)) then 
				tmpStr1=tmpStr1 & " Alter TABLE [dbo].[" & tableName & "] WITH NOCHECK ADD CONSTRAINT [PK_" & tableName & "] Primary Key Clustered (" & mid(kstr,2) & ")  ON [Primary] "
			else
				tmpStr1=tmpStr1 & "CREATE "
				if isUnique(TableName,InxArr(i)) then tmpStr1=tmpStr1 & "Unique "
				tmpStr1=tmpStr1 & "INDEX [" & InxArr(i) & "] on [dbo].[" & tableName & "](" & mid(kstr,2) & ") ON [Primary]"
			end if
			if exec=1 then tmpStr1="CONN.execute(""" & tmpStr1 & """)"
			if exec=0 then tmpStr1=tmpStr1 & vbcrlf & " go"
			tmpStr=tmpStr & vbcrlf & tmpStr1
		end if
	next
	cols.close
	cols.filter=0
	CreatTableSql=TmpStr
End function

function CreatForeignSql(exec)
dim cols
dim FKtable,PK_cols,FK_cols,tmpStr,tmpStr1
Set cols=CONN.openSchema(27)
cols.filter="PK_NAME<>Null"
	while not cols.eof
			tmpStr1=""
			tmpStr1="ALTER TABLE [" & cols("FK_TABLE_NAME") & "] " & _  
						"Add CONSTRAINT [" & cols("FK_NAME") & "] " & _  
						"FOREIGN KEY ([" & cols("FK_COLUMN_NAME") & "]) REFERENCES " & _
						"[" & cols("PK_TABLE_NAME") & "] ([" & cols("PK_COLUMN_NAME") & "]) "
			if cols("UPDATE_RULE")="CASCADE" then	tmpStr1=tmpStr1 & "ON UPDATE CASCADE "
			if cols("DELETE_RULE")="CASCADE" then	tmpStr1=tmpStr1 & "ON DELETE CASCADE "
			if exec=1 then tmpStr1="CONN.execute(""" & tmpStr1 & """)"
			tmpStr=tmpStr & vbcrlf & tmpStr1
			if exec=0 then tmpStr=tmpStr & vbcrlf & " go"
		cols.movenext
	wend
	cols.filter=0
	cols.close
	set cols=nothing
	CreatForeignSql=tmpStr
End Function

Function CreateOpenDataSource(TableStr,DB_Name,exec)
'SET IDENTITY_INSERT Co_admin ON
'go
'INSERT INTO dbo.Co_admin (id,username,password,MasterFlag,adduser)
'SELECT id,username,password,MasterFlag,adduser 
'FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0','Data Source="d:\www\lfgbox\coosel2.0\data\coosel.asa"')...[Co_admin]
'go
'SET IDENTITY_INSERT dbo.Co_admin OFF
'go
	dim splitchar,splitchar1,columnStr,rs,i,TmpStr1,tmp,remchar
	if exec=1 then
		remchar="'"
		splitchar=""""
		splitchar1=""" & _"
	elseif exec=0 then
		remchar="--"
		splitchar=""
		splitchar1=""
	end if
Set rs=CONN.openSchema(20)   
	rs.Filter ="TABLE_TYPE='TABLE'" 
	while not rs.EOF
		'rw server.htmlencode(rs("TABLE_NAME")),1
		columnStr=GetColumnStr(rs("TABLE_NAME"))
	  if columnStr<>"" then
		'if n>0 then tmpStr1=tmpStr1 &  splitchar1 & vbcrlf
		TmpStr1=TmpStr1 & remchar & "[" & rs("TABLE_NAME") & "]:" &  vbcrlf
		TmpStr1=TmpStr1 & "CONN.CommandTimeout = 600 " &  vbcrlf
		if GetAutoincrementCoulmnT(rs("TABLE_NAME"))<>"" then
			tmp="SET IDENTITY_INSERT [dbo].[" & rs("TABLE_NAME") & "] ON"
			if exec=0 then 
				tmp=tmp & vbcrlf & " go " &  vbcrlf
			elseif exec=1 then  
				tmp="CONN.execute(""" & tmp & """)" & vbcrlf
			end if
				TmpStr1=TmpStr1 & tmp & vbcrlf
		end if
		tmp="INSERT INTO [dbo].[" & rs("TABLE_NAME") & "] (" & columnStr & ") " &  splitchar1 & vbcrlf
		tmp=tmp & "	" & splitchar & "SELECT " & columnStr & " " &  splitchar1 & vbcrlf
		if exec=0 then 
			tmp=tmp & "	" & splitchar & "FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0','Data Source=" & splitchar & """" & DB_Name & """" & splitchar & "')...[" & rs("TABLE_NAME") & "]"
			tmp=tmp & vbcrlf & " go " &  vbcrlf
		elseif  exec=1 then
			tmp=tmp & "	" & splitchar & "FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0','Data Source=" & splitchar & """"" & DB_Name & """"" & splitchar & "')...[" & rs("TABLE_NAME") & "]"
			tmp="CONN.execute(""" & tmp & """)" & vbcrlf
		end if
		TmpStr1=TmpStr1 & tmp & vbcrlf
		if GetAutoincrementCoulmnT(rs("TABLE_NAME"))<>"" then
			tmp="SET IDENTITY_INSERT [dbo].[" & rs("TABLE_NAME") & "] Off"
			if exec=0 then 
				tmp=tmp & vbcrlf & " go " &  vbcrlf & vbcrlf
			elseif exec=1 then
				tmp="CONN.execute(""" & tmp & """)" & vbcrlf & vbcrlf
			end if
			TmpStr1=TmpStr1 & tmp & vbcrlf
	  	end if
       end if
		RS.MoveNext
	wend
	TmpStr1=TmpStr1 & "CONN.CommandTimeout = 30 " &  vbcrlf
	rs.filter=0
	rs.close
	set rs=nothing
	CreateOpenDataSource=TmpStr1
End Function

function GetColumnStr(tablename)
	dim rs,i,tmpstr
	set rs=server.createobject("adodb.recordset")
	'rw "select * from [" & tablename & "] where 1=0",1
	rs.open "select * from [" & tablename & "] where 1=0",conn
	if rs.fields.count>0 then
		for i=0 to rs.fields.count-1
			'rw rs(i).name & "_" & rs(i).type & "<br>",1
			if rs(i).type<>205 then tmpstr=tmpstr & "," & rs(i).name
		next
		if tmpstr<>"" then
			 GetColumnStr=mid(tmpstr,2)
		else GetColumnStr=""
		end if
	else
		GetColumnStr=""
	end if
end function

SUB Ac2SQLStr()
	dim rs
	TMPstr=""
Set rs=CONN.openSchema(20)   
	rs.Filter ="TABLE_TYPE='TABLE'" 
	while not rs.EOF
		TMPstr=TMPstr & "SELECT  * INTO [tmp_" & rs("TABLE_NAME") & "] FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0','Data Source=""d:\www\lfgbox\paintblue2.0f2\pbbs\database\paintbase#.asa""')...[" & rs("TABLE_NAME") & "]<br>"
		NN=NN+1
		RS.MoveNext
	wend
	rs.filter=0
	rs.close
	set rs=nothing
End SUB

'判断是否是外键索引
Function isForeignIndex(TableName,indexName)
	dim cols
	Set cols=CONN.openSchema(27)
	cols.filter="FK_TABLE_Name='" & TableName & "' and FK_NAME='" & indexName & "'"
	if Not cols.eof then
		isForeignIndex=true
	else
		isForeignIndex=false
	end if
End Function
'取得索引列的排序属性
function GetInxDesc(TableName,indexName,ColumnName)
	dim cat
	set cat=Server.CreateObject("ADOX.Catalog") 
	cat.ActiveCONNection =CONNstr
	if cat.Tables("" & TableName & "").Indexes("" & indexName & "").Columns("" & ColumnName & "").SortOrder=2 then
		GetInxDesc="Desc"
	else
		GetInxDesc=""
	end if
	set cat=nothing
end function
'取得列数组
function getColumArr(tableName)
	dim cols,arr(),n
	redim arr(-1)
	n=0
	redim arr(n)
	set cols=CONN.openSchema(4)
	cols.filter="Table_Name='" & tableName & "'"
	while not cols.eof
		redim Preserve arr(n)
		arr(n)=cols("column_name")
		cols.movenext
		n=n+1
	wend
	cols.filter=0
	cols.close
	set cols=nothing
	getColumArr=arr
end function
'取得索引数组
function getInxArr1(tableName)
	dim cols,arr(),n,tmpCol
	redim arr(-1)
	n=0
	set cols=CONN.openSchema(12)
	cols.filter="Table_Name='" & tableName & "'"
	while not cols.eof
		if cols("index_name")<>tmpCol then
			redim Preserve arr(n)
			arr(n)=cols("index_name")
			n=n+1
		end if
		tmpCol=cols("index_name")
		cols.movenext
	wend
	cols.filter=0
	cols.close
	set cols=nothing
	getInxArr=arr
end function

'取得索引数组
Function getInxArr(tablename)
    Dim cols
    Dim n
    Dim tmpCol
    Dim tmps
    n = 0
    Set cols = CONN.openSchema(12)
    cols.Filter = "Table_Name='" & tablename & "'"
    While Not cols.EOF
        If cols("index_name") <> tmpCol Then
            tmps = tmps & "," & cols("index_name")
            n = n + 1
        End If
        tmpCol = cols("index_name")
        cols.movenext
    Wend
    cols.Filter = 0
    cols.Close
    Set cols = Nothing
     getInxArr = Mid(tmps, 2)
End Function

function isUnique(TableName,IndexName)
	dim cols
	set cols=CONN.openSchema(12)
	cols.filter="Table_Name='" & TableName & "' and Index_Name='" & IndexName & "' and UNIQUE=True"
	if not cols.eof then
		isUnique=true
	else
		isUnique=false
	end if
	cols.filter=0
	cols.close
	set cols=nothing
end function


function isPrimaryKey(TableName,IndexName) 
	dim cols
	set cols=CONN.openSchema(12)
	cols.filter="Table_Name='" & TableName & "' and Index_Name='" & IndexName & "' and PRIMARY_KEY=True"
	if not cols.eof then
		isPrimaryKey=true
	else
		isPrimaryKey=false
	end if
	cols.filter=0
	cols.close
	set cols=nothing
end function

function getPrimaryKey(tableName,columnName)
	dim cols
	Set cols=CONN.openSchema(12)
	cols.filter="Table_Name='" & tableName & "' and Column_Name='" & columnName & "' and PRIMARY_KEY=True"
	if not cols.eof then
		getPrimaryKey=cols("INDEX_NAME")
		'isPrimaryKey=true
	else
		getPrimaryKey=""
		'isPrimaryKey=false
	end if
	cols.filter=0
	cols.close
	set cols=nothing
end function

function existPrimaryKey(tableName)
	dim cols
	Set cols=CONN.openSchema(12)
	cols.filter="Table_Name='" & tableName & "' and PRIMARY_KEY=True"
	if not cols.eof then
		existPrimaryKey=true
	else
		existPrimaryKey=false
	end if
	cols.filter=0
	cols.close
	set cols=nothing
end function

Function GetIncrement(tableName,columnName)
	dim cat
	set cat=Server.CreateObject("ADOX.Catalog") 
	cat.ActiveCONNection =CONNstr
	GetIncrement=cat.Tables("" & TableName & "").Columns("" & columnName & "").Properties("Increment") 
	set cat=nothing
end function

Function GetSeed(tableName,columnName)
	dim cat
	set cat=Server.CreateObject("ADOX.Catalog") 
	cat.ActiveCONNection =CONNstr
	GetSeed=cat.Tables("" & TableName & "").Columns("" & columnName & "").Properties("Seed") 
	set cat=nothing
end function

'通用,内部属性取得自动编号，对SQLserver Access都可以
Function GetAutoincrementCoulmnT(TableName)
	dim i
	rs.open "select * from [" & TableName & "] where 1=0",CONN,0,1
	for i=0 to rs.fields.count-1
		//if rs(i).Properties("isAutoIncrement")=True then
		if rs(i).Properties("isAutoIncrement")=True then
			GetAutoincrementCoulmnT=rs(i).name
			rs.close
			exit function
		end if	
	next
	rs.close
End function

function datatypeStr(DATA_TYPE,CHARACTER_MAXIMUM_LENGTH)
	select case DATA_TYPE 
	case 130 
	  if CHARACTER_MAXIMUM_LENGTH=0 then
		if UniCodeMode="1" then
			datatypeStr="ntext"	'LongText
		else
			datatypeStr="text"	'LongText
		end if
	  else   
		if UniCodeMode="1" then
			datatypeStr="nvarchar(" & CHARACTER_MAXIMUM_LENGTH & ")" '双字节必须使用 bvarchar 否则导入后截断
		else
			datatypeStr="varchar(" & CHARACTER_MAXIMUM_LENGTH & ")" '双字节必须使用 bvarchar 否则导入后截断
		end if
	  end if
	case 17  datatypeStr="tinyint"
	case 2   datatypeStr="Smallint"
	case 3   datatypeStr="integer" 
	case 4   datatypeStr="real" 'or  /同意词 float4
	case 5 	 datatypeStr="float" 'or  /同意词 float8 
	case 6	 datatypeStr="money" 'or  /同意词  CURRENCY
	case 7	 datatypeStr="datetime"
	case 11  datatypeStr="bit"
	case 72  datatypeStr="UNIQUEIDENTIFIER"  'or  /同意词  GUID
	case 131 datatypeStr="DECIMAL"  'or  /同意词  DEC
	case 128 datatypeStr="BINARY"  'or  /同意词  DEC
	end select 'AUTOINCREMENT
end function

function defaultStr(DATA_TYPE,COLUMN_DEFAULT,exec)
	if isNull(COLUMN_DEFAULT) then
		defaultStr=""
		exit function
	end if
	dim splitchar
	if exec=1 then 
		splitchar=""""""
	elseif exec=0 then
		splitchar=""""
	end if
	COLUMN_DEFAULT = defaultStrfilter(COLUMN_DEFAULT)
	select case DATA_TYPE 
	case 130 
			COLUMN_DEFAULT=replace(COLUMN_DEFAULT,"""",splitchar)
			defaultStr=" Default ('" & COLUMN_DEFAULT & "')"
    Case 11
        If LCase(COLUMN_DEFAULT) = "true" Or LCase(COLUMN_DEFAULT) = "on" Or LCase(COLUMN_DEFAULT) = "yes" Then
            COLUMN_DEFAULT = 1
        Else: COLUMN_DEFAULT = 0
        End If
        defaultStr = " Default (" & COLUMN_DEFAULT & ")"
	case 128 
		 defaultStr=" Default (0x" & COLUMN_DEFAULT & ")"  'or  /同意词  DEC
	case 7
        If LCase(COLUMN_DEFAULT) = "now()" Or _
           LCase(COLUMN_DEFAULT) = "date()" Or _
           LCase(COLUMN_DEFAULT) = "time()" Then COLUMN_DEFAULT = "getdate()"		
		if left(COLUMN_DEFAULT,1)="#" then COLUMN_DEFAULT=replace(COLUMN_DEFAULT,"#","'")
		 defaultStr=" Default (" & COLUMN_DEFAULT & ")"  'or  /同意词  DEC
	case else
		 defaultStr=" Default (" & COLUMN_DEFAULT & ")"
	end select 
end function

Function defaultStrfilter(S)
    Do While Left(S, 1) = """"
        S = Mid(S, 2)
    Loop
    Do While Right(S, 1) = """"
        S = Left(S, Len(S) - 1)
    Loop
    Do While Left(S, 1) = "'"
        S = Mid(S, 2)
    Loop
    Do While Right(S, 1) = "'"
        S = Left(S, Len(S) - 1)
    Loop
    defaultStrfilter = S
End Function

Function nullStr(IS_NULLABLE, tablename, columnName)
    If IS_NULLABLE Then
        If getPrimaryKey(tablename, columnName) = "" Then
            nullStr = " null "
        Else
           nullStr = " not null "
        End If
    Else
        nullStr = " not null "
    End If
End Function

'断点调试 num=0 中断
Sub rw(str,num)
	dim istr:istr=str
	dim inum:inum=num
	response.write str & "<br>"
	if inum=0 then response.end
end sub

SUB CreateMDB()
	'改配置表名和列名
	dim cat,NewDB_Name
	NewDB_Name=request("DB_Name")
	if NewDB_Name<>"" then
		if instr(NewDB_Name,":\")=0 and instr(NewDB_Name,":/")=0 then
			NewDB_Name=Server.MapPath(NewDB_Name)
		end if 
		set cat=Server.CreateObject("ADOX.Catalog") 
		cat.Create "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & NewDB_Name
		set cat=nothing 
		CreateDB(NewDB_Name)
		response.write vbcrlf & "OK"
	else
		set cat=nothing 
		call main()
	end if
End SUB
'=============================编写access sql 脚本============//
Function questStr(Str)
		Str=request(Str)
		Str=replace(Str,"'","")
		Str=Replace(Str,Chr(0),"")
		Str=Replace(Str," ","")
		questStr=Str
End Function

Function Ados_Read(FileName,CharsetType)
		dim adosText
			Ados_Read=""
		if instr(FileName,":\")=0 and instr(FileName,":/")=0 then
			FileName=Server.mappath(FileName)
		end if
		set adosText=Server.CreateObject("ADODB.Stream")
		adosText.mode=3
		adosText.type=2 'textStream
		adosText.charset="" & CharsetType & ""
		adosText.open
		adosText.loadFromFile FileName
		Ados_Read=adosText.ReadText()
		adosText.close
	set adosText=nothing
End Function

SUB Ados_Write(TextString,FileName,CharsetType)
		dim adosText
		if instr(FileName,":\")=0 and instr(FileName,":/")=0 then
			FileName=Server.mappath(FileName)
		end if
		set adosText=Server.CreateObject("ADODB.Stream")
		adosText.mode=3
		adosText.type=2 'textStream
		adosText.charset="" & CharsetType & ""
		adosText.open
		adosText.setEos
		adosText.WriteText(TextString)
		adosText.SaveToFile FileName,2
		adosText.close
	set adosText=nothing
End SUB

Function Add_aspExec()
	dim S
	S = S & "call CreateSQLDB()" & vbCrlf
	S = S & vbCrlf

	S = S & "SUB Main()" & vbCrlf
	S = S & "	Response.write(""<html><head></head><body topmargin=0><br><center><FORM METHOD=POST><table border=1><tr><td><table cellspacing=0 cellpadding=2 align=center border=0 width=""""600"""" style=""""font-size:9pt"""" bgcolor=#D4D0C8>"")" & vbCrlf
	S = S & "	Response.write(""<tr bgcolor=#A4D0F8><td colspan=2 align=center style=""""font-size:9pt;color:#000000"""" height=30><b>Access To SQL server 导入</b>(CooSel2.0 CreateSQL脚本编写器创建 )</td></tr>"")" & vbCrlf
	S = S & "	Response.write(""<tr bgcolor=#667766><td colspan=2 height=1></td></tr>"")" & vbCrlf
	S = S & "	Response.write(""<tr><td align=right width=""""30%"""">Sa登陆密码:</td><td><input name=sapass type=password Value='" & sapass & "' style=""""width:70%;"""">(必须输入才能键库)</td></tr>"")" & vbCrlf
	S = S & "	Response.write(""<tr bgcolor=#667766><td colspan=2 height=1></td></tr>"")" & vbCrlf
	S = S & "	Response.write(""<tr><td align=right width=""""30%"""">要导入的Access数据库:</td><td><input name=DB_Name Value='" & DB_Name & "' style=""""width:70%;""""></td></tr>"")" & vbCrlf
	S = S & "	" & vbCrlf
	S = S & "	Response.write(""<tr><td align=right width=""""30%"""">新建SQL数据库名:</td><td><input name=NewDB_Name Value='" & databasename & "' style=""""width:70%;""""></td></tr>"")" & vbCrlf
	S = S & "	Response.write(""<tr><td align=right>新建SQL数据库登陆名:</td><td><input name=loginName Value='" & loginName & "' style=""""width:70%;""""></td></tr>"")" & vbCrlf
	S = S & "	Response.write(""<tr><td align=right>新建SQL数据库登陆密码:</td><td><input type=password name=loginPassword Value='" & loginPassword & "' style=""""width:70%;""""></td></tr>"")" & vbCrlf
	S = S & "	" & vbCrlf
	S = S & "	Response.write(""<tr><td align=right>是否导入MDB数据到SQL</td><td><input name=DTS type=radio Value='1' checked>是 <input name=DTS type=radio Value='0'>否  </td></tr>"")" & vbCrlf
	S = S & "	Response.write(""<tr><td align=right></td><td><br><INPUT TYPE=submit name=CreateDB Value="""" 确 定 """"><br><br>注:如果有外键则只建库结构再导入数据可能会出错,要导入的数据库必须和原来的编写SQL脚本的数据库结构一致</td></tr>"")" & vbCrlf
	S = S & "	Response.write(""</table></td></tr></table></FORM></center><body></html>"")" & vbCrlf
	S = S & "End SUB" & vbCrlf
	S = S & vbCrlf

	S = S & "SUB CreateSQLDB()" & vbCrlf
	S = S & "	dim NewDB_Name,loginName,loginpassword,sapass,DB_Name,DTS,Tstr" & vbCrlf
	S = S & "	NewDB_Name=questStr(""NewDB_Name"")" & vbCrlf
	S = S & "	loginName=questStr(""loginName"")" & vbCrlf
	S = S & "	loginpassword=questStr(""loginpassword"")" & vbCrlf
	S = S & "	sapass=questStr(""sapass"")" & vbCrlf
	S = S & "	DB_Name=questStr(""DB_Name"")" & vbCrlf
	S = S & "	DTS=questStr(""DTS"")" & vbCrlf
	S = S & "	if isNumeric(DTS) then " & vbCrlf
	S = S & "		DTS=clng(DTS)" & vbCrlf
	S = S & "	else DTS=0" & vbCrlf
	S = S & "	end if" & vbCrlf	
	S = S & "	if DTS=0 then " & vbCrlf
	S = S & "		Tstr=""创建完成"" " & vbCrlf
	S = S & "	else Tstr=""创建完成,数据已经导入""" & vbCrlf
	S = S & "	end if" & vbCrlf	

	S = S & "	if NewDB_Name<>"""" then" & vbCrlf
	S = S & "		Call CreateDB(DB_Name,NewDB_Name,loginName,loginpassword,sapass,DTS)" & vbCrlf
	S = S & "		response.write vbcrlf & Tstr & ""<br>连接字串:<br>CONNstr=""""Provider=SQLOLEDB.1;Persist Security InFso=true;Data Source='(local)';Initial Catalog='"" & NewDB_Name & ""';User ID='"" & loginName & ""';Password='"" & loginpassword & ""';CONNect Timeout=30""""<br>"" & vbcrlf" & vbCrlf
	S = S & "	else" & vbCrlf
	S = S & "		call main()" & vbCrlf
	S = S & "	end if" & vbCrlf
	S = S & "End SUB" & vbCrlf
	S = S & vbCrlf
	S = S & "Function questStr(Str)" & vbCrlf
	S = S & "		Str=request(Str)" & vbCrlf
	S = S & "		Str=replace(Str,""'"","""")" & vbCrlf
	S = S & "		Str=Replace(Str,Chr(0),"""")" & vbCrlf
	S = S & "		Str=Replace(Str,"" "","""")" & vbCrlf
	S = S & "		questStr=Str" & vbCrlf
	S = S & "End Function" & vbCrlf
	S = S & vbCrlf
	Add_aspExec=S
End Function



%>
<hr size=1>
<center>Create by <a href="http://www.paintblue.net/">V37 PaintBlue.Net 极点视觉</a> 2004-11-12</center>
<hr size=1>
<br>
<br>
</BODY>
</HTML>