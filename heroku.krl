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
