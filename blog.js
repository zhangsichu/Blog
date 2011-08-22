var text_input = "Text";
var adv_mode = "UBB Code - Insert Immediately\n\nClick on the button will insert the UBB Code immediately";
var normal_mode = "UBB Code - Prompt before Insert\n\nClick on the button will display the propmt window which will guide you to insert UBB Code";
var email_normal = "Please input the display text of the Email Link.\nLeave blank will use the Email Link itself.";
var email_normal_input = "Please input the Email Link.";
var fontsize_normal = "Please input the text which will use this size.";
var font_normal = "Please input the text which will use this font.";
var bold_normal = "Please input the text which will use bold style.";
var italicize_normal = "Please input the text which will use italic style.";
var underline_normal = "Please input the text which will use underline style.";
var strike_normal = "Please input the text which will use strike-line style.";
var sup_normal = "Please input the text which will use superscript style.";
var sub_normal = "Please input the text which will use subscript style.";
var quote_normal = "Please input the quoted text.";
var color_normal = "Please input the text which will use this color.";
var center_normal = "Please input the text which you want to align center.";
var link_normal = "Please input the display text of the URL.\nLeave blank will use the URL itself.";
var link_normal_input = "Please input the URL.";
var image_normal = "Please input the URL of the image file.";
var media_type = "Please input the media type. swf=Flash, wmp=Windows Media Player, rm=RealPlayer, qt=QuickTime.";
var media_size = "Please input the media screen size(Width,Height like 400,300)\nLeave blank will using default size.";
var media_url = "Please input the URL of the media source.";
var code_normal = "Please input the code segment.";
var list_normal = "Please input the list items. Leave blank to end input.";
var seperator_normal = "This Seperator is used for manually dividing Excerpt & Further Text Content.\nWithout inserting the Seperator, the Text Content will be seperated automatically.\nOnly One seperator is allowed in Text Content.";

var defmode = "normalmode";

if (defmode == "advmode") {
		normalmode = false;
		advmode = true;
} else {
		normalmode = true;
		advmode = false;
}

function setfocus() {
		document.Blogform.contentContent.focus();
}

function chmode(swtch){
		if (swtch == 0) {
			normalmode = false;
			advmode = true;
			alert(adv_mode);
		} else if (swtch == 2) {
			advmode = false;
			normalmode = true;
			alert(normal_mode);
		}
}

function AddText(NewCode) {
	if(document.all){
		insertAtCaret(document.Blogform.contentContent, NewCode);
		setfocus();
	} else{
		document.Blogform.contentContent.value += NewCode;
		setfocus();
	}
}

function storeCaret(cursorPosition) {
	if (cursorPosition.createTextRange) cursorPosition.caretPos = document.selection.createRange().duplicate();
}

function insertAtCaret (textEl, text){
	if (textEl.createTextRange && textEl.caretPos){
		var caretPos = textEl.caretPos;
		caretPos.text += caretPos.text.charAt(caretPos.text.length - 2) == ' ' ? text + ' ' : text;
	} else if(textEl) {
		textEl.value += text;
	} else {
		textEl.value = text;
	}
}

function chsize(size) {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[size=" + size + "]" + range.text + "[/size]";
		} else if (advmode) {
			AddTxt="[size="+size+"] [/size]";
			AddText(AddTxt);
		} else {                       
			txt=prompt(fontsize_normal,text_input); 
			if (txt!=null) {             
			AddTxt="[size="+size+"]"+txt;
			AddText(AddTxt);
			AddText("[/size]");
			}        
		}
}

function chfont(font) {
		if (document.selection && document.selection.type == "Text") {
			var range = document.selection.createRange();
			range.text = "[font=" + font + "]" + range.text + "[/font]";
		} else if (advmode) {
			AddTxt="[font="+font+"] [/font]";
			AddText(AddTxt);
		} else {                  
			txt=prompt(font_normal,text_input);
			if (txt!=null) {             
				AddTxt="[font="+font+"]"+txt;
				AddText(AddTxt);
				AddText("[/font]");
			}        
		}  
}


