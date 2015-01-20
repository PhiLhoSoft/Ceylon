// Based on code from https://github.com/sgalles/ceylon-in-web-browser
// which is based on http://ceylon-lang.org/blog/2013/02/26/ceylon-in-the-browser/
// Thanks to them!

String id_information = "information";
String id_date_information = "date-information";
String id_fetched_information = "fetched-information";

"Run CeylonJS Test - called after the page loads"
shared void run()
{
	dynamic
	{
		dynamic element = document.getElementById(id_information);
		element.innerHTML = buildInformation();
	}
}

"Build information to be displayed"
String buildInformation()
{
	return "<div>
	        	<div id='``id_date_information``'>Today is ``fetchDate()``</div>
	        	<pre id='``id_fetched_information``'></pre>
	        </div>";
}

"Callback for the HTML button's click event"
shared void updateTime(dynamic eventSource)
{
	dynamic
	{
		dynamic element = document.getElementById(id_date_information);
		element.innerHTML = "Updated time is ``fetchDate()``";

		// Call a pure JavaScript function
//		dynamic data = value { greeting="Hello", language="Ceylon" };
		exposed("Information from Ceylon");
	}
}

shared void callServer(dynamic eventSource)
{
	dynamic
	{
		dynamic request = createCORSRequest("GET", "https://api.stackexchange.com/2.2/info?site=stackoverflow");
		request.onreadystatechange = void()
		{
			if (request.readyState == 4)
			{
				document.getElementById(id_fetched_information).innerHTML =
						"Calling Stackoverflow:\n\n" +
						"Headers:\n" + request.getAllResponseHeaders() +
						"\n\nResponse:\n" + request.response;
			}
		};
		request.send();
	}
}

String fetchDate()
{
	// Call JS's Date object constructor
	dynamic { return Date().toString(); }
}

