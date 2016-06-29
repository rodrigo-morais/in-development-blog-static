module Commands exposing (..)


import Models exposing (..)
import Messages exposing (..)


import Http
import Json.Decode as Json exposing ((:=))
import Task


getPosts : Cmd Msg
getPosts =
  let
    url =
      "https://in-development.firebaseio.com/posts.json"
  in
    Http.get (Json.list decodePost) url
    |> Task.perform FetchPostsFail FetchPostsSucceed


getPost : Int -> Cmd Msg
getPost id =
  let
    url =
      (Debug.log "getPost")
      "https://api.github.com/repos/staltz/staltz.github.io/git/blobs/18a318be389bbd85abc7804ce8d830d5ff5bbee5"
  in
    Http.get decodePostStatic url
    |> Task.perform FetchPostsFail FetchPostSucceed


decodePost : Json.Decoder Post
decodePost =
  Json.object3
    Post
    ("id" := Json.int)
    ("author" := Json.string)
    ("text" := Json.string)


decodePostStatic : Json.Decoder PostStatic
decodePostStatic =
  Json.object4
    PostStatic
    ("sha" := Json.string)
    ("size" := Json.string)
    ("url" := Json.string)
    ("content" := Json.string)