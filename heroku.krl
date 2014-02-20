ruleset lab2 {
    meta {
        name "lab2"
        author "Jared"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    
    rule show_form {
        select when pageview ".*"
        pre {
            form = <<
                <p>A Wild Form Is Approaching</p>
                <form id="form" onsubmit="return false">
                First name: <input type="text" name="firstname"><br>
                Last name: <input type="text" name="lastname">
                <input type="submit" value="Submit">
                </form>
            >>;
        } 
        {
        // Display notification that will not fade.
        if ent:firstname.isnull() then {
        	append('#main', form);
        	watch("#form", "submit");
        }
    }
    
    rule show_form {
        select when pageview ".*" 
        {
        if not ent:firstname.isnull() then {
        	replace_inner("#main", "Hello " + ent:firstname + " " +  ent:lastname;
        }
        
    
    rule clicked_rule {
        select when web submit "#form"
        {
        notify("ITS WORKING", "ITS WORKING") with sticky = true;
        replace_inner("#main", "Hello " + event:attr("firstname") + " " +  event:attr("lastname"));
        }
        fired {
        	set ent:firstname event:attr("firstname");
		set ent:lastname event:attr("lastname");
        }
    }
    
    
    //Just displaying Notifications
    rule exercise1_2_3 {
        select when pageview ".*" {
            notify("Hello World", "I can make a Notify") with sticky = true;
            notify("Hello World", "I can make anotherone");
        }
    }
    //Clears it
    rule exercise_6 {
        select when pageview '.*'
        pre {
          clearMe = page:url("query").match(re/clear/);
        }
        if clearMe then {
          notify("Cleared Count", "Count set to 0") with sticky = true;
        }
        fired {
          clear ent:count;
        }
    }
   // Count Notification
    rule exercise_5 {
    	select when pageview '.*'
    	if ent:count < 5 then {
    		notify("Count Notification", "Count = " + ent:count) with sticky = true;
    	}
    	fired {
    		ent:count += 1 from 0;
    	}
    }
    
    rule exercise_4 {
        select when pageview ".*"
        pre {
            query = page:url("query");
            getName = function(string) {
                (string.extract(re/(?:name=)(\w*)/g)).join("")
            };
            name = getName(query);
        }
        if ((not name eq "") && (x < 5)) then {
            notify("test", "Hello " + name + " You have visited " + ent:name + " times") with sticky = true;  
        }
        fired {
            ent:count += 1 from 0;
            ent:name += 1 from 1;
            last
        }
    }
    
    rule exercise_4_part2 {
        select when pageview ".*"
        {
            notify("test", "Hello Monkey");  
        } 
    }
    
    
}
