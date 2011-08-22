//Dynamic write object tag - SiC/CYAN 2004
function ubbShowObj(strType,strID,strURL,intWidth,intHeight)
{
	var varHeader="b";
	var tmpstr="";
	var bSwitch = false;
	//Reverse the State
	bSwitch = document.getElementById(varHeader+strID).value;
	bSwitch	=~bSwitch;
	document.getElementById(varHeader+strID).value = bSwitch;
	if(bSwitch){
		//Code for already shown
		document.getElementById(strID).innerHTML = "Source URL: "+strURL;
	}else{
		//Code for not shown
		switch(strType){
			case "swf":
				tmpstr="<OBJECT codeBase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0 classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width="+intWidth+" height="+intHeight+"><param name=movie value='"+strURL+"'><param name=quality value=high><param name=AllowScriptAccess value=never><embed src="+strURL+" quality=high pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width="+intWidth+" height="+intHeight+"></embed></OBJECT>";
				break;
			case "wmp":
				tmpstr="<OBJECT classid='CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95' codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,0,02,902' type='application/x-oleobject' standby='Loading...' width="+intWidth+" height="+intHeight+"><PARAM NAME='FileName' VALUE='"+strURL+"'><param name='ShowStatusBar' value='-1'><PARAM NAME='AutoStart' VALUE='true'><EMBED type='application/x-mplayer2' pluginspage='http://www.microsoft.com/Windows/MediaPlayer/' SRC='"+strURL+"' AutoStart=true width="+intWidth+" height="+intHeight+"></EMBED></OBJECT>";
				break;
			case "rm":
				tmpstr="<OBJECT CLASSID='clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA' WIDTH="+intWidth+" HEIGHT="+intHeight+"><PARAM NAME='SRC' VALUE='"+strURL+"'><PARAM NAME='CONTROLS' VALUE='ImageWindow'><PARAM NAME='CONSOLE' VALUE='one'><PARAM NAME=AUTOSTART VALUE=true><EMBED SRC='"+strURL+"' NOJAVA=true CONTROLS=ImageWindow CONSOLE=one WIDTH="+intWidth+" HEIGHT="+intHeight+"></OBJECT><br><OBJECT CLASSID='clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA' WIDTH="+intWidth+" HEIGHT=32><PARAM NAME='CONTROLS' VALUE='StatusBar'><PARAM NAME=AUTOSTART VALUE=true><PARAM NAME='CONSOLE' VALUE='one'><EMBED SRC='"+strURL+"' NOJAVA=true CONTROLS=StatusBar CONSOLE=one WIDTH="+intWidth+" HEIGHT=24></OBJECT><br><OBJECT CLASSID='clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA' WIDTH="+intWidth+" HEIGHT=32><PARAM NAME='CONTROLS' VALUE='ControlPanel'><PARAM NAME=AUTOSTART VALUE=true><PARAM NAME='CONSOLE' VALUE='one'><EMBED SRC='"+strURL+"' NOJAVA=true CONTROLS=ControlPanel CONSOLE=one WIDTH="+intWidth+" HEIGHT=24 AUTOSTART=true LOOP=false></OBJECT>";
				break;
			case "qt":
				tmpstr="<embed src='"+strURL+"' autoplay=true Loop=false controller=true playeveryframe=false cache=false scale=TOFIT bgcolor=#000000 kioskmode=false targetcache=false pluginspage=http://www.apple.com/quicktime/>"
		}
		document.getElementById(strID).innerHTML = tmpstr;
	}
}