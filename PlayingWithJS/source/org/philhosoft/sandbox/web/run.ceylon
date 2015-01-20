// Based on code from https://github.com/sgalles/ceylon-in-web-browser
// which is based on http://ceylon-lang.org/blog/2013/02/26/ceylon-in-the-browser/
// Thanks to them!

"Run CeylonJS Test - called after the page loads"
shared void run()
{
	dynamic
	{
		dynamic element = document.getElementById("information");
		element.innerHTML = buildInformation();
	}
}

"Build information to be displayed"
String buildInformation()
{
	return "<div>
	        	<div id='date-information'>Today is ``fetchDate()``</div>
	        </div>";
}

"Callback for the HTML button's click event"
shared void updateTime(dynamic eventSource)
{
	dynamic
	{
		dynamic element = document.getElementById("date-information");
		element.innerHTML = "Updated time is ``fetchDate()``";
	}
}

String fetchDate()
{
	// Call JS's Date object constructor
	dynamic { return Date().toString(); }
}


