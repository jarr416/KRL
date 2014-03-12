ruleset LocationData {
  meta {  
//b505289x4.prod
    name "Locatino Data"
    description <<
      Checkin In With Foursquare
    >>
    author ""
    logging off
	use module a169x701 alias CloudRain
	use module a41x186  alias SquareTag
	
	
	provides getLocation, getConstant
  }
  
   dispatch {
	}

	global {
		
		getLocation = app:locationData;
		
		
		getConstant = "IM GETTING IT";
		
	}
	
	rule imWorking is active {
	select when pageview ".*" 
	//	pre {
	//		map = {};
	//		}
		{
	  	notify(app:locationData.as("str") , "I can make a Notify") with sticky = true;
		}
	//	always {
	//		set app:locationData map.put(["test"],"ITS WORKING");
	//		set app:locationData map.put(["t1"],"ITS 2");
	//		}
	}
	

	rule add_location_item is active {
		select when pds new_location_data

		pre {
			k = event:attr("key");
			v = event:attr("value");

			map = {};
		}
		{
			send_directive(k) with location = v;
		}
		always {
			set app:locationData map.put([k],v);
		}
	}

}