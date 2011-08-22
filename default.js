//default.js
function GetMainContent()
{
    return window.document.getElementById("mainContent")||window.parent.document.getElementById("mainContent");
}
function AppearLoadingContent()
{
    var loadingContent = window.document.getElementById("loadingContent")||window.parent.document.getElementById("loadingContent");
    Effect.Appear(loadingContent);
}
function FadeLoadingContent()
{
    var loadingContent = window.document.getElementById("loadingContent")||window.parent.document.getElementById("loadingContent");
    Effect.Fade(loadingContent);
}
function GetIncludeParent(elementId)
{
    return window.document.getElementById(elementId)||window.parent.document.getElementById(elementId);
}
function SetGlobalVariable()
{
    window.BlogHistory = new History();
    window.BlogContents = new Array();
    window.SingleItemProcessStatus = null;
    window.CurrentUserName = null;
}
function GetBlogHistory()
{
    return window.BlogHistory || window.parent.BlogHistory;
}
function GetBlogContents()
{
    return window.BlogContents || window.parent.BlogContents;
}
function GetSingleItemProcessStatus()
{
    return window.SingleItemProcessStatus || window.parent.SingleItemProcessStatus;
}
function ProcessError(error)
{
    FadeLoadingContent();
    alert(error||'请稍候再试.');
}
function GetDefaultResponse(url)
{
  try 
  {
    blogxml.getXml(url,DisplayMainHandler,1);
  }
  catch(error)
  {
    ProcessError(error);
  }
}
function DisplayMainHandler(status,value)
{
    var mainContent = GetMainContent();
    mainContent.innerHTML = value.xtext;
    ResetBlogContentsFoldStatus();
    FadeLoadingContent();
}
function GetClassDisplay(url)
{
    GetClassDisplayProcess(url);
    GetBlogHistory().add(GetClassDisplayProcess,url);
    SetHistoryControlStatus();
}
function GetClassDisplayProcess(url)
{
    AppearLoadingContent();
	GetDefaultResponse(url);
}

