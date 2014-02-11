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
            notify("Hello World", "My name is bob") with sticky = true;
            notify("Test1", "Hello");
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
            x = app:name + 1
        }
        if ((not name eq "") && (x < 5)) then {
            notify("test", "Hello " + name + "  visit#" + x);  
        }
        fired {
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
