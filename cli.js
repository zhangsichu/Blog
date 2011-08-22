var path="/";
var prompt="$";
var user="guest";
var machine="ZhangSichu-Blog";
var display=null;
var cl=null;
var frm=null;
var cmd=null;
var scrn=null;
var pr=null;
var commandLine = "";
var specialCommandHandler=false;
var xmlhttp = false;

function setup(){
	display=document.getElementById('display');
	pr=document.getElementById('prompt');
	cmd=document.getElementById('command');
	scrn=document.getElementById('scr');
	frm=document.forms[0];
	ask=user+'@'+machine+":"+path+prompt+'&nbsp;';
	pr.innerHTML=ask;
}

function IsIE()
{
    var navName = navigator.appName;
    if(navName)
    {
        return navName.indexOf("Microsoft")>-1
    }
    return false;
}

function dokey(){
    if(frm != null && frm.dude != null){
	    frm.dude.focus();
	}
	if(IsIE()){
		if(event.keyCode == 13){
		commandLine = frm.dude.value;
		docmd(commandLine);
	    }
	}
	return false;
}

function docmd(input){
	if(specialCommandHandler){
		specialCommandHandler(input);
		return false;
	}
	commandLine = frm.dude.value;
	frm.dude.value="";
	cmd.innerHTML="";
	
	if(input.toLowerCase()=="restart" ||
	   input.toLowerCase()=="reboot"){
	    window.location.reload(true);
	    return false;
	}

	if(input.toLowerCase()=="exit"){
	    window.opener = null;
	    window.close();
	    return false;
	}
	
	if(input.toLowerCase()=='cls' ||
		input.toLowerCase()=='clear' 
		){
		display.innerHTML='';
		return false;
	}
	
	if(input.toLowerCase()=='halt' ||
		input.toLowerCase()=='shutdown' 
		){
		document.location.href="shutdown.asp";
		return false;
	}
		
	if(input.toLowerCase()=='back'){
		history.go(-1);
		return false;
	}
	
	if(input.toLowerCase()=='gui' || input.toLowerCase()=='startx'){
		document.location.href="default.asp";
		return false;
	}
	
	if(input.substring(0,input.indexOf(' ')).toLowerCase()=='google'){
		qt=input.substr(input.indexOf(' ')+1);
		window.open("http://www.google.com/search?q="+qt); 
		//document.location.href="http://www.google.com/search?q="+qt;
		return false;
	}

    display.innerHTML+="<pre>"+user+'@'+machine+":"+path+prompt+'&nbsp;'+commandLine+'</pre>';
	scroller();
	
    //For Post
    //read.
    if(input.toLowerCase()=='read' ||
       input.toLowerCase()=='show' ||
       input.substring(0,input.indexOf(' ')).toLowerCase()=='read' || 
       input.substring(0,input.indexOf(' ')).toLowerCase()=='show'){
       var spacePlace = input.toLowerCase().indexOf(' ');
	   if(spacePlace==-1){
	        input = 'read';
	   }
	   else{
	    input = 'read&Content_ID=' + input.substring(spacePlace+1);
	   }
	}
	
	//search
	if(input.toLowerCase()=='search' ||
	   input.toLowerCase()=='find' ||
	   input.substring(0,input.indexOf(' ')).toLowerCase()=='search' ||
	   input.substring(0,input.indexOf(' ')).toLowerCase()=='find'){
       var spacePlace = input.toLowerCase().indexOf(' ');
	   if(spacePlace==-1){
	        input = 'search';
	   }
	   else{
	    input = 'search&Keyword=' + input.substring(spacePlace+1);
	   }
	}
	
	//current
	if(input.toLowerCase()=='current' ||
	   input.toLowerCase()=='cursor' ||
	   input.substring(0,input.indexOf(' ')).toLowerCase()=='current' ||
	   input.substring(0,input.indexOf(' ')).toLowerCase()=='cursor'){
       var spacePlace = input.toLowerCase().indexOf(' ');
	   if(spacePlace==-1){
	        input = 'current';
	   }
	   else{
	    input = 'current&Content_ID=' + input.substring(spacePlace+1);
	   }
	}
	
	//category
	if( input.toLowerCase()=='category' ||
	    input.substring(0,input.indexOf(' ')).toLowerCase()=='category'){
       var spacePlace = input.toLowerCase().indexOf(' ');
	   if(spacePlace==-1){
            display.innerHTML+="<p>Please input a category ID.</p>";
	        return false;
	   }
	   else{
	    input = 'category&Class_ID=' + input.substring(spacePlace+1);
	   }
	}
	
	pr.style.visibility='hidden';
	execute(input);
	return false;
}

function showtype(what){
		what=what.replace(/</g,'&lt;');
		what=what.replace(/&$/g,'&amp;');
		if(frm != null){
		    commandLine = what;
		    frm.dude.value=commandLine;
		}
		if(cmd != null){
		    cmd.innerHTML=what;
	    }
}

function init(){
         try {
          xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
         } catch (e) {
          try {
           xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          } catch (E) {
           xmlhttp = false;
          }
         }
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
          xmlhttp = new XMLHttpRequest();
        }
}

function execute(what){
        if(!xmlhttp)init();
        if (!xmlhttp){
                alert('Failure please try again.');
                return false;
        }
	    what=encodeURI(what);
	    what=what.replace(/&amp;/g,'%26');
	    what=what.replace(/&lt;/g,'<');
        url="cliresponse.asp?Command="+what;
        xmlhttp.open("GET", url, true);
        xmlhttp.onreadystatechange=function(){
                xstate=xmlhttp.readyState;
                if (xstate==4){
                        if(xmlhttp.status == 200){
                            display.innerHTML+=xmlhttp.responseText;
                        }
                        else{
                            display.innerHTML+="<p>Command failure.</p>";
                        }
			            scroller();
			            pr.style.visibility='visible';
                        return true;
                }
        }
        xmlhttp.send("");
        return false;
}

function scroller(){
	step=16;
	d=scrn.scrollTop+scrn.offsetHeight;
	if(scrn.scrollHeight  > d){
		if((scrn.scrollHeight - d) > step){
			scrn.scrollTop += step;
			setTimeout('scroller();', 50);
		}else{
			scrn.scrollTop = scrn.scrollHeight - scrn.offsetHeight;
		}
	}
}

function showpost(which){
	commandLine = 'read '+which;
	frm.dude.value=commandLine;
	docmd(commandLine);
}
function showcategory(which){
	commandLine = 'category '+which;
	frm.dude.value=commandLine;
	docmd(commandLine);
}