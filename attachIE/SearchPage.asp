<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>SearchPage</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script src="http://www.google.com/jsapi?key=ABQIAAAAmzYWw5K-SvwCv6hx-6VL7hRf1w6VMteEz0YZLyb3wqBq8WyClxR3k8Mx2fiMCceqSBdWBDGaJvU9ow" type="text/javascript"></script>
    <script language="Javascript" type="text/javascript">
    //<![CDATA[
    google.load("search", "1");
    function OnLoad() {
      var searchControl = new google.search.SearchControl();
      
      // Add in a full set of searchers
      var localSearch = new google.search.LocalSearch();
      searchControl.addSearcher(localSearch);
      searchControl.addSearcher(new google.search.WebSearch());
      searchControl.addSearcher(new google.search.VideoSearch());
      searchControl.addSearcher(new google.search.BlogSearch());
      
      // Set the Local Search center point
      localSearch.setCenterPoint('<%=Request("query")%>');
      
      // Tell the searcher to draw itself and tell it where to attach
      searchControl.draw(document.getElementById("searchcontrol")); 
      // Execute an inital search
      searchControl.execute('<%=Request("query")%>');
    }
    google.setOnLoadCallback(OnLoad);
    //]]>
    </script>
</head>
<body>
    <div style="width:305; overflow:hidden;">
        <div id="searchcontrol">Loading...</div>
    </div>
</body>
</html>