function bold() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[b]" + range.text + "[/b]";
		} else if (advmode) {
			AddTxt="[b] [/b]";
			AddText(AddTxt);
		} else {  
			txt=prompt(bold_normal,text_input);     
			if (txt!=null) {           
			AddTxt="[b]"+txt;
			AddText(AddTxt);
			AddText("[/b]");
			}       
		}
}

function italicize() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[i]" + range.text + "[/i]";
		} else if (advmode) {
			AddTxt="[i] [/i]";
			AddText(AddTxt);
		} else {   
			txt=prompt(italicize_normal,text_input);     
			if (txt!=null) {           
			AddTxt="[i]"+txt;
			AddText(AddTxt);
			AddText("[/i]");
			}               
		}
}

function underline() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[u]" + range.text + "[/u]";
		} else if (advmode) {
			AddTxt="[u] [/u]";
			AddText(AddTxt);
		} else {  
			txt=prompt(underline_normal,text_input);
			if (txt!=null) {           
			AddTxt="[u]"+txt;
			AddText(AddTxt);
			AddText("[/u]");
			}               
		}
}

function strike() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[s]" + range.text + "[/s]";
		} else if (advmode) {
			AddTxt="[s] [/s]";
			AddText(AddTxt);
		} else {  
			txt=prompt(strike_normal,text_input);
			if (txt!=null) {           
			AddTxt="[s]"+txt;
			AddText(AddTxt);
			AddText("[/s]");
			}               
		}
}

function superscript() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[sup]" + range.text + "[/sup]";
		} else if (advmode) {
			AddTxt="[sup] [/sup]";
			AddText(AddTxt);
		} else {  
			txt=prompt(sup_normal,text_input);
			if (txt!=null) {           
			AddTxt="[sup]"+txt;
			AddText(AddTxt);
			AddText("[/sup]");
			}               
		}
}

function subscript() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[sub]" + range.text + "[/sub]";
		} else if (advmode) {
			AddTxt="[sub] [/sub]";
			AddText(AddTxt);
		} else {  
			txt=prompt(sub_normal,text_input);
			if (txt!=null) {           
			AddTxt="[sub]"+txt;
			AddText(AddTxt);
			AddText("[/sub]");
			}               
		}
}

function chcolor(color) {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[color=" + color + "]" + range.text + "[/color]";
		} else if (advmode) {
			AddTxt="[color="+color+"] [/color]";
			AddText(AddTxt);
		} else {  
		txt=prompt(color_normal,text_input);
			if(txt!=null) {
			AddTxt="[color="+color+"]"+txt;
			AddText(AddTxt);
			AddText("[/color]");
			}
		}
}

function center() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[align=center]" + range.text + "[/align]";
		} else if (advmode) {
			AddTxt="[align=center] [/align]";
			AddText(AddTxt);
		} else {  
			txt=prompt(center_normal,text_input);     
			if (txt!=null) {          
			AddTxt="\r[align=center]"+txt;
			AddText(AddTxt);
			AddText("[/align]");
			}              
		}
}

function hyperlink() {
		if (advmode) {
			AddTxt="[url] [/url]";
			AddText(AddTxt);
		} else { 
			txt2=prompt(link_normal,""); 
			if (txt2!=null) {
			txt=prompt(link_normal_input,"http://");      
			if (txt!=null) {
				if (txt2=="") {
						AddTxt="[url]"+txt;
						AddText(AddTxt);
						AddText("[/url]");
				} else {
						AddTxt="[url="+txt+"]"+txt2;
						AddText(AddTxt);
						AddText("[/url]");
				}         
			} 
			}
		}
}

