ruleset lab1 {
    meta {
        name "lab1"
        author "Jared"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    rule first_rule {
        select when pageview ".*" {
            notify("Hello World", "I can make a Notify") with sticky = true;
            notify("Hello World", "I can make anotherone");
        }
    }
    
    rule fourth_rule {
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
  
    rule fifth_rule {
    	select when pageview '.*'
    	if ent:count < 5 then {
    		notify("Count Notification", "Count = " + ent:count) with sticky = true;
    	}
    	fired {
    		ent:count += 1 from 0;
    	}
    }
    
    rule second_rule {
        select when pageview ".*"
        pre {
            query = page:url("query");
            getName = function(string) {
                (string.extract(re/(?:name=)(\w*)/g)).join("")
            };
            name = getName(query);
        }
        if ((not name eq "") && (x < 5)) then {
            notify("test", "Hello " + name + " You have visited " + ent:count + " times") with sticky = true;  
        }
        fired {
            ent:count += 1 from 0;
            last
        }
    }
    
    rule third_rule {
        select when pageview ".*"
        {
            notify("test", "Hello Monkey");  
        } 
    }
    
    
}
