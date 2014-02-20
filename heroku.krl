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
        
        if ent:firstname.isnull() then {
        	append('#main', form);
        	watch("#form", "submit");
        	}
        
    }
    
    rule show_name {
        select when pageview ".*" 
        if not ent:firstname.isnull() then 
        	replace_inner("#main", "Hello " + ent:firstname + " " +  ent:lastname);
        	
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
   
    rule clear_Names {
        select when pageview '.*'
        pre {
          clearMe = page:url("query").match(re/clear=1/);
        }
        if clearMe then {
          notify("Cleared Name", "The old name has been cleared");
        }
        fired {
          clear ent:firstname;
          clear ent:lastname;
        }
    }
    }
