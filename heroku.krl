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
    select when pageview ".*" {
    notify("Jared Yarn", "Hey Yo I can do a Notify") with sticky = true;
    notify("Jared Yarn Part 2", "Notifying Again and Again and Again") with sticky = true;
    }
  }
}