//For blog view
function FontZoom(size)
{
    document.getElementById('fontzoom').style.fontSize=size+'px'
}
function CommentCheckinput()
{
	if(document.getElementById("commentTitle").value==0)
	{
	    alert("请填写标题");
	    return false;
	}
	if(document.getElementById("commentContent").value==0)
	{
	    alert("请填写评论内容");
	    return false;
	}
	if(document.getElementById("commentAuthor").value==0)
	{
	    alert("请填写您的名字");
	    return false;
	}
	if(document.getElementById("rememberMe").checked && document.getElementById("userPassword").value==0)
    {
        alert("请填写密码或者不勾选记住我");
        return false;
    }
	return true;
}
function GetBlogViewResponse(url,request)
{
  try
  {
    if(request=="temp=0"){SlowScrollTo(80);}
    blogxml.postXml(url,request,DisplayBlogViewHandler,1);
  }
  catch(error)
  {
    ProcessError(error);
  }
}
function DisplayBlogViewHandler(status,value)
{
    var mainContent = GetMainContent();
    mainContent.innerHTML = value.xtext;
    SetUserToCookie();
    DisplayUser();
    FadeLoadingContent();
}
function GetBlogViewDisplay(url)
{
    GetBlogViewDisplayProcess(url);
    GetBlogHistory().add(GetBlogViewDisplayProcess,url);
    SetHistoryControlStatus();
}
function GetBlogViewDisplayProcess(url)
{
    AppearLoadingContent();
	GetBlogViewResponse(url,"temp=0");
}
function ResetCommentInput()
{
    document.getElementById("commentTitle").value = "";
    document.getElementById("commentAuthor").value = "";
    document.getElementById("commentContent").value = "";
    document.getElementById("userPassword").value = "";
}
function GetCommentInput()
{
    var request;
    request  = "commentTitle=" + escape(document.getElementById("commentTitle").value) + "&commentAuthor=" + escape(document.getElementById("commentAuthor").value);
    request += "&commentContent=" + escape(document.getElementById("commentContent").value) + "&action=newComment";
    request += "&userPassword=" + escape(document.getElementById("userPassword").value) + "&rememberMe=" + escape(document.getElementById("rememberMe").checked);
    return request;
}
function GetCommentPostUrl()
{
    var url;
    url = "blogviewresponse.asp?Content_Id=" + document.getElementById("contentId").value;
    return url;
}
function SaveComment()
{
    if(CommentCheckinput())
    {
        AppearLoadingContent();
        GetBlogViewResponse(GetCommentPostUrl(), GetCommentInput());
    }
}
function SlowScrollTo(position)
{
	var step=50;
	var disparity=window.top.document.body.scrollTop-position;

	if(Math.abs(disparity)>step)
	{
		if(disparity<0)
		{
			step = -step;
		}
		window.top.document.body.scrollTop -= step;
		setTimeout('SlowScrollTo('+position+');', 20);
	}
	else
	{
		window.top.document.body.scrollTop -= disparity;
	}
}
//For Blog Body View Response
function GetBlogBodyDisplay(url,component,contentId,infoComponent)
{
    if(null!=BlogContents[contentId])
    {
        var tempValue;
        var blogBody = document.getElementById(component);
        var tempValue = blogBody.innerHTML;
        var originalHeight = blogBody.offsetHeight;
		
		blogBody.innerHTML = BlogContents[contentId].processingData;
		BlogContents[contentId].processingData = tempValue;
		if(BlogContents[contentId].processingTag == 'unfolded')
		{
			document.body.scrollTop = document.body.scrollTop - originalHeight + blogBody.offsetHeight;
			document.getElementById(BlogContents[contentId].processingRelatedComponent).innerHTML = '阅读全文<img src="images/content_unfold.gif" />';
			BlogContents[contentId].processingTag = 'folded';
		}
		else
		{
			document.getElementById(BlogContents[contentId].processingRelatedComponent).innerHTML = '收起本文<img src="images/content_fold.gif" />';
			BlogContents[contentId].processingTag = 'unfolded';
		}
    }
    else
    {
		SingleItemProcessStatus = new ProcessStatus(component,
                                        url,
                                        document.getElementById(component).innerHTML,
                                        contentId,
                                        infoComponent,
                                        null);
        GetBlogBodyDisplayProcess(SingleItemProcessStatus);
    }
}
function GetBlogBodyDisplayProcess(processStatus)
{
    AppearLoadingContent();
    if(document.getElementById(processStatus.processingComponent)!=null)
    {
        GetBlogBodyResponse(processStatus.processingUrl);
    }
    else
    {
        ProcessError('加载失败请稍候再试.');
	}
}
function GetBlogBodyResponse(url)
{
  try 
  {
    blogxml.getXml(url,DisplayBlogBodyHandler,1);
  }
  catch(error)
  {
    ProcessError(error);
  }
}
function DisplayBlogBodyHandler(status,value)
{
    var blogBody = document.getElementById(SingleItemProcessStatus.processingComponent); 
    if(blogBody != null) 
    {
        blogBody.innerHTML = value.xtext;
        SingleItemProcessStatus.processingTag = 'unfolded';
        document.getElementById(SingleItemProcessStatus.processingRelatedComponent).innerHTML = '收起本文<img src="images/content_fold.gif" />';
        BlogContents[SingleItemProcessStatus.processingContentId] = SingleItemProcessStatus;
        Effect.Fade('loadingContent');
    }
    else
    {
        ProcessError('加载失败请稍候再试.');
    }
}
function ResetBlogContentsFoldStatus()
{
    var blogContents = GetBlogContents();
    if(typeof(blogContents) == 'undefined')
    {
        return;
    }
    else if(null == blogContents)
    {
        blogContents = new Array();
        return;
    }
    else
    {
        for(var i=0;i<blogContents.length;i++)
        {
            if(typeof(blogContents[i]) != 'undefined' &&
               blogContents[i] != null && 
               blogContents[i].processingTag == 'unfolded')
            {
                blogContents[i] = null;
            }
        }
    }
}
//For history control
function SetHistoryControlStatus()
{
    var backControl = GetIncludeParent("backContrl");
    var forwardControl = GetIncludeParent("forwardControl");
    var refreshControl = GetIncludeParent("refreshControl");
    if(GetBlogHistory().backEnabled())
    {
        backControl.src = "images/back_active.gif";
        backControl.disabled = false;
    }
    else
    {
        backControl.src = "images/back_inactive.gif";
        backControl.disabled = true;
    };
    if(GetBlogHistory().forwardEnabled())
    {
        forwardControl.src = "images/forward_active.gif";
        forwardControl.disabled = false;
    }
    else
    {
        forwardControl.src = "images/forward_inactive.gif";
        forwardControl.disabled = true;
    };
    if(GetBlogHistory().refreshEnabled())
    {
        refreshControl.src = "images/refresh_active.gif";
        refreshControl.disabled = false;
    }
    else
    {
        refreshControl.src = "images/refresh_inactive.gif";
        refreshControl.disabled = true;
    };
}
function BackMouseOverStyle()
{
    var backControl = GetIncludeParent("backContrl");
    if(!backControl.disabled)
    {
        backControl.style.cursor = "hand";
        backControl.src = "images/back_over.gif";
    }
}
function BackMouseNormalStyle()
{
    var backControl = GetIncludeParent("backContrl");
    if(!backControl.disabled)
    {
        backControl.style.cursor = "default";
        backControl.src = "images/back_active.gif";
    }
}
function ForwardMouseOverStyle()
{
    var forwardControl = GetIncludeParent("forwardControl");
    if(!forwardControl.disabled)
    {
        forwardControl.style.cursor = "hand";
        forwardControl.src = "images/forward_over.gif";
    }
}
function ForwardMouseNormalStyle()
{
    var forwardControl = GetIncludeParent("forwardControl");
    if(!forwardControl.disabled)
    {

        forwardControl.style.cursor = "default";
        forwardControl.src = "images/forward_active.gif";
    }
}
function RefreshMouseOverStyle()
{
    var refreshControl = GetIncludeParent("refreshControl");
    if(!refreshControl.disabled)
    {
        refreshControl.style.cursor = "hand";
        refreshControl.src = "images/refresh_over.gif";
    }
}
function RefreshMouseNormalStyle()
{
    var refreshControl = GetIncludeParent("refreshControl");
    if(!refreshControl.disabled)
    {
        refreshControl.style.cursor = "default";
        refreshControl.src = "images/refresh_active.gif";
    }
}
function HomeMouseOverStyle()
{
    var homeControl = GetIncludeParent("homeControl");
    homeControl.style.cursor = "hand";
    homeControl.src = "images/home_over.gif";
}
function HomeMouseNormalStyle()
{
    var homeControl = GetIncludeParent("homeControl");
    homeControl.style.cursor = "default";
    homeControl.src = "images/home_active.gif";
}

