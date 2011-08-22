<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<title>
	Cookie Test
</title>
<script language="javascript" type="text/javascript">
    function ShowCookie()
    {
        alert(window.top.document.cookie);
    }
	function DeleteCookie()
	{	
		var name = "DisplayUserName";
		var userName = "";
		var exp=new Date(); 
		exp.setTime(exp.getTime()-100); 
		document.cookie=name+"="+encodeURIComponent(userName)+"; expires="+exp.toGMTString(); 
	}
	function WriteCookie()
	{
		var name = "DisplayUserName";
		var userName = document.getElementById('txtCookieValue').value;
		var now=new Date(); 
		now.setTime(now.getTime()+1000*60*60*24*365);
		document.cookie=name+"="+encodeURIComponent(userName)+"; expires="+now.toGMTString();
		//decodeURIComponent;
		//encodeURIComponent;
	}
    </script>
</head>
<body>
    <input id="txtCookieValue" type="text" />
	<input type="button" name="Button" value="WriteCookie" onclick="WriteCookie();" />
		<input type="button" name="Button" value="DeleteCookie" onclick="DeleteCookie();" />
			<input type="button" name="Button" value="ShowCookie" onclick="ShowCookie();" />
</body>
</html>