//Stack Class
function Stack(){
	this.capacity=50;
    this.size=0;
    this.span=10;
    this.elements=new Array(this.capacity);
}
Stack.MESSAGE_NOTFOUND=-1;

Stack.prototype.recapacity=function (){
    if(this.capacity-this.size<10){
     this.capacity+=this.span;
     var oldElements=this.elements;
        this.elements=new Array(this.capacity); 
        for(var i=0;i<this.size;i++){
            this.elements[i]=oldElements[i]; 
        }
    }
};

Stack.prototype.push=function(obj){
	this.recapacity();
	this.elements[this.size++]=obj;
};

Stack.prototype.pop=function(){
    var oldElems=this.elements;
	this.elements=new Array(this.capacity);
	for(var i=0;i<this.size-1;i++){
	    this.elements[i]=oldElems[i];
	}
	this.size--;
	return oldElems[this.size];
};

Stack.prototype.peek=function(){
    return this.elements[this.size-1];
};

Stack.prototype.empty=function(){
	return this.size==0;
};

Stack.prototype.search=function(obj){
	for(var i=0;i<this.size;i++){
	    if(this.elements[i]==obj){
	        return i+1;
	    }
	}
	return Stack.MESSAGE_NOTFOUND;
};

//History Class
function History()
{
    this.backStack = new Stack();
    this.forwardStack = new Stack();
    this.backArgumentStack = new Stack();
    this.forwardArgumentStack = new Stack();
    this.currentFunc = null;
    this.currentArgument = null;
}

History.prototype.add=function(func,argument)
{
    if(this.currentFunc == null)
    {
        this.currentFunc = func;
        this.currentArgument = argument;
        return;
    }
    if(this.currentFunc == func && this.currentArgument == argument)
    {
        //return;
    }
    this.addBasic();
    this.currentFunc = func;
    this.currentArgument = argument;
};

History.prototype.addBasic=function()
{
    this.backStack.push(this.currentFunc);
    this.backArgumentStack.push(this.currentArgument);
};

History.prototype.backEnabled = function()
{
    return this.backStack.size > 0;
};

History.prototype.forwardEnabled = function()
{
    return this.forwardStack.size > 0;
};

History.prototype.refreshEnabled = function()
{
    return this.currentFunc != null;
};

History.prototype.doBack = function()
{
    if(this.backEnabled())
    {
        this.forwardStack.push(this.currentFunc);
        this.forwardArgumentStack.push(this.currentArgument);
        this.currentFunc = this.backStack.pop();
        this.currentArgument = this.backArgumentStack.pop();
        this.currentFunc(this.currentArgument);
    }
};

History.prototype.doForward = function()
{   
    if(this.forwardEnabled())
    {
        this.backStack.push(this.currentFunc);
        this.backArgumentStack.push(this.currentArgument);
        this.currentFunc = this.forwardStack.pop();
        this.currentArgument = this.forwardArgumentStack.pop();
        this.currentFunc(this.currentArgument);
    }
};

History.prototype.doRefresh = function()
{   
    if(this.refreshEnabled())
    {
        this.currentFunc(this.currentArgument);
    }
};

//ProcessStatus Class
function ProcessStatus(component,url,data,contentId,relatedComponent,tag)
{
    this.processingComponent = component;
    this.processingUrl = url;
    this.processingData = data;
    this.processingContentId = contentId;
    this.processingRelatedComponent = relatedComponent;
    this.processingTag = tag;
};

ProcessStatus.prototype.setValue = function(component,url,data,contentId,relatedComponent,tag)
{
    this.processingComponent = component;
    this.processingUrl = url;
    this.processingData = data;
    this.processingContentId = contentId;
    this.processingRelatedComponent = relatedComponent;
    this.processingTag = tag;
};