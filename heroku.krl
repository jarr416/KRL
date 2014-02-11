ruleset heroku {
  meta {
    name "heroku"
    description <<
      keroku notification
    >>
    author ""
    logging off
  }
  global {
   
  }
  rule firstRule {
    select when pageview ".*"
    notify("Jared Yarn", "Hey Yo I can do a Notify") with sticky = true;
  }
}
