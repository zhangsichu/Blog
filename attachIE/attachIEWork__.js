var menuskin = "i_defaultSkin";
var menuitemskin = "i_menuItems";
var searchpanelskin = "i_searchPanelSkin";
var searchframeskin = "i_searchFrameSkin";
var closesearchpanelskin = "i_closeSearchPanelSkin";
var display_url = 0; 
var seltext;

function showmenuie5() {
var rightedge = document.body.clientWidth-event.clientX;
var bottomedge = document.body.clientHeight-event.clientY;

if (rightedge <ie5menu.offsetWidth)
ie5menu.style.left = document.body.scrollLeft + event.clientX - ie5menu.offsetWidth;
else
ie5menu.style.left = document.body.scrollLeft + event.clientX;

if (bottomedge <ie5menu.offsetHeight)
ie5menu.style.top = document.body.scrollTop + event.clientY - ie5menu.offsetHeight;
else
ie5menu.style.top = document.body.scrollTop + event.clientY;

seltext=document.selection.createRange().text;
ie5menu.style.visibility = "visible";
return false;
}

function hidemenuie5() {
ie5menu.style.visibility = "hidden";
//document.getElementById("searchPanel").style.visibility = "hidden";
}

function highlightie5() {
if (event.srcElement.className == menuitemskin) {
event.srcElement.style.backgroundColor = "highlight";
event.srcElement.style.color = "white";
if (display_url)
window.status = event.srcElement.url;
   }
}

function lowlightie5() {
if (event.srcElement.className == menuitemskin) {
event.srcElement.style.backgroundColor = "";
event.srcElement.style.color = "black";
window.status = "";
   }
}

function jumptoie5() {
if (event.srcElement.className == menuitemskin) {
if (event.srcElement.getAttribute("target") != null)
window.open(event.srcElement.url, event.srcElement.getAttribute("target"));
else
window.location = event.srcElement.url;
   }
}

function searchPage(){
    if(seltext != "")
    {
        var searchPanel = document.getElementById("searchPanel");
        var rightedge = document.body.clientWidth-event.clientX;
        var bottomedge = document.body.clientHeight-event.clientY;

        if (rightedge <searchPanel.offsetWidth)
        searchPanel.style.left = document.body.scrollLeft + event.clientX - searchPanel.offsetWidth;
        else
        searchPanel.style.left = document.body.scrollLeft + event.clientX;

        if (bottomedge <searchPanel.offsetHeight)
        searchPanel.style.top = document.body.scrollTop + event.clientY - searchPanel.offsetHeight;
        else
        searchPanel.style.top = document.body.scrollTop + event.clientY;

        searchPanel.style.visibility = "visible";
        searchFrame = document.getElementById("searchFrame");
        searchFrame.src = "http://www.zhangsichu.com/attachie/searchpage.asp?query=" + seltext;
    }
}

function hideSearchPage(){
    document.getElementById("searchPanel").style.visibility = "hidden";
}

if (document.all && window.print) {
    var head = document.getElementsByTagName('head')[0];
    var skinCss = document.createElement('link'); 
    skinCss.type = 'text/css';
    skinCss.rel = 'stylesheet';
    skinCss.href = "http://www.zhangsichu.com/attachIE/attachIECss.css";
    head.appendChild(skinCss);
    
    var ie5menu = document.createElement("DIV");
    ie5menu.className = menuskin;
    document.oncontextmenu = showmenuie5;
    document.body.onclick = hidemenuie5;
    ie5menu.onmousemove = highlightie5;
    ie5menu.onmouseout = lowlightie5;
    ie5menu.style.visibility = "hidden";
    
    var menuItem = document.createElement("DIV");
    menuItem.className = menuitemskin;
    menuItem.innerText = "后退";
    menuItem.url = "javascript:history.back();";
    menuItem.onclick = jumptoie5;
    ie5menu.appendChild(menuItem);
    
    var menuItem = document.createElement("DIV");
    menuItem.className = menuitemskin;
    menuItem.innerText = "前进";
    menuItem.url = "javascript:history.forward();";
    menuItem.onclick = jumptoie5;
    ie5menu.appendChild(menuItem);
    
    ie5menu.appendChild(document.createElement("HR"));
    
    var menuItem = document.createElement("DIV");
    menuItem.className = menuitemskin;
    menuItem.innerText = "搜索";
    menuItem.onclick = searchPage;
    ie5menu.appendChild(menuItem);

    var menuItem = document.createElement("DIV");
    menuItem.className = menuitemskin;
    menuItem.innerText = "AboutME";
    menuItem.url = "http://www.zhangsichu.com";
    menuItem.target = "_blank";
    menuItem.onclick = jumptoie5;
    ie5menu.appendChild(menuItem);
    
    document.body.appendChild(ie5menu);
    
    var searchPanel = document.createElement("DIV");
    searchPanel.className = searchpanelskin;
    searchPanel.id = "searchPanel";
    
    var closeSearchPanel = document.createElement("DIV");
    closeSearchPanel.innerText = "X";
    closeSearchPanel.className = closesearchpanelskin;
    closeSearchPanel.onclick = hideSearchPage;
    searchPanel.appendChild(closeSearchPanel);
    
    var searchFrame = document.createElement("IFRAME");
    searchFrame.id = "searchFrame";
    searchFrame.className = searchframeskin;
    searchPanel.appendChild(searchFrame);
    
    document.body.appendChild(searchPanel);
}