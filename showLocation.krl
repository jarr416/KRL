ruleset ShowLocation {
  meta {  
//b505289x5.prod
    name "Show Location"
    description <<
      Checkin In With Foursquare
    >>
    author ""
    logging off
	use module a169x701 alias CloudRain
	use module a41x186  alias SquareTag
	
	use module b505289x4 alias Location

  }
  
  dispatch {
	}


  rule show_fs_location is active {
		select when pageview ".*" 
		pre {
			checkin = Location:getLocation();
		//	checkin = Location:getConstant();
		}
		{
	  	notify(checkin.as("str"), "I can make a Notify") with sticky = true;
	  	notify("doing Something I Hope" , "I can make a Notify") with sticky = true;
	  	
		}
	}
}
