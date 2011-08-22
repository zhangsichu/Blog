var blogxml = {
	object_version:"V 0.1",
	counter:0,
	content_type:"text/html",

	_xml_http_cache_enabled:1,
	_xml_requests:[],
	_xml_requests_map:[],
	_xml_http_objects:[],
	_xml_http_object_use:0,
	_xml_http_object_count:5,
	_xml_http_object_pool_size:5,
	_xml_http_object_pool_max:10,
	_xml_http_pool_created:0,
	_xml_http_pool_enabled:1,

	setCacheEnabled:function(b){
		blogxml.clearCache();
		blogxml._xml_http_cache_enabled = b;
	},

	getCacheEnabled:function(){
		return blogxml._xml_http_cache_enabled;
	},
	
	setPoolEnabled:function(b){
		blogxml._xml_http_pool_enabled = b;
	},

	getPoolEnabled:function(){
		return blogxml._xml_http_pool_enabled;
	},


	getXmlHttpArray:function(){
		return blogxml._xml_http_objects;
	},
			
	newXmlDocument:function(n){
		
		var r = 0,e;
		if(typeof document.implementation != "undefined" && typeof document.implementation.createDocument != "undefined"){
			r = document.implementation.createDocument("",n,null);
			if(r != null && r.documentElement == null){
				r.appendChild(r.createElement(n));
			}
		}
		else if(typeof ActiveXObject != "undefined"){
			r = new ActiveXObject("MSXML.DOMDocument");
			e = r.createElement(n);
			r.appendChild(e);
		}
		else{
		}
		return r;
	},
	
	clearCache:function(){
		var _x = blogxml,i = 0,o;
		for(;i<_x._xml_requests.length;i++){
			o = _x._xml_requests[i];
			if(o.cached && typeof o.cached_dom == "object"){
				o.cached_dom = 0;
			}
			o.obj = null;
			o.internal_handler = null;
			o.handler = null;
		}
		_x._xml_requests = [];
		_x._xml_requests_map = [];
	},
	resetXmlHttpObjectPool:function(){
		var _x = blogxml,i = 0,o;
		_x._xml_http_pool_created = 1;
		_x._xml_http_object_use=0;
		_x._xml_http_objects=[];
		_x._xml_http_object_count = _x._xml_http_object_pool_size;
		for(;i < _x._xml_http_object_pool_size; i++)
			o = _x._xml_http_objects[i] = _x.newXmlHttpObject(1,i);
		
	},
    
    newXmlHttpObject:function(b,i,z){
		/*
			b = return a hash for use with pooling
			i = pool index value.  b must be true for i to be used
			z = used for testing object creation
		*/
		var o = null,v,f;
		if(typeof XMLHttpRequest != "undefined"){
			o = new XMLHttpRequest();
			if(z) return 1;
		}
		else if(typeof ActiveXObject != "undefined"){
			try{
				o = new ActiveXObject("MSXML2.XMLHTTP.3.0");
				if(z) return 1;
			}
			catch(e){
				alert("XMLError: " + (e.description?e.description:e.message));
			}
			if(z) return 0;
		}
		if(b && typeof i == "number"){
			v= {
				xml_object:o,
				in_use:0,
				index:i,
				vid:-1,
				handler:0
			};

			return v;
		}
		else{
			return o;
		}
		
	},

	returnXmlHttpObjectToPool:function(i, y){
		var _x = blogxml,b=0,o,a;
		a = _x._xml_http_objects;

		if(typeof a[i] == "object"){
			o = a[i];
			if(o.index >= _x._xml_http_object_pool_size)
				a[i] = 0;
			try{
				if(!y){
					if(typeof XMLHttpRequest != "undefined"){
						if(typeof o.xml_object.removeEventListener == "function")
							o.xml_object.removeEventListener("load",o.handler,false);
						else
							o.xml_object.onreadystatechange = _x._stub;
					}
					else if(typeof ActiveXObject != "undefined" &&  o.xml_object instanceof ActiveXObject)
						o.xml_object.onreadystatechange=_x._stub;
					o.handler = 0;
				}

			}
			catch(e){
				alert("Error in returnXmlHttpObjectToPool: " + (e.description?e.description:e.message));
			}
			o.xml_object.abort();			
			o.in_use = 0;
			o.vid = -1;
			_x._xml_http_object_use--;
		}
		return 1;
	},
	
	getXmlHttpObjectFromPool:function(y){
		var _x = blogxml,i = 0,b=0,o,a,n=-1,z=0;

		if(!_x._xml_http_pool_created) _x.resetXmlHttpObjectPool();
		a = _x._xml_http_objects;		
		for(;i<a.length;i++){
			if(typeof a[i] == "object" && typeof a[i].in_use == "number" && !a[i].in_use){
				a[i].in_use = 1;
				b = i;
				z = 1;
				break;
			}
			if(n == -1 && !a[i])
				n = i;
		}

		if(!z){
			b = (n > -1)?n:a.length;
			if(b < _x._xml_http_object_pool_max){
				a[b] = _x.newXmlHttpObject(1,b);
				a[b].in_use = 1;
			}
			else{
				return null;
			}
		}

		if(b > -1){
			_x._xml_http_object_use++;
			o = a[b];
			try{
				if(!y){
					if(typeof XMLHttpRequest != "undefined"){
						if(typeof o.xml_object.addEventListener == "function"){
							o.handler = function(){blogxml._handle_xml_request_load(b);};
							o.xml_object.addEventListener("load",o.handler,false);
						}
						else{
							o.handler = function(){blogxml._handle_xml_request_readystatechange(b);};
							o.xml_object.onreadystatechange = o.handler;
						}
					}
					else if(typeof ActiveXObject != "undefined" &&  o.xml_object instanceof ActiveXObject){
						o.handler = function(){blogxml._handle_xml_request_readystatechange(b);};
						o.xml_object.onreadystatechange=o.handler;
					}
				}
			}
			catch(e){
				alert("Error in getXmlHttpObjectFromPool: " + (e.description?e.description:e.message));
			}

			return a[b];
		}
		return null;

	},
	
	_handle_xml_request_load:function(xml_id){
		var _x=blogxml,o,v,z;
		try{

			if(_x._xml_http_pool_enabled && typeof _x._xml_http_objects[xml_id] == "object"){
				z = _x._xml_http_objects[xml_id].vid;
				if(z == -1){
					alert("invalid  pool index for " + xml_id);
					return 0;
				}
				xml_id = z;
			}

			if(typeof _x._xml_requests_map[xml_id] == "number"){
				o = _x._xml_requests[_x._xml_requests_map[xml_id]];
				
				v = {"xdom":null,"id":(o.backup_id?o.backup_id:xml_id)};
				if(
					o.url.match(/^file:/i)
					&&
					typeof ActiveXObject != "undefined"
					&&
					o.o instanceof ActiveXObject
				){
					var mp = new ActiveXObject("MSXML.DOMDocument");
					mp.loadXML(o.o.responseText);
					v.xdom = mp;
				}
				else if(o.obj != null)
				{
				    if(o.obj.responseXML != null)
					   v.xdom = o.obj.responseXML;
				    if(o.obj.responseText != null)
					   v.xtext = o.obj.responseText;
			    }			
				else
					alert("Error loading '" + o.url + "'. The internal XML object reference is null");			
				
	
				o.completed = 1;
			
				if(o.internal_handler)
					o.internal_handler = 0;
				

				if(o.cached)
					o.cached_dom = v.xdom;

				if(typeof o.handler=="function") o.handler("onloadxml",v);
					if(o.pool_index > -1)
					_x.returnXmlHttpObjectToPool(o.pool_index,!o.async);
				o.obj = 0;
	
			}
			else{
				alert("Invalid id reference: " + xml_id);
			}

		}
		catch(e){
			alert("Error in handle_xml_request_load: " + (e.description?e.description:e.message));
		}
	},

	_handle_xml_request_readystatechange:function(xml_id){
		var _x=blogxml,o;

		if(_x._xml_http_pool_enabled && typeof _x._xml_http_objects[xml_id] == "object"){
			o = _x._xml_http_objects[xml_id];
			if(typeof o.xml_object == "object" && o.xml_object.readyState == 4)
				_x._handle_xml_request_load(xml_id);
			
		}
		else if(typeof _x._xml_requests_map[xml_id] == "number"){
			o = _x._xml_requests[_x._xml_requests_map[xml_id]];
			if(typeof o.obj == "object" && o.obj.readyState == 4)
				_x._handle_xml_request_load(xml_id);
			
		}
	},
	getXml:function(p,h,a,i,c){
	/*
			p = path
			h = handler
			a = async
			i = id
			c = cached
	*/
		return blogxml._request_xmlhttp(p,h,a,i,0,null,c);
	},

	postXml:function(p,d,h,a,i){
		return blogxml._request_xmlhttp(p,h,a,i,1,d,0);
	},
	_request_xmlhttp:function(p,h,a,i,x,d,c){
		var _x=blogxml,f,o=null,v,y,z,r,b,b_ia,g,bi = 0;

		if(typeof p != "string" || p.length == 0){
			alert("Invalid path parameter in _request_xmlhttp");
			return 0;
		}
		
		if(typeof c=="undefined") c = 0;
		if(typeof x=="undefined") x = 0;
		if(typeof d=="undefined") d = null;

		z = (x?"POST":"GET");
		if(typeof i!="string") i = "swc-" + (++_x.counter) + "-" + parseInt(Math.random()*10000);
		if(
			typeof _x._xml_requests_map[i] == "number"
			&&
			typeof _x._xml_requests[_x._xml_requests_map[i]] == "object"
		){
			r = _x._xml_requests[_x._xml_requests_map[i]];

			if(_x._xml_http_cache_enabled && r.cached && typeof r.cached_dom == "object"){
				b = {"xdom":r.cached_dom,"id":i};
				if(typeof h == "function") h("onloadxml",b);
				return r.cached_dom;
			}
			else if(!r.completed){
				c = 0;
				bi = i;
				i = "swc-" + (++_x.counter) + "-" + parseInt(Math.random()*10000);
			}
		}
		
		b = _x._xml_http_pool_enabled;
		if(b)
			r = _x.getXmlHttpObjectFromPool(!a);
		
		else
			r = _x.newXmlHttpObject();
		if(!(b?(r&&r.xml_object):r)){
			b = {"xdom":null,"id":i};
			if(typeof h == "function") h("onloadxml",b);
			return 0;
		}

		if(b) r.vid = i;
		
		y = _x._xml_requests.length;
		_x._xml_requests[y] = {
			async:a,
			url:p,
			id:i,
			backup_id:bi,
			obj:(b?r.xml_object:r),
			internal_handler:0,
			handler:h,
			method:(x?1:0),
			completed:0,
			pool_index:(b?r.index:-1),
			cached:c,
			cached_dom:0
		};
		_x._xml_requests_map[i]=y;
		o = _x._xml_requests[y].obj;

		if(!p.match(/:\/\//)){
			var m,e=new RegExp("^/");
			if(!p.match(e)){
				m=location.pathname;
				m=m.substring(0,m.lastIndexOf("/")+1);
				p=m + p;
			}
			if(!location.protocol.match(/^file:$/i))
				p = location.protocol + "//" + location.host + p;
			else
				p = location.protocol + "//" + p;

		}
		_x._xml_requests[y].url = p;

		b_ia = (typeof ActiveXObject != "undefined" &&  o instanceof ActiveXObject)?1:0;
		try{
			if(!b && a && typeof XMLHttpRequest != "undefined"){
				if(typeof o.addEventListener == "function"){
					_x._xml_requests[y].internal_handler = function(){blogxml._handle_xml_request_load(i);};
					o.addEventListener("load",_x._xml_requests[y].internal_handler,false);
				}
				else{
					_x._xml_requests[y].internal_handler = function(){blogxml._handle_xml_request_readystatechange(i);};
					o.onreadystatechange=_x._xml_requests[y].internal_handler;
				}
			}
			else if(!b && a && b_ia){
				_x._xml_requests[y].internal_handler = function(){blogxml._handle_xml_request_readystatechange(i);};
				o.onreadystatechange=_x._xml_requests[y].internal_handler;
			}
		}
		catch(e){
			alert("Error in _request_xmlhttp: " + (e.description?e.description:e.message));
		}		
		
		if(b && !a){
			_x._xml_http_objects[_x._xml_requests[y].pool_index] = 0;
		}
		
		g = (a?true:false);
		o.open(z,p,g);
		if (typeof o.setRequestHeader != "undefined") {
			o.setRequestHeader("Content-Type", blogxml.content_type);
			o.setRequestHeader("Content-Type" , "application/x-www-form-urlencoded; charset=UTF-8" );
		}
		o.send(d);
		if(!a){
			z = o.responseXML;
			if(
				p.match(/^file:/i)
				&&
				b_ia
			){
				var mp = new ActiveXObject("MSXML.DOMDocument");
				mp.loadXML(o.responseText);
				z = mp;

			}
			if(b){
				_x._xml_http_objects[_x._xml_requests[y].pool_index] = r;
				_x._handle_xml_request_load(_x._xml_requests[y].pool_index);
			}

			_x._xml_requests[y].obj = null;
			
			if(!b && _x._xml_requests[y].pool_index > -1)
				_x.returnXmlHttpObjectToPool(_x._xml_requests[y].pool_index,!a);
			
			
			return z;
		}
		return 1;
	},
	_stub:function(){
	},

	serialize:function(n){
		var v;
		if(typeof XMLSerializer != "undefined"){
			return (new XMLSerializer()).serializeToString(n);
		}
		else if(typeof n.xml == "string"){
			return n.xml;
		}
	},
	getCDATAValue:function(n){
		var c,d="",i=0,e;
		c = n.childNodes;
		for(;i<c.length;i++){
			e=c[i];
			if(e.nodeName=="#cdata-section") d+=e.nodeValue;
		}
		return d;
	},
	
	selectSingleNode:function(d,x,c){
		/*
			d = XmlDocument
			x = xpath
			c = context node
		*/
		var s,i,n;
		if(typeof d.evaluate != "undefined"){
			c = (c ? c : d.documentElement);
			s = d.evaluate(x,c,null,0,null);

			return s.iterateNext();
		}
		else if(typeof d.selectNodes != "undefined"){
			return (c ? c : d).selectSingleNode(x);
		}

		return 0;
	
	},
	selectNodes:function(d,x,c){
		/*
			d = XmlDocument
			x = xpath
			c = context node
		*/
		var s,a = [],i,n;
		if(typeof d.evaluate != "undefined"){
			c = (c ? c : d.documentElement);
			s = d.evaluate(x,c,null,0,null);

			n = s.iterateNext();

			while( typeof n == "object" && n != null){
				a[a.length] = n;
				n = s.iterateNext();
			}

			return a;

		}

		else if(typeof d.selectNodes != "undefined"){
			return (c ? c : d).selectNodes(x);
		}

		return a;
	
	},
	
	queryNodes:function(x,p,n,a,v){
		return blogxml._queryNode(x,p,n,a,v,1);
	},
	queryNode:function(x,p,n,a,v){
		return blogxml._queryNode(x,p,n,a,v,0);
	},
	_queryNode:function(x,p,n,a,v,z){
		/*
			 x = xdom
			 p = parent path
			 n = node path
			 a = attribute name
			 v = attribute value
		*/

		var i=0,b,e,c,r=[];
		if(!z) r = null;
		
		c = x.getElementsByTagName(p);
		
		if(typeof n=="string"){

			if(!c.length){
				if(!z) return null;
				else return r;
			}
			c = c[0]; 
			e = c.getElementsByTagName(n);
		}
		else e = c;

		
		for(;i<e.length;i++){
			b = e[i];
			if((!a && !v) || (b.getAttribute(a) == v)){
				/*
					single query
				*/
				if(!z){
					r = b;
					break;
				}

				else r[r.length]=b;
				
			}
		}
		return r;
	},

	getInnerText:function(s){
		var r = "",a,i,e;
		if(typeof s == "string") return s;
		if(typeof s=='object' && s.nodeType==3) return s.nodeValue;
		if(s.hasChildNodes()){
			a = s.childNodes;
			for(i=0;i<a.length;i++){
				e = a[i];
				if(e.nodeType==3) r+=e.nodeValue;
				if(e.nodeType==1 && e.hasChildNodes()){
					r+=this.getInnerText(e);
				}
			}
		}
		return r;
	},
	removeChildren:function(o){
		var i;
		for(i=o.childNodes.length-1;i>=0;i--)
			o.removeChild(o.childNodes[i]);
		
	},
	setInnerXHTML:function(t,s,p,d,z){
		/*
			t = target
			s = source
			p = preserve
			d = target document object
			z = no recursion
			
			r = return node reference
		*/
		var y,e,a,l,x,n,v,r = 0,b;
		
		if(!d) d = document;
		
		b = (d == document?1:0);
		
		if(!p)
			blogxml.removeChildren(t);
		

		y=(s && typeof s=="object")?s.nodeType :(typeof s=="string")?33:-1;
		switch(y){
			case 1:
				e=d.createElement(s.nodeName);
				a=s.attributes;
				l=a.length;
				for(x=0;x<l;x++){
					n=a[x].nodeName;
					v=a[x].nodeValue;
					if(b && n=="style"){
						e.style.cssText=v;
					}
					else if(b && n=="id"){
						e.id=v;
					}

					else if(b && n=="class"){
						e.className=v;
					}

					else if(b && n.match(/^on/i)){
						eval("e." + n + "=function(){" + v  +"}");
					}
					else{
						e.setAttribute(n,v);
					}
				}
	
				if(!z && s.hasChildNodes()){
					a=s.childNodes;
					l=a.length;
					for(x=0;x<l;x++){
						this.setInnerXHTML(e,a[x],1,d);
					}
				}
				t.appendChild(e);
				r = e;
				break;
			case 3:
				e=s.nodeValue;
				if(e){
					e=e.replace(/\s+/g," ");
					t.appendChild(d.createTextNode(e));
					r = e;
				}
				break;
			case 4:
				e = s.nodeValue;
				t.appendChild(d.createCDATASection(e));
				break;

			case 8:
				break;
			case 33:
				e=s;
				if(e){
					e=e.replace(/^\s*/,"");
					e=e.replace(/\s*$/,"");
					e=e.replace(/\s+/g," ");
					t.appendChild(d.createTextNode(e));
					r = e;
				}
				break;
			default:
				break;
		}
		return r;
	},
	
	transformNode:function(x, s, n, i, j, p){
		var xp, o = null,_x = blogxml,v,a,b,c,d;

		if(typeof x == "string" && x.length > 0){
			if(p && !i) p =0;
			v = x;
			x = _x.getXml(x,0,0,i,p);
			if(v.match(/\?(\S*)$/)){
				v = v.match(/\?(\S*)/)[1];
				a = v.split("&");
				for(b=0;b<a.length;b++){
					c = a[b].split("=");
					x.documentElement.setAttribute(c[0],c[1]);
				}
			}
		}

		if(typeof s == "string" && s.length > 0){
			if(p && !j) p =0;
			s = _x.getXml(s,0,0,j,p);
		}
		
		if(typeof x != "object" || x == null || typeof s != "object" || s == null){
			alert("Invalid parameters in transformNode. Xml Node = " + x + ", xsl document = " + s);
			return o;
		}

		if(typeof n != "object") n = x;

		try{
			if(typeof XSLTProcessor != "undefined"){
				xp = new XSLTProcessor();
				xp.importStylesheet(s);
				o = xp.transformToFragment(n,document);
				if(o) o = o.firstChild;
			}
	
			else if(typeof ActiveXObject != "undefined" && x instanceof ActiveXObject){
				o = new ActiveXObject("MSXML.DOMDocument");
				xp = n.transformNode(s);
				o.loadXML(xp);
				o = o.documentElement;
			}
			else{
				alert("Error in transformNode");
			}
		}
		catch(e){
			alert("Error in transformNode: " + (e.description?e.description:e.message));
		}
		
		return o;

	}
};