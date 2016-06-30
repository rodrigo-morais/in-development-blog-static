module Models exposing (..)


import Routing.Models exposing (..)


type alias Post =
  { id : Int
  , author : String
  , text : String
  }

type alias PostStatic =
  { sha : String
  , size : String
  , url : String
  , content : String
  , encoding : String
  }


initialPost : Post
initialPost =
  { id = 0
  , author = ""
  , text = ""
  }


type alias Posts = List Post


type alias AppModel =
  { title : String
  , posts : Posts
  , post : String
  , location : Location
  , route : Route
  }


newAppModel : Route -> Location -> AppModel
newAppModel route location =
    { title = "Posts"
    , posts = []
    , post = ""
    , location = location
    , route = route
    }