function email() {
	if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[email]" + range.text + "[/email]";
	} else if (advmode) {
		AddTxt="[email] [/email]";
			AddText(AddTxt);
		} else { 
			txt2=prompt(email_normal,""); 
			if (txt2!=null) {
			txt=prompt(email_normal_input,"name@domain.com");      
			if (txt!=null) {
				if (txt2=="") {
						AddTxt="[email]"+txt+"[/email]";
			
				} else {
						AddTxt="[email="+txt+"]"+txt2+"[/email]";
				} 
				AddText(AddTxt);                
			}
			}
		}
}

function image() {
		if (advmode) {
			AddTxt="[img] [/img]";
			AddText(AddTxt);
		} else {  
			txt=prompt(image_normal,"http://");    
			if(txt!=null) {            
			AddTxt="\r[img]"+txt;
			AddText(AddTxt);
			AddText("[/img]");
			}       
		}
}

function media() {
	txt=prompt(media_type,"swf");
	while ("swf,wmp,rm,qt".indexOf(txt)<0||txt=="") {
		txt=prompt(media_type,"swf");               
	}
	txt1=prompt(media_size,"");
	txt2=prompt(media_url,"http://");
	if(txt!=null&&txt2!=null) {       
		if(txt1==""||txt1==null){
			AddTxt="\r["+txt+"]"+txt2;
		}else{
			AddTxt="\r["+txt+"="+txt1+"]"+txt2;
		}
			AddText(AddTxt);
			AddText("[/"+txt+"]");
	}       
}

function list() {
		if (advmode) {
			AddTxt="\r[list]\r[*]\r[*]\r[*]\r[/list]";
			AddText(AddTxt);
		} else {  
		AddTxt="\r[list]\r\n";
		txt="1";
		while ((txt!="") && (txt!=null)) {
			txt=prompt(list_normal,""); 
			if (txt!="") {             
					AddTxt+="[*]"+txt+"\r"; 
			}                   
		} 
			AddTxt+="[/list]\r\n";
			AddText(AddTxt); 
		}
}

function code() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[code]" + range.text + "[/code]";
		} else if (advmode) {
			AddTxt="\r[code]\r[/code]";
			AddText(AddTxt);
		} else {   
			txt=prompt(code_normal,"");     
			if (txt!=null) {          
			AddTxt="\r[code]"+txt;
			AddText(AddTxt);
			AddText("[/code]");
			}              
		}
}

function quote() {
		if (document.selection && document.selection.type == "Text") {
		var range = document.selection.createRange();
		range.text = "[quote]" + range.text + "[/quote]";
		} else if (advmode) {
			AddTxt="\r[quote]\r[/quote]";
			AddText(AddTxt);
		} else {   
			txt=prompt(quote_normal,text_input);     
			if(txt!=null) {          
			AddTxt="\r[quote]\r"+txt;
			AddText(AddTxt);
			AddText("\r[/quote]");
			}               
		}
}

function seperator() {
	var txtarea = document.Blogform.contentContent;
	alert(seperator_normal);
	if (txtarea.createTextRange && txtarea.caretPos) {
	var caretPos = txtarea.caretPos;
	caretPos.text = caretPos.text.charAt(caretPos.text.length - 1) == ' ' ? '[#seperator#] ' : '[#seperator#]';
	txtarea.focus();
	} else {
	txtarea.value  += '[#seperator#]';
	txtarea.focus();
	}
}

//Ctrl+Enter to newBlog
function CtrlEnter() {
    var keyEvent = window.event || CtrlEnter.caller.arguments[0];
	if(keyEvent.ctrlKey && keyEvent.keyCode==13) document.Blogform.Submit.click();
}

//Check Blogform
function checkinput(){
	var errMessage, bError;
	errMessage="";
	bError=false;
	if(document.Blogform.blogClass.value=="0"){
		errMessage+="\n 请选择文章的类别";
		bError=true;
	}
	if(document.Blogform.contentTitle.value==""){
		errMessage+="\n 请输入文章的标题";
		bError=true;
	}
	if(document.Blogform.contentContent.value==""){
		errMessage+="\n 请填写文章的内容";
		bError=true;
	}
	if(bError){
		alert(errMessage);
		return false;
	}
	return true;
}