<!--#include file="config.asp" -->
<html>
<head>
    <title>
        <%=Web_Title%>
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link href="images/clicss.css" type="text/css" rel="stylesheet">
    <script language="javascript" type="text/javascript" src="cli.js"></script>
    <script language="javascript" type="text/javascript" src="function.js"></script>
</head>
<body onkeydown="dokey();" onload="setup(); dokey();" style="overflow: hidden">
    <div id="scr" style="overflow: auto; height: 100%;">
        <div id="display">
            <h1>
                ZhangSichu-Blog</h1>
            <noscript>
                <p style="height: 100%">
                    Sorry, the CLI requires JavaScript to work. Please turn on JavaScript, or try the
                    <a href="default.asp">GUI Interface</a>.
                </p>
            </noscript>
            <p>
                Welcome. If you find command-line interfaces scary, there is a GUI for the blog
                available <a href="default.asp">here</a> . Otherwise, type 'help' for assistance.
            </p>
        </div>
        <div>
            <form onsubmit="return false;">
                <pre><span id="prompt">guest@ZhangSichu-Blog:/$ </span><span id="command"></span><input
                    type="text" onchange="docmd(this.value)" onkeyup="showtype(this.value);" value=""
                    autocomplete="off" name="dude" /><img id="csr" alt="_" src="images/clicursor.gif" /></pre>
            </form>
        </div>
    </div>
</body>
</html>
