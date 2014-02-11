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
    notify("Hello World", "This is a sample rule.") with sticky = true;
  }
}