//For loading content.
function ModifyLoadingContent()
{
    var content = document.getElementById("loadingContent");
    if(null != content)
    {
        content.style.top = (document.body.clientHeight*0.4+document.body.scrollTop).toString()+'px';
    }
    setTimeout("ModifyLoadingContent();", 100);
}

//For Open CLI Window
function OpenCLIWindow(){
    var height=600;
    var width =800;
    if(window.screen){
    height = screen.availHeight - 5;
    width = screen.availWidth - 5;
    }
    window.open("blogcli.asp","CLIWindow","height="+height+",width="+width+",top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
}

//From header
function OpenOldPart(){
    var height=480;
    var width =780;
    var positionX = (screen.width-width)/2;
    var positionY = (screen.height - height)/2;
    var openedWindow = window.open("old/index.html","YellowAndWhite","height="+height+",width="+width+",top="+positionY+",left="+positionX+",toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
}

function GetLeavewordsResponse(url,request)
{
  try 
  {
    blogxml.postXml(url,request,DisplayLeavewordsHandler,1);
  }
  catch(error)
  {
    ProcessError(error);
  }
}

function DisplayLeavewordsHandler(status,value)
{
    var mainContent = GetMainContent(); 
    mainContent.innerHTML = value.xtext;
    SetUserToCookie();
    DisplayUser();
    FadeLoadingContent();
}

function GetLeavewordsDisplay(url)
{
    GetLeavewordsDisplayProcess(url);
    GetBlogHistory().add(GetLeavewordsDisplayProcess,url);
    SetHistoryControlStatus();
}

function GetLeavewordsDisplayProcess(url)
{
    AppearLoadingContent();
	GetLeavewordsResponse(url,"temp=0");
}

//For leavewords
function LeavewordsCheckinput()
{
    if(document.getElementById("wordAuthor").value==0)
    {
        alert("请你留下你的名字");
        return false;
    }
    if(document.getElementById("wordContent").value==0)
    {
        alert("请填写留言内容");
        return false;
    }
    if(document.getElementById("rememberMe").checked && document.getElementById("userPassword").value==0)
    {
        alert("请填写密码或者不勾选记住我");
        return false;
    }
    return true;
}

function ResetLeaveworsInput()
{
    document.getElementById("wordAuthor").value = "";
    document.getElementById("wordContent").value = "";
    document.getElementById("wordHomepage").value = "";
    document.getElementById("wordEmail").value = "";
    document.getElementById("userPassword").value = "";
}

function GetLeaveworsInput()
{
    var request;
    request  = "wordAuthor=" + escape(document.getElementById("wordAuthor").value) + "&wordContent=" + escape(document.getElementById("wordContent").value);
    request += "&wordHomepage=" + escape(document.getElementById("wordHomepage").value) + "&wordEmail=" + escape(document.getElementById("wordEmail").value);
    request += "&userPassword=" + escape(document.getElementById("userPassword").value) + "&rememberMe=" + escape(document.getElementById("rememberMe").checked);
    return request;
}

function SaveLeavewords()
{
    if(LeavewordsCheckinput())
    {
        AppearLoadingContent();
        GetLeavewordsResponse("leavewordsresponse.asp", GetLeaveworsInput());
    }
}

function DisplayCalendarHandler(status,value)
{
      var calendarContent = document.getElementById("calendarContent"); 
      calendarContent.innerHTML = value.xtext;
}

function GetCalendarResponse(url)
{
    try{
        blogxml.getXml(url,DisplayCalendarHandler,1);
    }
    catch(error){
        ProcessError(error);
    }
}

function GetCalendarDisplay(url)
{
    GetCalendarDisplayProcess(url);
    GetBlogHistory().add(GetCalendarDisplayProcess,url);
    SetHistoryControlStatus();
}

function GetCalendarDisplayProcess(url)
{
    GetCalendarResponse(url);
}

function SetUserToCookie()
{
    var isDisplayUser = GetIncludeParent('isDisplayUser');
    if(null != isDisplayUser && isDisplayUser.value == 'true')
    {
        var userName = GetIncludeParent('displayUserName');
		var now=new Date(); 
		now.setTime(now.getTime()+1000*60*60*24*365);
        window.top.window.document.cookie = "DisplayUserName=" + encodeURIComponent(userName.value) + "; expires="+now.toGMTString();
    }
}

function DisplayUser()
{
    var cookieList = window.top.window.document.cookie.split(";");
    var isDisplayWelcomeMessage = false;
    var userNameInCookie = null;
    for(var i=0; i<cookieList.length; i++)
    {
        var cookieItem = cookieList[i].split("=");
        if(cookieItem != null && cookieItem.length == 2)
        {
            if(cookieItem[0] == 'DisplayUserName' || cookieItem[0] == ' DisplayUserName')
            {
                var displayUser = GetIncludeParent('displayUser');
                if(displayUser != null)
                {
                    userNameInCookie = decodeURIComponent(cookieItem[1]);
                    displayUser.visible = true;
                    displayUser.innerHTML = "*** " + userNameInCookie + " 欢迎您来到本Blog ***";
                    if(window.CurrentUserName == null || window.CurrentUserName != userNameInCookie)
                    {
                        isDisplayWelcomeMessage = true;
                    }
                    window.CurrentUserName = userNameInCookie;
                }
            }
        }
    }
    if(window.CurrentUserName != null)
    {
        var wordAuthor = GetIncludeParent('wordAuthor');
        var commentAuthor = GetIncludeParent('commentAuthor');
        if(wordAuthor!=null)
        {
            wordAuthor.value = window.CurrentUserName;
        }
        if(commentAuthor!=null)
        {
            commentAuthor.value = window.CurrentUserName;
        }
    }
    
    var userWelcomeMessage = GetIncludeParent("userWelcomeMessage");
    if(userWelcomeMessage != null)
    {
        if(isDisplayWelcomeMessage)
        {
            userWelcomeMessage.visible=true;
        }
        else
        {
            userWelcomeMessage.style.display="none";
        }
    }
}

function ChangeAllCss(cssName)
{
    ChangeCss(document,cssName);
    ChangeCss(window.frames['topiclist'].window.document,cssName);
    SetSkinToCookie(cssName)
}

function ChangeCss(docElement,newCssName)
{
    var skinCss = docElement.getElementById('skinCss');
    var head = skinCss.parentNode;
    head.removeChild(skinCss);
    skinCss = null;
    skinCss = docElement.createElement('link'); 
    skinCss.type = 'text/css';
    skinCss.rel = 'stylesheet';
    skinCss.href = newCssName;
    skinCss.id = "skinCss";
    head.appendChild(skinCss);
}
function SetSkinToCookie(cssName)
{
    var now=new Date(); 
    now.setTime(now.getTime()+1000*60*60*24*365);
    window.top.window.document.cookie = "CurrentSkin=" + escape(cssName) + "; expires="+now.toGMTString();
}