
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
  rule HelloWorld {
    select when web cloudAppSelected
  }
}
